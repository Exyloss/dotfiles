#!/bin/sh

input_sink=$(pactl list sink-inputs short | cut -f 1)

output=$(pamixer --list-sinks | awk -F\" '{print $6}' | grep -v '^$' | grep -v "HDMI" | dmenu -p "Appareil de sortie" -l 10) || exit 1

output_full=$(pamixer --list-sinks | grep "\"$output\"" | awk -F\" '{print $2}')
echo "$output_full"

pactl move-sink-input "$input_sink" "$output_full"
pactl set-default-sink "$output_full"
