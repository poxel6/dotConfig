return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		local gs = require("gitsigns")
	-- gs
		vim.keymap.set('n', '<leader>gh', gs.preview_hunk_inline)
	end
}
