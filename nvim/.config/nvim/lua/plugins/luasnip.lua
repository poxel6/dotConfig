return {
	"L3MON4D3/LuaSnip",
	lazy = true,
	event = "InsertEnter",
	config = function ()
		local ls = require("luasnip")
		ls.setup()
		ls.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			override_builtin = true
		})
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
	end
}
