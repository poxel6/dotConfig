hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "auto",
	scale = "auto",
})

hl.monitor({
	output = "DP-3",
	mode = "1600x900@60",
	position = "1600x0",
	scale = "auto",
})

hl.config({
	general = {
		gaps_in = 10,
		gaps_out = { top = 5, bottom = 10, right = 10, left = 10 },
		border_size = 2,
		resize_on_border = true,
		allow_tearing = false,
		layout = "master",
	},

	---@type HL.ConfigOpt.Decoration
	decoration = {
		rounding = 4,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			noise = 0.0,
		},
	},

	binds = {
		movefocus_cycles_fullscreen = true,
	},

	group = {
		col = {
			border_active = "rgba(ffffff33)",
			border_inactive = "rgba(ffffff33)",
			border_locked_active = "rgba(ffffff33)",
			border_locked_inactive = "rgba(ffffff33)",
		},

		groupbar = {
			enabled = true,
			height = 2,
			gradients = false,
			font_size = 1,
			indicator_height = 2,
			text_color = "rgba(ffffff00)",
			col = {
				active = "rgba(ffffff00)",
				inactive = "rgba(ffffff00)",
				locked_active = "rgba(ffffff00)",
				locked_inactive = "rgba(ffffff00)",
			},
		},
	},
})

hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},

	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.config({
	---@type HL.ConfigOpt.Input
	input = {
		kb_layout = "us,ir",
		kb_variant = ",winkeys",
		kb_model = "",
		kb_options = "grp:rwin_toggle",
		kb_rules = "",

		follow_mouse = 1,
		force_no_accel = 1,

		sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.
	},
})

hl.workspace_rule({ workspace = "1", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({
	workspace = "special:special",
	no_border = true,
	on_created_empty = "kitty",
	gaps_out = {
		top = 20,
		left = 20,
		right = 20,
		bottom = 20,
	},
})

local _suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

require("window-rule")
require("binds")
require("startup")
require("animations")
require("events")
