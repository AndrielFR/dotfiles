#!/usr/bin/bash

greenclip="$(greenclip print)"
selected=$(echo "$greenclip" | rofi -dmenu -p "" -l 10 -format i -theme-str "configuration { show-icons: false; } window { width: 550px; } listview { columns: 1; }")

[[ -z $selected ]] && exit

(( selected++ ))
line=$(echo "$greenclip" | sed -n "${selected}p;")
greenclip print "$line"

xdotool type --window "$(xdotool getactivewindow)" "$line"
