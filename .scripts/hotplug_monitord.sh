#!/usr/bin/bash

monitor_address="/sys/class/drm/card1-HDMI-A-1"

asked=true

while true; do
    # Check monitor's status
    status=$(cat "$monitor_address"/status)

    # Check if is connected and not asked
    if [[ "$status" == "connected" && "$asked" == false ]]; then
        # Send notification
        dunstify -t 19000 -u critical -r 10023 -i video-display "Monitor connected" "Choose a layout for the monitor"

        # Play sound
        canberra-gtk-play -i window-attention -d "hotplug_monitor"

        # Run script to choose layout
        ~/.scripts/monitor_layout_menu.sh

        # Set asked to avoid asking again
        asked=true

    # Check if is disconnected and asked
    elif [[ "$status" == "disconnected" && "$asked" == true ]]; then
        # Send notification
        dunstify -t 19000 -u normal -r 10023 -i video-display "Monitor disconnected" "Returning to default layout..."

        # Play sound
        canberra-gtk-play -i window-attention -d "hotplug_monitor"

        # Run script to return to default layout
        ~/.scripts/monitor_layout_menu.sh

        # Unset asked to allow be asked
        asked=false

    fi
done
