#!/bin/sh
case "$1" in
    "-l") kdeconnect-cli -l --id-name-only -a;;
    "-h") 
        printf "==== Utilisation ====\n"
        printf "kdec.sh [commande] [argument]\n"
        printf "====  Commandes  ====\n"
        printf "* -l : lister les appareils disponibles\n"
        printf "* -h : afficher cette aide\n"
        printf "* -f : envoyer le fichier renseigné en argument\n"
        printf "* -s : envoyer un SMS\n"
        printf "* -t : envoyer le texte renseigné en argument\n" ;;
    "-f")
        [ -e "$2" ] || exit 1
        devices=$(kdeconnect-cli -l --id-name-only -a) || exit 1
        echo "$devices"
        device=$(echo "$devices" | fzf -1 | awk '{print $1}') || exit 1
        kdeconnect-cli -d "$device" --share "$2" || exit 1 ;;
    "-s")
        devices=$(kdeconnect-cli -l --id-name-only -a) || exit 1
        echo "$devices"
        device=$(echo "$devices" | fzf -1 | awk '{print $1}') || exit 1
        printf "\nNuméro du destinataire : "
        set -f
        read num
        printf "\nContenu du message : "
        set -f
        read msg
        kdeconnect-cli -d "$device" --send-sms "$msg" --destination "$num" || exit 1
        printf "Message envoyé." ;;
    "-t")
        [ -z "$2" ] && content=$(xsel -b) || content="$2"
        devices=$(kdeconnect-cli -l --id-name-only -a 2>/dev/null) || exit 1
        echo "$devices"
        device=$(echo "$devices" | fzf -1 | awk '{print $1}') || exit 1
        kdeconnect-cli -d "$device" --share-text "$content" || exit 1 ;;
esac
exit 0
