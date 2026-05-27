require "telescope".setup({
	defaults = {
		preview = false,
		file_ignore_patterns = {
			"target/",
			"bin/",
			"node_modules/",
			"build/",
		},
	},
	pickers = {},
	extensions = {}
})

require "telescope".load_extension("ui-select")
require "telescope".load_extension("fzy_native")

