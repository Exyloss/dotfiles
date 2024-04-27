#!/bin/sh

players=$(playerctl -l | sed 's/\n/ /g')

case "$BLOCK_BUTTON" in
    1|2|3)
        alacritty ;;
esac

for i in $players
do
    status=$(playerctl -p "$i" status)
    if [ "$status" = 'Playing' ]; then
        title=$(playerctl -p "$i" metadata xesam:title)
        artist=$(playerctl -p "$i" metadata xesam:artist)
        echo "$artist - $title"
        exit 0
    fi
done


