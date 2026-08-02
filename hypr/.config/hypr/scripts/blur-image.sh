#!/usr/bin/env bash

set -e

STATE_DIR="$HOME/.local/state/hypr"
CURRENT_WALLPAPER="$STATE_DIR/current-wallpaper"
BLURRED_WALLPAPER="$STATE_DIR/blurred-wallpaper.png"

if [[ ! -f "$CURRENT_WALLPAPER" ]]; then
    echo "No current wallpaper found."
    exit 1
fi

WALLPAPER="$(cat "$CURRENT_WALLPAPER")"

if [[ ! -f "$WALLPAPER" ]]; then
    echo "Wallpaper file does not exist: $WALLPAPER"
    exit 1
fi

magick "$WALLPAPER" \
    -resize "640x360^" \
    -gravity center \
    -extent 640x360 \
    -blur 0x15 \
    -resize 1920x1080 \
    "$BLURRED_WALLPAPER"
