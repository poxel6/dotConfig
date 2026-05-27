return {
	{
		'navarasu/onedark.nvim',
		lazy = false,
		priority = 1000,
		opts = {
			style = 'dark',               -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
			transparent = true,           -- Show/hide background
			term_colors = true,           -- Change terminal color as per the selected theme style
			ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
			cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
			toggle_style_key = "<leader>cs",
			toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' },
			code_style = {
				comments = 'italic',
				keywords = 'none',
				functions = 'none',
				strings = 'none',
				variables = 'none'
			}
		}
	},
	{
		"oskarnurm/koda.nvim",
		lazy = false,
		priority = 1000
	},
	{
		"serhez/teide.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	},
	{
		"rafamadriz/neon",
		dependencies = { 'nvim-lualine/lualine.nvim' },
		lazy = false,
		priority = 1000,
		-- config = function ()
		-- 	require("lualine").setup({
		-- 		options = {
		-- 			theme = 'neon'
		-- 		}
		-- 	})
		-- end
	},
	{
		"sainnhe/edge",
		lazy = false,
		priority = 1000,
		opts = {}
	},
	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	},
	{
		"everviolet/nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"rockerBOO/boo-colorscheme-nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"datsfilipe/vesper.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	}
}
