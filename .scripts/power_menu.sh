#!/usr/bin/bash

selected=$(
echo "󰹿  Cancel
  Lock
󰤄  Suspend
  Reboot
⏻  Shutdown" | rofi -dmenu -p "Power menu:" -l 5 -format i -theme-str "configuration { show-icons: false; } window { width: 320px; }")

[[ -z $selected ]] && exit

if [ "$selected" -eq 0 ]; then
    exit
elif [ "$selected" -eq 1 ]; then
    betterlockscreen -l dimblur -- --composite
elif [ "$selected" -eq 2 ]; then
    systemctl suspend
elif [ "$selected" -eq 3 ]; then
    systemctl reboot
elif [ "$selected" -eq 4 ]; then
    systemctl poweroff
fi
