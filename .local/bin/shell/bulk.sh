#!/bin/sh

# Bulk renamer, uses environment variable $EDITOR as text editor.

file_content=$(ls -1)

echo "$file_content" > ~/.cache/bulk.old
echo "$file_content" > ~/.cache/bulk.new
printf "" > ~/.cache/bulk.merge

$EDITOR ~/.cache/bulk.new

paste ~/.cache/bulk.old ~/.cache/bulk.new -d ":" | awk -F: '$1!=$2' > ~/.cache/bulk.merge

echo "Voici les transformations qui seront réalisées :"
cat ~/.cache/bulk.merge
printf "Etes-vous sûr de vouloir modifier vos fichiers ? [O/n] "
read -r ans

if [ "$ans" = "O" ] || [ "$ans" = "o" ]; then
    sed 's/^/"/g; s/$/"/g; s/:/" "/g' ~/.cache/bulk.merge | xargs -L1 mv
else
    exit 1
fi
