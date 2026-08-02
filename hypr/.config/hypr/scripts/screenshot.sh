#!/usr/bin/env bash

which rofi >/dev/null 			|| sudo pacman -S --needed rofi
which hyprshade >/dev/null 		|| sudo pacman -S --needed hyprshade
which imv >/dev/null 			|| sudo pacman -S --needed imv
which notify-send >/dev/null 	|| sudo pacman -S --needed libnotify
which grimblast >/dev/null 		|| yay -S --needed grimblast-git

PICTURES="$HOME/Pictures"

restore_shader() {
	if [ -n "$shader" ]; then
		hyprshade on "$shader"
	fi
}

save_shader() {
	shader=$(hyprshade current)
	hyprshade off
	trap restore_shader EXIT
}

save_shader

save_dir="$PICTURES/screenshots/$(date +'%Y_%m_%d')/"
save_file=screenshot_$(date '+%Hh%Mm%Ss').png
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir

if [[ $# != 0 ]]; then
	result=$1
else
	result=$(echo \
		"Area
Frozen
Monitor
All Monitors" | rofi -dmenu)
fi

case $result in
"All Monitors")
	notify-send "Screenshot of Screens" "Screenshot has been copies to your clipboard" -a grimblast -u low
	grimblast copysave screen $temp_screenshot && restore_shader
	;;
Area)
	notify-send "Screenshot of Area" "Screenshot has been copies to your clipboard" -a grimblast -u low
	grimblast copysave area $temp_screenshot && restore_shader
	;;
Frozen)
	notify-send "Screenshot of frozen Area" "Screenshot has been copies to your clipboard" -a grimblast -u low
	grimblast --freeze copysave area $temp_screenshot && restore_shader
	;;
Monitor)
	notify-send "Screenshot of Screen" "Screenshot has been copies to your clipboard" -a grimblast -u low
	grimblast copysave output $temp_screenshot && restore_shader
	;;
*)
	exit 0
	;;
esac

mv "$temp_screenshot" "$save_dir/$save_file"
imv "$save_dir/$save_file"

if [ -f "${save_dir}/${save_file}" ]; then
	notify-send -a "t1" -i "${save_dir}/${save_file}" "saved in ${save_dir}"
fi
