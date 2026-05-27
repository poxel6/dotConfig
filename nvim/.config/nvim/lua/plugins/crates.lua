return {
	'saecki/crates.nvim',
	tag = 'stable',
	lazy = true,
	event = { "BufRead Cargo.toml" },
	config = function ()
		require('crates').setup()
	end
}
