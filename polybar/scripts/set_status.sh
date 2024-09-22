#!/bin/bash

[[ -z $PLAYERCTL_STATUS ]] && PLAYERCTL_STATUS="1"

PLAYERCTL_STATUS="$(playerctl status | sed 's/Playing/1/;s/Paused/2/;s/Stopped/2/')"

if [[ $PLAYERCTL_STATUS == "1" ]]; then # Playing
    playerctl pause
    polybar-msg hook mpris-play-pause 1
elif [[ $PLAYERCTL_STATUS == "2" ]]; then # Paused
    playerctl play
    polybar-msg hook mpris-play-pause 2
fi
