return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
	},
	opts = {
		settings = {
			expose_as_code_action = "all",
		},
	},
}
