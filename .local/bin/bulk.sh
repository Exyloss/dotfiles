#!/bin/sh

# Bulk renamer, uses environment variable $EDITOR as text editor.

file_content=$(ls -1)

echo "$file_content" > ~/.cache/bulk.old
echo "$file_content" > ~/.cache/bulk.new
printf "" > ~/.cache/bulk.merge

$EDITOR ~/.cache/bulk.new

i=1

len=$(wc -l ~/.cache/bulk.new | cut -d " " -f 1)

while [ "$i" -le "$len" ]
do
    line_old=$(head -"$i" ~/.cache/bulk.old | tail -1)
    line_new=$(head -"$i" ~/.cache/bulk.new | tail -1)
    echo "$line_old:$line_new" >> ~/.cache/bulk.merge
    i=$((i+1))
done

echo "Voici les transformations qui seront réalisées :"
cat ~/.cache/bulk.merge
printf "Etes-vous sûr de vouloir modifier vos fichiers ? [O/n] "
read -r ans

if [ "$ans" = "O" ] || [ "$ans" = "o" ]; then
    sed 's/^/"/g' ~/.cache/bulk.merge | sed 's/$/"/g' | sed 's/:/" "/g' | xargs -l sh -c 'mv "$0" "$1"'
    echo "changements effectués."
    exit 0
else
    exit 1
fi
