local main = "SUPER"
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

--------------------------------------------------------------------------------
-- Applications
--------------------------------------------------------------------------------

local terminal = "kitty"
local fileManager = "nemo"
local menu = "walker"
if require("laptop") then
	menu = "killall rofi || rofi -show drun"
end
local bar = "waybar"
local browser = "brave"
local scripts = "$HOME/.local/share/bin/"
local screenshot = "$HOME/.config/hypr/scripts/screenshot.sh"

---@param args string
local wallpaper = function(args)
	local scripts_path = "$HOME/.config/hypr/scripts/"
	local wallpaper_script = scripts_path .. "wallpaper.sh"
	local wallpaper_picker = scripts_path .. "wallpaper-picker.sh"
	----- %s $(%s %s) -> wallpaper_script $(wallpaper_picker args)
	return string.format("%s $(%s %s)", wallpaper_script, wallpaper_picker, args)
end

local toggle = function(app)
	return "pgrep -x " .. app .. " >/dev/null && killall " .. app .. " || " .. app
end

hl.bind(main .. " + Y", hl.dsp.exec_cmd(wallpaper("random")))
hl.bind(main .. " + SHIFT + Y", hl.dsp.exec_cmd(wallpaper("")))

hl.bind(main .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(main .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(main .. " + W", hl.dsp.exec_cmd(toggle(bar)))
hl.bind(main .. " + SPACE", hl.dsp.exec_cmd(menu))

hl.bind(main .. " + P", hl.dsp.exec_cmd("hyprctl dispatch pin"))
hl.bind(main .. " + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind(main .. " + E", hl.dsp.exec_cmd(fileManager .. " -g 1280x720"))
hl.bind(main .. " + D", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(main .. " + O", hl.dsp.exec_cmd("$HOME/.local/share/bin/record"))
hl.bind(main .. " + X", hl.dsp.exec_cmd("$HOME/.local/share/bin/rofi-music"))
hl.bind(main .. " + Z", hl.dsp.exec_cmd("walker -m symbols"))
hl.bind(main .. " + R", hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))

hl.bind(main .. " + Q", hl.dsp.window.close())
hl.bind(main .. " + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind(main .. "+ TAB",       hl.dsp.group.next())
hl.bind(main .. "+ SHIFT + TAB", hl.dsp.group.prev())

hl.bind(
	main .. " + RETURN",
	hl.dsp.window.fullscreen({
		mode = "fullscreen",
		action = "toggle",
	})
)

hl.bind(main .. " + SHIFT + W", hl.dsp.exec_cmd(scripts .. "configure_waybar"))

---@diagnostic disable-next-line: unresolved-require
hl.bind("F12", require("gamemode").toggle_gamemode)

hl.bind(main .. " + N", hl.dsp.workspace.toggle_special("special"))
hl.bind(main .. " + SHIFT + N", hl.dsp.window.move({ workspace = "special:special" }))

hl.bind(main .. " + S", hl.dsp.exec_cmd(screenshot), { locked = true })
hl.bind(main .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot .. " Area"), { locked = true })
hl.bind(main .. " + CTRL + S", hl.dsp.exec_cmd(screenshot .. " Monitor"), { locked = true })

hl.bind(main .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(main .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(main .. " + J", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(main .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(main .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(main .. " + CTRL + L", hl.dsp.window.resize({ x = 30, y = 0 }), { repeating = true })

hl.bind(main .. " + CTRL + H", hl.dsp.window.resize({ x = -30, y = 0 }), { repeating = true })

hl.bind(main .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -30 }), { repeating = true })

hl.bind(main .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 30 }), { repeating = true })

hl.bind(main .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(main .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(main .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(main .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness +10"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -10"), { repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl stop"), { locked = true })
