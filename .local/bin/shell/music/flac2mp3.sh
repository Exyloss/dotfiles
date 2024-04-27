#!/bin/sh

# Converting flac to mp3 320kbps in a directory

for i in *.flac
do
    ext=${i##*.}
    no_ext=${i%.*}
    ffmpeg -i "$i" -ab 320k -map_metadata 0 -id3v2_version 3 "${no_ext}.mp3"
done
