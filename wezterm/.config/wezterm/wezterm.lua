local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()

config.font_size = 20
config.font = wezterm.font { family = 'ZedMono Nerd Font Mono', weight = 'Regular' }
config.color_scheme = 'Black Metal (Venom) (base16)'
config.window_background_image = 'c:/Users/PoXel6/Pictures/Wallpapers/wifu/menace-looking-wifu.jpg'
config.text_background_opacity = 1.0
config.enable_tab_bar = false
config.default_prog = { 'C:/Program Files/WSL/wsl.exe', '--user', 'conch', '--cd', '~' }
config.treat_left_ctrlalt_as_altgr = true
config.use_dead_keys = false
config.disable_default_key_bindings = true
-- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
	-- { key = "a", mods = "CTRL", action = act.SendString("\x01") },
	{ key = "Enter", mods = "CTRL", action = act.ToggleFullScreen },
	{ key = 'P', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCommandPalette },
	{ key = 'W', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = false } },
	{ key = 'Z', mods = 'CTRL|SHIFT', action = wezterm.action.TogglePaneZoomState },
	{ key = "5", mods = "CTRL|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = '"', mods = "CTRL|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = 'C', mods = 'CTRL', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
	{ key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
}

wezterm.on('gui-startup', function (cmd)
	local _, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
