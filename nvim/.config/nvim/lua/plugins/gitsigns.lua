---@diagnostic disable: undefined-field
return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
	config = function()
		local gs = require("gitsigns")
		vim.keymap.set("n", "]h", gs.next_hunk)
		vim.keymap.set("n", "[h", gs.prev_hunk)
		vim.keymap.set("n", "<leader>gh", gs.preview_hunk_inline)
		vim.keymap.set("n", "<leader>gb", gs.blame_line)
		vim.keymap.set("n", "<leader>gd", gs.diffthis)
		vim.keymap.set("n", "<leader>gs", gs.stage_hunk)
		vim.keymap.set("n", "<leader>gr", gs.reset_hunk)
	end,
}
