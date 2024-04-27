#!/bin/sh

printf 'Rechercher>'
set -f
read -r search

json_data=$(http "http://de1.api.radio-browser.info/json/stations/byname/${search}?order=clickcount&reverse=true&hidebroken=true&limit=20")
result=$(echo "$json_data" | jq -r '.[] | "\(.name) ~ \(.bitrate)kbps ~ \(.url) ~ \(.stationuuid)"' | awk -F ' ~ ' '!_[$3]++')

choise=$(echo "$result" | column -ts '~' -H 4 | fzf) || exit 0
link=$(echo "$choise" | awk '{print $NF}')
name=$(echo "$result" | grep "$link" | awk -F ' ~ ' '{print $1}')
uuid=$(echo "$result" | grep "$link" | awk -F ' ~ ' '{print $NF}')
echo "${name} - ${link} - ${uuid}"
mpv --no-video "$link"
