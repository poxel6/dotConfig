require("binds")

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
		top = 5,
		left = 10,
		right = 10,
		bottom = 10,
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

hl.on("window.active", function(window)
	if window.class == "org.telegram.desktop" then
		hl.exec_cmd("hyprctl switchxkblayout current 1")
	else
		hl.exec_cmd("hyprctl switchxkblayout current 0")
	end
end)

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("swaync")
	hl.exec_cmd("elephant")
	hl.exec_cmd("waypaper --restore --no-post-command")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("walker --gapplication-service")

	-- Consider making these systemd user services instead.
	hl.exec_cmd("sudo systemctl start keyd")

	hl.exec_cmd("/usr/bin/kdeconnectd")
	hl.exec_cmd("mpd")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("keyd-application-mapper -d")
	hl.exec_cmd("gamemoded -d")
end)
hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("myBezier", {
	type = "bezier",
	points = {
		{ 0.05, 0.90 },
		{ 0.10, 1.05 },
	},
})

hl.curve("ease-io-sine", {
	type = "bezier",
	points = {
		{ 0.455, 0.03 },
		{ 0.515, 0.955 },
	},
})

hl.curve("qubic-bezier", {
	type = "bezier",
	points = {
		{ 0.755, 0.05 },
		{ 0.855, 0.06 },
	},
})

hl.curve("ease-in-back", {
	type = "bezier",
	points = {
		{ 0.6, -0.28 },
		{ 0.735, 0.045 },
	},
})

-- Smooth, snappy curve for group/window switching
hl.curve("group-switch", {
	type = "bezier",
	points = {
		{ 0.22, 1.00 },
		{ 0.36, 1.00 },
	},
})

-- Slight overshoot for newly grouped windows
hl.curve("group-in", {
	type = "bezier",
	points = {
		{ 0.16, 1.00 },
		{ 0.30, 1.08 },
	},
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4,
	bezier = "qubic-bezier",
	style = "gnomed",
})

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4,
	bezier = "ease-in-back",
	style = "slide",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 4,
	bezier = "ease-io-sine",
	style = "popin 30%",
})

-- Smooth movement when switching between grouped windows
hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 3,
	bezier = "group-switch",
})

-- Tiny fade when changing the active window in a group
hl.animation({
	leaf = "fadeSwitch",
	enabled = true,
	speed = 2,
	bezier = "group-switch",
})

-- Slightly softer fade for newly appearing/grouped windows
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 3,
	bezier = "group-in",
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 1,
	bezier = "default",
})

hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 1,
	bezier = "default",
})

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 7,
	bezier = "default",
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1,
	bezier = "ease-io-sine",
	style = "slidefade 50%",
})

hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 2,
	bezier = "ease-io-sine",
	style = "slidefadevert 100%",
})
--------------------------------
--         Layer Rules        --
--------------------------------

hl.layer_rule({
	name = "rofi-no-anim-and-blur",
	match = {
		namespace = "rofi",
	},
	no_anim = true,
	blur = true,
	ignore_alpha = 0.1,
})

hl.layer_rule({
	name = "walker-no-anim",
	match = {
		namespace = "walker",
	},
	no_anim = true,
})

--------------------------------
-- Workspace Assignment Rules --
--------------------------------

hl.window_rule({
	match = { class = "Emacs" },
	workspace = "1",
})

hl.window_rule({
	match = { class = "brave-browser" },
	workspace = "2",
})

hl.window_rule({
	name = "brave-group",
	match = {
		class = "^brave-browser$",
	},
	group = "set always",
})

hl.window_rule({
	match = { class = "mpv" },
	workspace = "5",
})

--------------------------------
--      Floating Windows      --
--------------------------------

hl.window_rule({
	match = { class = "com.saivert.pwvucontrol" },
	float = true,
})

hl.window_rule({
	match = { class = "nm-connection-editor" },
	float = true,
})

hl.window_rule({
	match = { class = "imv" },
	float = true,
})

hl.window_rule({
	match = { class = "nemo" },
	float = true,
})

hl.window_rule({
	match = { class = "org.kde.kdeconnect.daemon" },
	float = true,
})

hl.window_rule({
	match = { class = "me-pox-ateroids-Asteroid" },
	float = true,
})

--------------------------------
--          Workspace         --
--------------------------------
hl.workspace_rule({
	workspace = "1",
	monitor = "DP-2",
})

hl.workspace_rule({
	workspace = "2",
	monitor = "DP-2",
})

hl.workspace_rule({
	workspace = "3",
	monitor = "DP-2",
})

hl.workspace_rule({
	workspace = "4",
	monitor = "DP-3",
})

hl.workspace_rule({
	workspace = "6",
	monitor = "DP-3",
})
