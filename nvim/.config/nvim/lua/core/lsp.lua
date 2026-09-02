---@return string[]
local get_lsp_files = function()
	local lsp_path = vim.fn.stdpath("config") .. "/after/lsp"
	local lsp_files_with_extensions = vim.fn.readdir(lsp_path)
	local lsp_files = {}
	for index, value in ipairs(lsp_files_with_extensions) do
		lsp_files[index] = value:gsub("%.lua", "")
	end
	return lsp_files
end

vim.lsp.enable(get_lsp_files())
-- vim.lsp.enable({
-- 	"basedpyright",
-- 	"bashls",
-- 	"biome",
-- 	"clangd",
-- 	"cssls",
-- 	"css_variables",
-- 	"emmet_language_server",
-- 	"emmylua_ls",
-- 	"jdtls",
-- 	"jsonls",
-- 	"markdown_oxide",
-- 	"marksman",
-- 	"oxlint",
-- 	"ruff",
-- 	"rust_analyzer",
-- 	"superhtml",
-- 	"tailwindcss",
-- 	"taplo",
-- 	"tinymist",
-- 	"ts_ls",
-- 	"ty",
-- 	"vtsls",
-- 	"yamlls",
-- 	"zls",
-- })
