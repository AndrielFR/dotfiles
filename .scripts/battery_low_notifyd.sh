#!/usr/bin/bash

low_level=20
very_low_level=10
sleep_time=60

low_notified=false
very_low_notified=false

while true; do
    # Check battery level
    level=$(acpi -b | rg '(\d+)%' -o | rg '(\d+)' -o)

    # Check if is low and not notified
    if [[ "$level" -le "$low_level" && "$low_notified" == false ]]; then
        # Send notification
        dunstify -t 1900 -u normal -r 10022 -i battery-low "Battery Low" "Please plug in the charger" -h int:value:"$level"

        # Play sound
        canberra-gtk-play -i window-attention -d "battery"

        # Set low_notified to avoid repeating the notification
        low_notified=true

    # Check if is very low and very low not notified
    elif [[ "$level" -le "$very_low_level" && "$very_low_notified" == false ]]; then
        # Send notification
        dunstify -t 1900 -u critical -r 10022 -i battery-low "Battery Very Low" "Plug in the charger now!" -h int:value:"$level"

        # Play sound
        canberra-gtk-play -i window-attention -d "battery"

        # Set very_low_notified to avoid repeating the notification
        very_low_notified=true

    # Check if is above low and low_notified
    elif [[ "$level" -gt "$low_level" && "$low_notified" == true ]]; then
        # Unset low_notified to allow the notification to be sent
        low_notified=false

    # Check if is above very_low and very_low_notified
    elif [[ "$level" -gt "$very_low_level" && "$very_low_notified" == true ]]; then
        # Unset very_low_notified to allow the notification to be sent
        very_low_notified=false

    fi

    sleep "$sleep_time"
done
