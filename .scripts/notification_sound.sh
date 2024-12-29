#!/usr/bin/bash

apps="Whatsapp Telegram Discord Matrix"
for app in $apps; do
    if [[ "$DUNST_APPNAME" =~ $app ]] || [[ "$DUNST_SUMMARY" =~ $app ]]; then
        exit 0
    fi
done

if [[ "$DUNST_URGENCY" == "critical" ]]; then
    canberra-gtk-play -i message-new-instant -d "newnotification"
else
    canberra-gtk-play -i message -d "newnotification"
fi

exit 1
