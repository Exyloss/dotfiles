#!/bin/sh
case "$1" in
    "-l") kdeconnect-cli -a --id-name-only;;
    "-f")
        [ -e "$2" ] || exit 1
        devices=$(kdeconnect-cli -a --id-name-only) || exit 1
        echo "$devices"
        device=$(echo "$devices" | fzf -1 | awk '{print $1}') || exit 1
        kdeconnect-cli -d "$device" --share "$2" || exit 1 ;;
    "-s")
        devices=$(kdeconnect-cli -a --id-name-only) || exit 1
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
        clipboard=$(xsel -b) 
        printf "\nEnvoyer le presse-papier ? (o/n) "
        set -f 
        read ans
        if [ "$ans" = "o" ]; then
            content="$clipboard"
        else
            printf "Message à envoyer : "
            set -f
            read content
            echo ""
        fi
        devices=$(kdeconnect-cli -a --id-name-only) || exit 1
        device=$(echo "$devices" | fzf -1 | awk '{print $1}') || exit 1
        kdeconnect-cli -d "$device" --share-text "$content" || exit 1 ;;
        
    *) 
        printf "==== Utilisation ====\n"
        printf "kdec.sh [commande] [argument]\n"
        printf "====  Commandes  ====\n"
        printf "* -l : lister les appareils disponibles\n"
        printf "* -h : afficher cette aide\n"
        printf "* -f : envoyer le fichier renseigné en argument\n"
        printf "* -s : envoyer un SMS\n"
        printf "* -t : envoyer le texte renseigné en argument\n" ;;
esac
