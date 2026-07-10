return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		local gs = require("gitsigns")
		vim.keymap.set({ "x", "n" }, "<leader>gh", gs.preview_hunk_inline)
	end,
}
