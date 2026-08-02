M = {}

---@param head  string
---@param title string
local notif = function(head, title)
	-- hl.exec_cmd("notify-send -e -u low -i applications-games-symbolic " .. head .. " " .. title)
	hl.exec_cmd(string.format('notify-send -e -u low -i applications-games-symbolic "%s" "%s"', head, title))
end

---@return string
local get_scheduler = function()
	local handle = io.popen("scxctl get")
	local result = handle:read("*a")
	handle:close()

	return result:match("running (%w+)")
end

local toggle_waybar = function()
	hl.exec_cmd("pgrep -x waybar >/dev/null && killall waybar || waybar")
end


---@param schd string
local change_scheduler_to = function(schd)
	hl.exec_cmd("sudo scxctl stop && sudo scxctl start --sched " .. schd)
end

local disable_effects = function()
	hl.config({
		general = {
			gaps_in = 0,
			gaps_out = 0,
			border_size = 0,
		},

		animations = {
			enabled = false,
		},

		decoration = {
			shadow = { enabled = false },
			blur = { enabled = false },
			rounding = 0,
		},
	})
end

M.toggle_gamemode = function()
	local game_mode = (hl.get_config("animations.enabled") == false)

	if game_mode then
		hl.exec_cmd("hyprctl reload")
		local schd = "scx_bpfland"
		change_scheduler_to(schd)
		notif("Gamemode: disable", "scheduler: " .. get_scheduler())
		toggle_waybar()
	else
		disable_effects()
		local schd = "scx_lavd"
		change_scheduler_to(schd)
		notif("Gamemode: enable", "scheduler: " .. get_scheduler())
		toggle_waybar()
	end
end

return M
