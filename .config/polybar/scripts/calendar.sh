#!/usr/bin/bash

month=$(date +"%m")
month=${month#0}
year=$(date +"%Y")

TMP=${XDG_RUNTIME_DIR:-/tmp}/"$UID"_poly_calendar_month
touch "$TMP"
diff=$(<"$TMP")

case $1 in
    "") diff=0;;
    "prev") (( diff -= 1 ));;
    "next") (( diff += 1 ));;
esac
echo "$diff" > "$TMP"

((month += diff))
echo "$month"
while [ "$month" -gt 12 ]; do
    (( month -= 12 ))
    (( year += 1 ))
done

while [ "$month" -lt 1 ]; do
    (( month += 12 ))
    (( year -= 1 ))
done

calendar=$(cal "$month" "$year")
if [ "$diff" -eq 0 ]; then
    calendar+="\n\nCurrent month"
    dunstify -t 8000 -u critical -r 10022 -i calendar "Calendar" "$calendar"
else
    if [ "$diff" -gt 0 ]; then
        calendar+="\n\n~$diff months later"
    else
        diff=$(( -diff ))
        calendar+="\n\n~$diff months ago"
    fi
    dunstify -u critical -r 10022 -i calendar "Calendar" "$calendar"
fi
