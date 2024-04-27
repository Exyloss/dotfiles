#!/bin/sh
# Convert a directory of flac to a directory of opus
# Usage : ./dir_flac2opus.sh <flac-directory> <opus-directory>

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "error, input or output folder not defined."
    exit 1
fi

find "$1" | grep '.flac$' | while read -r i
do
    no_ext=${i%.*}
    no_ext=${no_ext##*/}
    folder=${i%/*}
    new_folder=$(echo "$folder" | sed "s|$1|$2|g")
    if [ ! -d "$new_folder" ]; then
        mkdir -p "$new_folder"
        echo "$new_folder"
    fi
    echo "$no_ext"
    [ -f "${folder}/cover.jpg" ] && cp "${folder}/cover.jpg" "${new_folder}/cover.jpg"
    [ -f "${folder}/${no_ext}.lrc" ] && cp "${folder}/${no_ext}.lrc" "${new_folder}/${no_ext}.lrc"
    [ ! -f "${new_folder}/${no_ext}.opus" ] && opusenc --bitrate 256 --quiet "$i" "${new_folder}/${no_ext}.opus" 
done
exit 0
