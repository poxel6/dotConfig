return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"gro",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
		},
	},

	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black", lsp_format = "last" },
			javascript = { "biome", "prettierd", lsp_format = "last" },
			javascriptreact = { "biome", "prettierd", lsp_format = "last" },
			typescript = { "biome", "prettierd", lsp_format = "last" },
			typescriptreact = { "biome", "prettierd", lsp_format = "last" },
			c = { "clang_format", lsp_format = "fallback" },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = { timeout_ms = 500 },
		formatters = {
			clang_format = {
				command = "clang-format",
				args = {
					[[--style={
	BasedOnStyle: Google,
	AlignArrayOfStructures: Left,
	IndentWidth: 4,
	AllowShortFunctionsOnASingleLine: None,
	AllowShortBlocksOnASingleLine: Never,
	AllowShortIfStatementsOnASingleLine: Never,
	AllowShortLoopsOnASingleLine: false,
	AllowShortEnumsOnASingleLine: false
}]],
				},
				stdin = true,
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" -- If you want the formatexpr, here is the place to set it
		end,
	},
}
