#!/usr/bin/bash

filename="$(date +'%X_%d-%m-%Y').png"
filepath="$(xdg-user-dir PICTURES)/Screenshots/$filename"

shotgun -f png -s "$filepath"

# Play sound
canberra-gtk-play -i screen-capture -d "screenshot"

# Send notification
dunstify -t 1900 -u critical -i "$filepath" "Screenshot" "Saved at $filepath"
