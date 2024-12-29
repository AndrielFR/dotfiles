#!/usr/bin/bash

selected=$(
echo "󰹑     Entire screen, save to folder
󱂬     Current window, save to folder
󰒉     Select area, save to folder
󰹑  󰅌   Entire screen, copy to clipboard
󱂬  󰅌   Current window, copy to clipboard
󰒉  󰅌   Select area, copy to clipboard" | rofi -dmenu -p "Screenshot:" -l 6 -format i -theme-str "configuration { show-icons: false; } window { width: 320px; }")

[[ -z $selected ]] && exit

if [ "$selected" -lt 3 ]; then
    filename="$(date +'%X_%d-%m-%Y').png"
    filepath="$(xdg-user-dir PICTURES)/Screenshots/$filename"
fi

sleep 1

if [ "$selected" -eq 0 ]; then
    shotgun -f png -s "$filepath"
elif [ "$selected" -eq 1 ]; then
    shotgun -f png -i "$(xdotool getactivewindow)" "$filepath"
elif [ "$selected" -eq 2 ]; then
    shotgun -f png -g "$(slop -f '%g')" "$filepath"
elif [ "$selected" -eq 3 ]; then
    shotgun -f png -s - | xclip -selection clipboard -target image/png -i
elif [ "$selected" -eq 4 ]; then
    shotgun -f png -i "$(xdotool getactivewindow)" - | xclip -selection clipboard -target image/png -i
elif [ "$selected" -eq 5 ]; then
    shotgun -f png -g "$(slop -f '%g')" - | xclip -selection clipboard -target image/png -i
fi

# Play sound
canberra-gtk-play -i screen-capture -d "screenshot"

# Send notification
if [ "$selected" -le 3 ]; then
    dunstify -t 1900 -u critical -i "$filepath" "Screenshot" "Saved at $filepath"
else
    dunstify -t 1900 -u critical -i image "Screenshot" "Copied to clipboard"
fi
