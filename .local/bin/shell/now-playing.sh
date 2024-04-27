#!/bin/sh

players=$(playerctl -l | grep -v "kdeconnect" | sed 's/\n/ /g')

case "$BLOCK_BUTTON" in
    1|2|3)
        alacritty ;;
esac

for i in $players
do
    status=$(playerctl -p "$i" status)
    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        title=$(playerctl -p "$i" metadata xesam:title)
        artist=$(playerctl -p "$i" metadata xesam:artist 2>/dev/null)
        [ ! -z "$artist" ] && artist="$artist - "
        echo "$artist$title"
        exit 0
    fi
done


