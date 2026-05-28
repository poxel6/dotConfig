return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			"LazyVim",
			-- "/usr/share/nvim/runtime",
			-- "~/.local/share/nvim/site/pack/core/opt/",
			-- "~/.local/share/nvim/lazy/"
		}
	}
}
