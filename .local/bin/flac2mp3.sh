#!/bin/sh

# Converting flac's to mp3 320kbps in a directory

for i in * 
do
    ext=${i##*.}
    no_ext=${i%.*}
    [ "$ext" = "flac" ] && ffmpeg -i "$i" -ab 320k -map_metadata 0 -id3v2_version 3 "${no_ext}.mp3"
done
