#!/bin/sh

export BEMENU_OPTS="--sf '#C66000' --tf '#C66000' --nb '#000000CC' --ab '#000000CC' --fb '#000000CC' --hb '#000000CC' --hf '#C66000' --cw 1 -H 15"
menu="bemenu"

filename=$(date +'%Y-%m-%d_%H-%M-%S')
img=$(grimshot save area "$HOME/Pictures/Captures/$filename.png")
choise=$(echo "Oui\nNon" | bemenu -p "Copier la capture ?" -l 10) || exit 1

[ "$choise" = "Oui" ] && wl-copy < "$HOME/Pictures/Captures/$filename.png" && rm "$HOME/Pictures/Captures/$filename.png"
