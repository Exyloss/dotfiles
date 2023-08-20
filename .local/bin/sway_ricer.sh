#!/bin/sh

cat ~/.config/sway/themes.csv | cut -d ';' -f 1
printf ':'
set -f
read -r theme
light_col=$(grep "$theme;" ~/.config/sway/themes.csv | cut -d ';' -f 2)
dark_col=$(grep "$theme;" ~/.config/sway/themes.csv | cut -d ';' -f 3)
wallpaper=$(grep "$theme;" ~/.config/sway/themes.csv | cut -d ';' -f 4)

gawk -i inplace "/set \\\$lightricer/ {\$3 = \"$light_col\"}1" .config/sway/config
gawk -i inplace "/set \\\$darkricer/ {\$3 = \"$dark_col\"}1" .config/sway/config
gawk -i inplace "/output \* bg/ {\$4 = \"$wallpaper\"}1" .config/sway/config
