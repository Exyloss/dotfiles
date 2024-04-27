#!/bin/sh

menu="bemenu"

mpc list title group album group artist | while IFS= read -r i
do
    echo "$i"
done

