vim.opt.fillchars:append({
	fold = " ",
	foldopen = "",
	foldclose = "",
})
function foldtext()
	local line = vim.fn.getline(vim.v.foldstart)
	local lines = vim.v.foldend - vim.v.foldstart

	return line .. "  ...  " .. lines .. " lines"
end

vim.opt.foldtext = "v:lua.foldtext()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.fillchars:append({ fold = " " })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})
