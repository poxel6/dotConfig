-- TODO: This is not working as expected
-- It should create a split buffer and run it everytime I save
-- and I should populate the quick fix
local buf
local win
local job
local start_time

local ns = vim.api.nvim_create_namespace("autorun")

local create_buffer = function()
	if buf and vim.api.nvim_buf_is_valid(buf) then
		return
	end

	buf = vim.api.nvim_create_buf(false, true)

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = true
	vim.bo[buf].buflisted = false
	vim.api.nvim_buf_set_name(buf, "AutoRun Output")
end

local open_window = function()
	if win and vim.api.nvim_win_is_valid(win) then
		return
	end

	win = vim.api.nvim_open_win(buf, false, {
		split = "right",
		win = 0,
	})

	vim.wo[win].number = false
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
end

local set_output = function(lines)
	if vim.api.nvim_buf_is_valid(buf) then
		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

		if win and vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_set_cursor(win, { #lines, 0 })
		end
	end
end

local append_output = function(data)
	local lines = {}

	for _, line in ipairs(data) do
		if line ~= "" then
			table.insert(lines, line)
		end
	end

	if #lines > 0 then
		vim.schedule(function()
			vim.bo[buf].modifiable = true
			vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)

			if win and vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
			end
		end)
	end
end

local finish_output = function(code)
	local time = os.date("%a %b %d %H:%M:%S")
	local duration = (vim.loop.hrtime() - start_time) / 1e9

	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

	table.insert(lines, "")

	local msg

	if code == 0 then
		msg = string.format("Compilation finished at %s, duration %.2f s", time, duration)
	else
		msg = string.format("Compilation exited abnormally with code %d at %s, duration %.2f s", code, time, duration)
	end

	table.insert(lines, msg)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	local row = #lines - 1

	if code == 0 then
		local start_col, end_col = msg:find("finished")

		vim.api.nvim_buf_set_extmark(buf, ns, row, start_col - 1, {
			end_col = end_col,
			hl_group = "DiagnosticOk",
		})
	else
		local start_col, end_col = msg:find("exited abnormally")

		vim.api.nvim_buf_set_extmark(buf, ns, row, start_col - 1, {
			end_col = end_col,
			hl_group = "DiagnosticError",
		})

		local code_start, code_end = msg:find(tostring(code))

		vim.api.nvim_buf_set_extmark(buf, ns, row, code_start - 1, {
			end_col = code_end,
			hl_group = "ErrorMsg",
		})
	end

	vim.bo[buf].modifiable = false
	vim.bo[buf].readonly = true

	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_set_cursor(win, { #lines, 0 })
	end
end

local job_opts = {
	on_stdout = function(_, data)
		append_output(data)
	end,

	on_stderr = function(_, data)
		append_output(data)
	end,

	on_exit = function(_, code)
		job = nil

		vim.schedule(function()
			finish_output(code)
		end)
	end,
}

vim.api.nvim_create_user_command("AutoRun", function(opts)
	create_buffer()
	open_window()

	if job then
		vim.fn.jobstop(job)
	end

	vim.bo[buf].modifiable = true
	vim.bo[buf].readonly = false

	local cmd = table.concat(opts.fargs, " ")

	set_output({ cmd })

	start_time = vim.loop.hrtime()

	job = vim.fn.jobstart({ "sh", "-c", cmd }, job_opts)
end, {
	nargs = "*",
})
