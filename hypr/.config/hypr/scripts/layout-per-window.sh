#!/usr/bin/env bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -U UNIX-CONNECT:"$SOCKET" | while read -r line; do
    case "$line" in
        activewindow>>org.telegram.desktop,*)
            hyprctl switchxkblayout current 1
            ;;
        activewindow>>*)
            hyprctl switchxkblayout current 0
            ;;
    esac
done
