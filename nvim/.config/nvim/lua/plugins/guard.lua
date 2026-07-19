return {
	"nvimdev/guard.nvim",
	dependencies = {
		"nvimdev/guard-collection",
	},
	cmd = "Guard",
	config = function()
		local ft = require("guard.filetype")
		ft("lua"):fmt("stylua")
		ft("python"):fmt("isort"):append("black")
		-- ft('typescript,javascript,typescriptreact')
		-- 	:fmt('biome')
		-- 	:append('prettierd')
		ft("c,cpp"):fmt({
			cmd = "clang-format",
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
		})

		vim.keymap.del({ "x", "v", "n" }, "gro")
		vim.keymap.set({ "x", "v", "n" }, "gro", ":Guard fmt<CR>", { silent = true })
	end,
}
