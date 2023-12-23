#!/bin/sh

menu="bemenu"

players=$(playerctl -l | sed 's/\n/ /g')
players_on=$(
for i in $players
do
    status=$(playerctl -p "$i" status)
    [ "$status" != "Stopped" ] && echo "$i"
    
done
)

num_players=$(echo "$players_on" | wc -l)
[ "$num_players" = "1" ] && playerctl -p "$players_on" "$1" && exit 0

player=$(echo "$players_on" | bemenu -l 10) || exit 1
playerctl -p "$player" "$1"
