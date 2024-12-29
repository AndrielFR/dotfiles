#!/usr/bin/bash

# Get volume
volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | rg -o -e '(\d.*)')"

if [[ $volume =~ \[MUTED\] ]]; then # Muted
    volume="muted"
elif [[ $volume != "muted" ]]; then # Normalize value
    volume="$(echo "$volume * 100" | bc)" # Walk floors
    volume=${volume%.*} # Convert float to integer
fi

# Check volume
if [ "$volume" -gt 75 ]; then
    dunstify -t 1900 -u normal -r 10020 -i audio-volume-high-symbolic "Speaker" "Volume: $volume%" -h int:value:"$volume"
elif [ "$volume" -gt 40 ]; then
    dunstify -t 1900 -u normal -r 10020 -i audio-volume-medium-symbolic "Speaker" "Volume: $volume%" -h int:value:"$volume"
elif [ "$volume" -gt 0 ]; then
    dunstify -t 1900 -u normal -r 10020 -i audio-volume-low-symbolic "Speaker" "Volume: $volume%" -h int:value:"$volume"
else
    dunstify -t 1900 -u normal -r 10020 -i audio-volume-muted-symbolic "Speaker" "Volume: $volume" -h int:value:1
fi

# Play sound
canberra-gtk-play -i audio-volume-change -d "changevolume"
