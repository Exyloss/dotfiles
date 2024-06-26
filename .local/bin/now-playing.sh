#!/bin/sh

players=$(playerctl -l | grep -v "kdeconnect" | sed 's/\n/ /g')


for i in $players
do
    status=$(playerctl -p "$i" status)
    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        title=$(playerctl -p "$i" metadata xesam:title)
        artist=$(playerctl -p "$i" metadata xesam:artist 2>/dev/null)
        [ ! -z "$artist" ] && artist="$artist - "
        echo "$artist$title" |  sed 's/\(.\{50\}\).*/\1.../'
        if [ "$BLOCK_BUTTON" = "1" ]; then
            case "$i" in
                "mpd") alacritty --class float -e ncmpcpp ;;
            esac
        fi
        exit 0
    fi
done


