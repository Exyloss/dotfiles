#!/bin/sh

for i in *.flac
do
    no_ext=${i%.*}
    echo "converting ${no_ext}..."
    opusenc --bitrate 256 --quiet "$i" "${no_ext}.opus" 
done
