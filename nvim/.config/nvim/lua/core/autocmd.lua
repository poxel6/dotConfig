---@diagnostic disable: undefined-field
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual" })
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	desc = "When client attaches to the server",
-- 	callback = function()
-- 		local clients = vim.lsp.get_clients()
-- 		for _, v in ipairs(clients) do
-- 			vim.notify(string.format("Attached to %s", v.name))
-- 		end
-- 	end,
-- })
--
vim.api.nvim_create_user_command("Chmod", "!chmod +x %", {})

vim.api.nvim_create_user_command("Term", function()
	local buf = vim.api.nvim_create_buf(false, true)
	if buf == 0 then
		vim.notify("Something went wrong.", vim.log.levels.ERROR)
		return
	end

	_ = vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
	vim.cmd.startinsert()

	local job = vim.fn.jobstart(vim.o.shell, {
		term = true,
	})
	local enter = function()
		return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
	end
	vim.api.nvim_chan_send(job, "clear" .. enter())
end, {
	nargs = 0,
	force = false,
})

local is_toggle = false
local job
vim.api.nvim_create_user_command("AutoRun", function(opts)
	local buf = vim.api.nvim_create_buf(false, true)
	if buf == 0 then
		vim.notify("Something went wrong.", vim.log.levels.ERROR)
		return
	end

	local enter = function()
		return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
	end

	local currwin
	if not is_toggle then
		currwin = currwin or vim.api.nvim_get_current_win()
		_ = vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
		is_toggle = true
	end

	job = job or vim.fn.jobstart(vim.o.shell, {
		term = true,
	})

	vim.api.nvim_chan_send(job, "clear" .. enter())

	local args = table.concat(opts.fargs, " ")
	if args ~= " " then
		vim.api.nvim_chan_send(job, args .. enter())
	end

	if currwin then
		vim.api.nvim_set_current_win(currwin)
	end
end, {
	nargs = "*",
	force = false,
})

vim.api.nvim_create_autocmd({ "ColorScheme", "BufRead" }, {
	desc = "When ColorScheme is changed, source my color patches.",
	callback = function()
		require("core.colors").setup()
	end,
})

local path = vim.fn.stdpath("config") .. "/after/template"
for skeleton in vim.fs.dir(path, {}) do
	local list = vim.split(skeleton, ".", { plain = true })
	local ext = list[#list]
	local pattern = "{{CURSOR}}"
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = "*." .. ext,
		desc = "template for '" .. ext .. "' files.",
		callback = function()
			vim.api.nvim_buf_set_lines(0, 0, 0, true, {})
			vim.cmd("0r " .. path .. "/skeleton." .. ext)
			for lnum = 1, vim.api.nvim_buf_line_count(0) do
				local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
				local col = line:find(pattern, 1, true)
				if col then -------------------- row ----- col ---- end_row  end_col - offset __ content
					vim.api.nvim_buf_set_text(0, lnum - 1, col - 1, lnum - 1, col - 1 + #pattern, {})
					vim.api.nvim_win_set_cursor(0, { lnum, col - 1 })
					return
				end
			end
		end,
	})
end
