#!/bin/sh

tmp_file=$(mktemp --tmpdir 'Screenshot.XXXXX.jpg')
format_date=$(date +'%F-%H:%M:%S')
file="$XDG_/Screenshot_${format_date}.jpg"

dimension=$(slurp -d)

choise=$(echo "Copier la capture\nEnregistrer la capture\nQuitter" | bemenu -l 10)

case "$choise" in
    "Copier la capture") grim -g "$dimension" - | wl-copy ;;
    "Enregistrer la capture") grim -g "$dimension" -o "$file";;
    *) exit 1 ;;
esac
