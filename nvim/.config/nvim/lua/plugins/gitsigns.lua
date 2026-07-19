return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = function()
		local gs = require("gitsigns")
		vim.keymap.set({ "x", "n" }, "<leader>gh", gs.preview_hunk_inline)
	end,
}
