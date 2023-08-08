#!/bin/sh

export BEMENU_OPTS="--sf '#C66000' --tf '#C66000' --nb '#000000CC' --ab '#000000CC' --fb '#000000CC' --hb '#000000CC' --hf '#C66000' --cw 1 -H 15"
menu="bemenu"

players=$(playerctl -l)
num_players=$(echo "$players" | wc -l)

[ "$num_players" = "1" ] && playerctl -p "$players" "$1" && exit 0

player=$(echo "$players" | bemenu -l 10) || exit 1
playerctl -p "$player" "$1"
