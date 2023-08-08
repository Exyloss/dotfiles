#!/bin/sh

export BEMENU_OPTS="--sf '#C66000' --tf '#C66000' --nb '#000000CC' --ab '#000000CC' --fb '#000000CC' --hb '#000000CC' --hf '#C66000' --cw 1 -H 15"
menu="bemenu"

sel_fun() {
    bl_status=$(bluetooth)
    choise=$(printf "Se connecter\nSe déconnecter\nS'appairer\nRenommer un appareil\nSupprimer un appareil\nAppareils appairés\nContrôleur bluetooth\n%s\nQuitter" "$bl_status" | $menu -l 10) || return 1

    case "$choise" in
        'Se connecter') connect ;;
        'Se déconnecter') disconnect ;;
        "S'appairer") pairing ;;
        "Renommer l'appareil") rename ;;
        "Supprimer un appareil") delete ;;
        "Appareils appairés") paired_devices ;;
        "Contrôleur bluetooth") bl_ctrl ;;
        'Quitter') return ;;
        "$bl_status") bluetooth toggle ;;
        *) sel_fun ;;
    esac
    sel_fun
}

connect() {
    sel_device "Paired" || return 1
    con_dev "$device"
}

disconnect() {
    sel_device "Connected" || return 1
    discon_dev "$device"
}

pairing() {
    sel_device "" || return 1
    pair_dev "$device"
}

delete() {
    sel_device "Paired" || return 1
    del_dev "$device"
}

rename() {
    alias=$(echo "" | $menu -l 10) || return 1
    bluetoothctl "set-alias" "$alias" && notify-send "bl.sh : Succès" "Appareil renommé avec succès." && return 0
    notify-send "bl.sh : Erreur" "Erreur lors du renommage de l'appareil"
}

paired_devices() {
    sel_device "Paired" || return 1
    device_ctrl "$device"
    paired_devices
}

con_dev() {
    timeout -k 5 5 bluetoothctl connect "$1" && notify-send "bl.sh : Succès" "Appareil connecté avec succès." && return 0
    notify-send "bl.sh : Erreur" "Erreur lors de la connexion de l'appareil"
}

discon_dev() {
    timeout -k 5 5 bluetoothctl disconnect "$1" && notify-send "bl.sh : Succès" "Appareil deconnecté avec succès." && return 0
    notify-send "bl.sh : Erreur" "Erreur lors de la déconnexion de l'appareil"
}

del_dev() {
    bluetoothctl remove "$1" && notify-send "bl.sh : Succès" "Appareil supprimé avec succès." && return 0
    notify-send "bl.sh : Erreur" "Erreur lors de la suppresion de l'appareil"
}

pair_dev() {
    bluetoothctl pairable on
    bluetoothctl pair "$1" && bluetoothctl pairable off && notify-send "bl.sh : Succès" "Appareil appairé avec succès." && return 0
    notify-send "bl.sh : Erreur" "Erreur lors de l'appairage de l'appareil"
}

sel_device() {
    # shellcheck disable=SC2086
    devices=$(bluetoothctl devices $1 | $menu -l 10) || return 1
    device=$(echo "$devices" | awk '{print $2}')
}

device_ctrl() {
    infos=$(bluetoothctl info "$1" | head -10 | sed "s/\t//g")
    name=$(echo "$infos" | head -3 | tail -1 | cut -d ' ' -f 2-)
    action=$(printf "Connecter\nDéconnecter\nInformations\nSupprimer" | $menu -l 10 -p "$name") || return
    case "$action" in
        "Informations") printf "%s" "$infos" | $menu -l 10 ;;
        "Connecter") con_dev "$1" ;;
        "Déconnecter") discon_dev "$1" ;;
        "Supprimer") del_dev "$1" ;;
    esac
    device_ctrl "$1"
}

bl_ctrl() {
    infos=$(bluetoothctl show | grep -v 'UUID' | head -10 | sed "s/\t//g")
    name=$(echo "$infos" | head -3 | tail -1 | cut -d ' ' -f 2-)
    sel_info=$(echo "$infos" | tail -9 | $menu -l 10 -p "$name") || return
    case "$sel_info" in
        "Discoverable: yes") bluetoothctl discoverable off ;;
        "Discoverable: no") bluetoothctl discoverable on ;;
        "Pairable: yes") bluetoothctl pairable off ;;
        "Pairable: no") bluetoothctl pairable on ;;
        "Discovering: yes") kill $(pgrep bluetoothctl) 2>/dev/null ;;
        "Discovering: no") 
            kill $(pgrep bluetoothctl) 2>/dev/null
            bluetoothctl scan on >/dev/null & ;;
    esac
    bl_ctrl
}

bluetoothctl scan on >/dev/null &

sel_fun

kill $(pgrep bluetoothctl) 2>/dev/null
