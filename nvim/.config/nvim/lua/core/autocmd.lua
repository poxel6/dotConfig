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

vim.api.nvim_create_autocmd({ "ColorScheme", "BufRead" }, {
	desc = "When ColorScheme is changed, source my color patches.",
	callback = function()
		require("core.colors").setup()
	end,
})
