#!/usr/bin/bash

MONITOR="HDMI-1"
MAIN_MONITOR="eDP-1"

open_menu() {
    selected=$(echo "󰹑  💻 Extend to left
💻 󰹑  Mirror
💻 󰹑  Extend to right
💻 Off" | rofi -dmenu -p "Monitor setup:" -l 2 -format i -theme-str "configuration { show-icons: false; } window { width: 370px; }")

    [[ -z $selected ]] && exit

    if [ "$selected" -eq 0 ]; then
        xrandr --output $MONITOR --auto --left-of "$MAIN_MONITOR"
    elif [ "$selected" -eq 1 ]; then
        xrandr --output $MONITOR --auto --same-as "$MAIN_MONITOR"
    elif [ "$selected" -eq 2 ]; then
        xrandr --output $MONITOR --auto --right-of "$MAIN_MONITOR"
    elif [ "$selected" -eq 3 ]; then
        xrandr --output $MONITOR --off
    fi
}

if xrandr | rg "$MONITOR disconnected" &> /dev/null; then
    xrandr --output $MONITOR --off
else
    open_menu
fi
