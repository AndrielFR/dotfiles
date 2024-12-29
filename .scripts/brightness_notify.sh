#!/usr/bin/bash

brightness="$(brightnessctl g backlight)"
brightness_max="$(brightnessctl m backlight)"

# Normalize value
brightness=$((brightness*100/brightness_max))

if [ "$brightness" -gt 75 ]; then
    dunstify -t 1900 -u normal -r 10020 -i display-brightness-high-symbolic "Display" "Brightness: $brightness%" -h int:value:"$brightness"
elif [ "$brightness" -gt 40 ]; then
    dunstify -t 1900 -u normal -r 10020 -i display-brightness-medium-symbolic "Display" "Brightness: $brightness%" -h int:value:"$brightness"
elif [ "$brightness" -gt 0 ]; then
    dunstify -t 1900 -u normal -r 10020 -i display-brightness-low-symbolic "Display" "Brightness: $brightness%" -h int:value:"$brightness"
else
    dunstify -t 1900 -u normal -r 10020 -i display-brightness-off-symbolic "Display" "Brightness: $brightness%" -h int:value:1
fi
