return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"lewis6991/async.nvim",
	},
	cmd = {
		"Refactor",
		"RefactorExtract",
		"RefactorExtractFunction",
	},
	keys = {
		{
			"<leader>o",
			function()
				require("refactoring").select_refactor()
			end,
			desc = "Do something",
			mode = { "n", "x" },
		},
	},
}
