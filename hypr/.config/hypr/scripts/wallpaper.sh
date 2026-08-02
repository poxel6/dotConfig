#!/usr/bin/env bash

set -e

WALLPAPER="$1"
STATE_DIR="$HOME/.local/state/hypr"
CURRENT_WALLPAPER="$STATE_DIR/current-wallpaper"

mkdir -p "$STATE_DIR"

# Make sure a wallpaper was provided
if [[ -z "$WALLPAPER" ]]; then
	echo "Usage: $0 /path/to/wallpaper"
	exit 1
fi

# Make sure the file exists
if [[ ! -f "$WALLPAPER" ]]; then
	echo "Wallpaper does not exist: $WALLPAPER"
	exit 1
fi

# Convert to absolute path
WALLPAPER="$(realpath "$WALLPAPER")"

# Save current wallpaper
printf '%s\n' "$WALLPAPER" >"$CURRENT_WALLPAPER"

# Set wallpaper
awww img "$WALLPAPER" \
	--transition-bezier .43,1.19,1,1 \
	--transition-fps=60 \
	--transition-type=grow \
	--transition-duration=1 \
	--transition-pos "$(hyprctl cursorpos)"

"$HOME/.config/hypr/scripts/blur-image.sh"

# Notify when everything is finished successfully
notify-send \
	--app-name="Wallpaper" \
	--icon="$WALLPAPER" \
	--urgency=low \
	--expire-time=4000 \
	"Wallpaper Changed" \
	"Now displaying: $(basename $WALLPAPER)"
