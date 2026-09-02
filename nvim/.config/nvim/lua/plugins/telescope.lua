---@diagnostic disable: undefined-field, unresolved-require

local height = 0.2

return {
	"nvim-telescope/telescope.nvim",
	cmd = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
	},
	keys = {
		{
			"<leader>sf",
			function()
				require("telescope.builtin").find_files(
					require("telescope.themes").get_ivy({ layout_config = { height = height } })
				)
			end,
		},
		{
			"<leader>sh",
			function()
				require("telescope.builtin").help_tags(
					require("telescope.themes").get_ivy({ layout_config = { height = height } })
				)
			end,
		},
		{
			"<leader>sl",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>st",
			function()
				require("telescope.builtin").colorscheme(require("telescope.themes").get_ivy({
					enable_preview = true,
					ignore_builtins = true,
					preview = false,
				}))
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				preview = false,
				file_ignore_patterns = {
					"target/",
					"node_modules/",
					"build/",
					"lazy-lock.json",
					"Cargo.lock",
				},
			},
			pickers = {},
			extensions = {},
		})
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("fzy_native")
	end,
}
