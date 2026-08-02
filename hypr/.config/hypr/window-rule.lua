--------------------------------------------------------------------------------
-- Layer Rules
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Workspace Assignment Rules
--------------------------------------------------------------------------------

hl.window_rule({
	match = { class = "com.mitchellh.ghostty" },
	workspace = "1",
})

hl.window_rule({
	match = { class = "zen" },
	workspace = "2",
})

hl.window_rule({
	match = { class = "intellij" },
	workspace = "3",
})

hl.window_rule({
	match = { class = "obsidian" },
	workspace = "4",
})

hl.window_rule({
	match = { class = "com.github.rafostar.Clapper" },
	workspace = "5",
})

--------------------------------------------------------------------------------
-- Floating Windows
--------------------------------------------------------------------------------

hl.window_rule({
	match = { class = "com.saivert.pwvucontrol" },
	float = true,
})

hl.window_rule({
	match = { class = "nm-connection-editor" },
	float = true,
})

hl.window_rule({
	match = {
		title = "Extension:(Bitwarden Password Manager) - Bitwarden - Zen Browser",
	},
	float = true,
})

hl.window_rule({
	match = { class = "imv" },
	float = true,
})

hl.window_rule({
	match = { class = "org.Waytrogen.Waytrogen" },
	float = true,
})

hl.window_rule({
	match = { class = "nemo" },
	float = true,
})

hl.window_rule({
	match = { class = "Tk" },
	float = true,
})

hl.window_rule({
	match = { class = "org.kde.kdeconnect.daemon" },
	float = true,
})

hl.window_rule({
	match = { class = "custom-updater" },
	float = true,
})

hl.window_rule({
	match = { class = "custom-fastfetch" },
	float = true,
})

--------------------------------------------------------------------------------
-- Workspace → Monitor Binding
--------------------------------------------------------------------------------

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
