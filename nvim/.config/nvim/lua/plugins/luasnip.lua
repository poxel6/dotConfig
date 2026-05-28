return {
	'L3MON4D3/LuaSnip',
	lazy = true,
	event = "InsertEnter",
	config = function()
		require "config.luasnip"
	end
}
