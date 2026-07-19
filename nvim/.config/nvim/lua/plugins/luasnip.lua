return {
	"L3MON4D3/LuaSnip",
	lazy = true,
	event = "InsertEnter",
	config = function()
		require("luasnip").setup()
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
	end,
}
