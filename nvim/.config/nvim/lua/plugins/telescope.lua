return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		'nvim-telescope/telescope-fzy-native.nvim',
	},
	config = function()
		require "config.telescope"
	end
}
