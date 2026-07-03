return {
	'catgoose/nvim-colorizer.lua',
	event = "BufReadPre",
	opts = {
		options = {
			parsers = {
				css = true,                      -- preset: enables names, hex, rgb, hsl, oklch, css_var
				css_fn = true,                   -- preset: enables rgb, hsl, oklch
				css_color = { enable = true },   -- color() function (srgb, display-p3, a98-rgb, etc.)
				tailwind = {
					enable = true,       -- parse Tailwind color names
					update_names = true, -- feed LSP colors back into name parser (requires both enable + lsp.enable)
					lsp = { -- accepts boolean, true is shortcut for { enable = true, disable_document_color = true }
						enable = true,               -- use Tailwind LSP documentColor
						disable_document_color = true -- auto-disable vim.lsp.document_color on attach
					}
				},
				custom = {}                       -- list of custom parser definitions
			},
			display = {
				mode = "virtualtext",          -- string or list: "background"|"foreground"|"underline"|"virtualtext"
				virtualtext = {
					char = "󱓻",          -- character used for virtualtext
					position = "before",      -- "eol"|"before"|"after"
					hl_mode = "foreground" -- "background"|"foreground"
				},
			},
		}
	}
}
