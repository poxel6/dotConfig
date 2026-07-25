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
