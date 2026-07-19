return {
	"saghen/blink.cmp",
	event = { "InsertEnter" },
	dependencies = { "L3MON4D3/LuaSnip" },
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<C-x><C-o>"] = { "show_and_insert_or_accept_single" },
			["<C-q>"] = { "show", "show_documentation", "hide_documentation" },
		},
		completion = {
			documentation = { window = { scrollbar = false, max_width = 35 } },
			menu = {
				max_height = 9,
				scrollbar = false,
				draw = {
					align_to = "label",
					columns = { { "label", gap = 3 }, { "kind_icon" }, { "kind" } },
					components = {
						label = { ellipsis = true, width = { fill = false, min = 30, max = 35 } },
					},
				},
			},
		},
		sources = {
			default = { "lazydev", "lsp", "path", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},
}
