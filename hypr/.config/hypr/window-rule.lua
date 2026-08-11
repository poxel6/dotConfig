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
