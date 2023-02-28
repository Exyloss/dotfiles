#!/bin/sh
#swaymsg -t subscribe -m '["window"]' | jq -r '.container.name'
unbuffer swaymsg -t subscribe -m '["window"]' | jq --unbuffered -r 'select(.change=="focus" or .container.focused == true) | .container.name'
