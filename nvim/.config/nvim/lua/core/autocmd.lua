vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual' })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "When client attaches to the server",
	callback = function()
		vim.notify(string.format("Attached to %s", vim.lsp.get_clients()[1].name))
	end,
})

vim.api.nvim_create_user_command("Chmod", '!chmod +x %', {})

