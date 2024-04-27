#!/bin/sh

players=$(playerctl -l | grep -v "kdeconnect" | sed 's/\n/ /g')


for i in $players
do
    status=$(playerctl -p "$i" status)
    if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
        title=$(playerctl -p "$i" metadata xesam:title)
        artist=$(playerctl -p "$i" metadata xesam:artist 2>/dev/null)
        [ ! -z "$artist" ] && artist="$artist - "
        player=${i%%.*}
        echo "[$player] $artist$title" |  sed 's/\(.\{50\}\).*/\1.../' | sed 's/&/&amp;/g'
        [ "$1" != "" ] && playerctl -p "$i" "$1"
        exit 0
    fi
done


