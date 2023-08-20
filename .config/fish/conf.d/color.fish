set color (grep 'focused_workspace' ~/.config/sway/config | awk '{print $2}')
set color_hex (grep "set $color" ~/.config/sway/config | awk '{print $3}' | head -1)
set -gx BEMENU_OPTS "--sf '$color_hex' --tf '$color_hex' --nb '#000000CC' --ab '#000000CC' --fb '#000000CC' --hb '#000000CC' --hf '$color_hex' --cw 1 -H 15"
