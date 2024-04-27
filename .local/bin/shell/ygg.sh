#!/bin/sh

# Constantes
EXT="wtf"
LG="\033[0;37m"
NC="\033[0m"
GREEN="\033[0;32m"
RED="\033[0;31m"
ORANGE="\033[0;33m"
RM_TORRENT="https://www3.yggtorrent.${EXT}/engine/download_torrent?id=459" # Lien vers le torrent utlisé par RatioMaster
TORRENT_DIR="."
UP_SPEED="3000" # Vitesse d'upload donnée en kb/s
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/ygg" # Répertoire des page html parcourues
credentials="" # Fichier contenant les identifiants ygg, sous la forme [utilisateur]\n[mot de passe]
[ -f "cred" ] && credentials="cred"

sel_torrent() {
    # On télécharge la page des résultats de notre recherche, l'argument est le numéro de la page
    curl "https://www3.yggtorrent.${EXT}/engine/search?name=${search}&do=search&page=${1}&category=${cat_num}&sub_category=${subcat_num}" -o "${cache_dir}/search.html" -s
    # On vérifie que cette page contienne une liste de torrents (les résultats)
    grep -q 'listing torrents -->' "${cache_dir}/search.html" || (echo "Aucun résultat" && search_torrent)

    # On enregistre le début et la fin des résultats
    start=$(grep -n -- "listing torrents -->" "${cache_dir}/search.html" | cut -d ':' -f 1)
    end=$(grep -n -- "end table -->" "${cache_dir}/search.html" | cut -d ':' -f 1)
    
    # On écrit un tableau de résultats
    echo "<table>" > "${cache_dir}/search2.html"
    sed -n "${start},${end}p" "${cache_dir}/search.html" | sed '/<a /s/$/<\/a>/'  >> "${cache_dir}/search2.html"
    echo "</table>" >> "${cache_dir}/search2.html"

    # mise en forme de ces résultats avec l'outil html2text
    #grep -v 'gif\|hidden' "${cache_dir}/search2.html" | sed "s/|/\//g" | html2text -b 0 | grep -v -- '---' > "${cache_dir}/result.txt"

    # Remplacement de html2text par ce code
    grep -v 'gif\|hidden\|ico_comment\|^$' "${cache_dir}/search2.html" | sed "s/|/\//g" | sed 's/\r//g' | grep -v '^$' > "${cache_dir}/search3.html"
    links=$(grep 'href' "${cache_dir}/search3.html" | awk -F 'href="' '{print $2}' | cut -d '"' -f 1)
    
    for i in $links
    do
        line=""
        data=$(grep -A 6 "\"$i\"" "${cache_dir}/search3.html")
    
        name=$(echo "$data" | head -1 | cut -d '>' -f 3 | cut -d '<' -f 1) 
        link=$(echo "$data" | awk -F 'href="' '{print $2}' | cut -d '"' -f 1) 
        size=$(echo "$data" | sed '4q;d' | cut -d '>' -f 2 | cut -d '<' -f 1) 
        seed=$(echo "$data" | sed '6q;d' | cut -d '>' -f 2 | cut -d '<' -f 1) 
    
        line="|$name|$link|$size|$seed"
        echo "$line"
    done > "${cache_dir}/result.txt"
    
    len=$(wc -l "${cache_dir}/result.txt" | cut -d ' ' -f 1)
    
    # Pour i allant de 1 au nombre de résultats
    for i in $(seq 1 "$len")
    do
        # On alterne la couleur de la ligne entre LG et NC
        [ "$((i % 2))" = "0" ] && COL="$LG" || COL="$NC"
        title=$(sed "${i}q;d" "${cache_dir}/result.txt" | cut -d '|' -f 2)
        size=$(sed "${i}q;d" "${cache_dir}/result.txt" | cut -d '|' -f 4)
        seed=$(sed "${i}q;d" "${cache_dir}/result.txt" | cut -d '|' -f 5)
        echo "$COL$i | ~$title~ | $size | $seed"
    done | column -ts '|' > "${cache_dir}/format.txt" # La commande column permet d'égaliser la taille des colonnes
    
    cat "${cache_dir}/format.txt"
    sed -i "s/^[^m]*m//g" "${cache_dir}/format.txt"
    printf "\033[0m"
    
    printf "(%s)Choix>" "$1"
    set -f
    read -r choise
    case "$choise" in
        "+") sel_torrent $(($1+50)) ;; # On passe à la page suivante (1 page = 50 résultats max.)
        "-") sel_torrent $(($1-50)) ;; # On passe à la page précédente
        "0") exit 0 ;; # On quitte sans erreur
        "") search_torrent ;; # On revient sur la barre de recherche
    esac
    dl_torrent
}

sel_category() {
    cats=$(awk '/<!-- Catégorie -->/,/<\/select>/' "${cache_dir}/account.html" | grep 'value="' | grep -v 'all')
    names=$(echo "$cats" | cut -d '>' -f 2 | cut -d '<' -f 1)
    len=$(echo "$names" | wc -l)
    
    echo "0) Toutes les catégories"
    for i in $(seq 1 "$len")
    do
        name=$(echo "$names" | sed "${i}q;d")
        echo "$i) $name"
    done

    printf 'Choix>'
    set -f
    read -r category
    
    case "$category" in
        "") 
            exit 0 ;;
        "0") 
            cat_num="all"
            cat_form="all" ;;
        *)
            cat_name=$(echo "$names" | sed "${category}q;d")
            cat_num=$(echo "$cats" | grep ">$cat_name<" | awk -F 'value="' '{print $NF}' | cut -d '"' -f 1)
            cat_form=$(echo "$cats" | grep ">$cat_name<" | awk -F 'data-categorie="' '{print $NF}' | cut -d '"' -f 1) ;;
    esac
    sel_subcat
}

sel_subcat() {
    [ "$cat_num" = "all" ] && subcat_num="all" && search_torrent
    subcats=$(awk "/id=\"sub_categories_$cat_form\"/,/<\/select>/" "${cache_dir}/account.html" | grep 'value="' | grep -v 'all')
    sub_names=$(echo "$subcats" | cut -d '>' -f 2 | cut -d '<' -f 1)
    len=$(echo "$sub_names" | wc -l)
    
    echo "0) Toutes les sous-catégories"
    for i in $(seq 1 "$len")
    do
        name=$(echo "$sub_names" | sed "${i}q;d")
        echo "$i) $name"
    done
    
    printf 'Choix>'
    set -f
    read -r subcat
    
    case "$subcat" in
        "") 
            sel_category ;;
        "0")
            subcat_num="all" ;;
        *)
            subcat_name=$(echo "$sub_names" | sed "${subcat}q;d")
            subcat_num=$(echo "$subcats" | grep ">$subcat_name<" | awk -F 'value="' '{print $NF}' | cut -d '"' -f 1)
            echo "$subcat_num" ;;
    esac
    search_torrent
}

search_torrent() {
    printf "Recherche>"
    set -f
    read -r search
    search=$(echo "$search" | sed 's/ /+/g')
    [ "$search" = "" ] && sel_subcat
    sel_torrent 0
}

dl_torrent() {
    # On détermine le nom du torrent selectionné
    title_sel=$(grep "^$choise " "${cache_dir}/format.txt" | awk -F '~' '{print $2}')
    # On obtient le lien de celui-ci
    link=$(grep -F "|${title_sel}|" "${cache_dir}/result.txt" | cut -d '|' -f 3)
    # On tranforme le titre en nom de fichier
    torrent_name=$(echo "$title_sel" | sed "s/[^a-zA-Z0-9]/_/g" )
    
    
    # On télécharge la page du torrent selectionné
    curl -s "$link" -b "${cache_dir}/cookie" --compressed > "${cache_dir}/torrent.html"
    
    # On recherche le lien du fichier torrent
    torrent_link=$(grep "https://www3.yggtorrent.${EXT}/engine/download_torrent?id" "${cache_dir}/torrent.html" | awk -F '"' '{print $2}')
    
    # Affichage des informations pour le deboguage
    echo ""
    echo ":======================: Informations :======================:"
    echo "Nom tu torrent : $title_sel"
    echo "Lien de la page du torrent : $link"
    echo "Lien de téléchargement du fichier torrent : $torrent_link"
    echo ":============================================================:"
    echo ""
    
    # Téléchargement du fichier torrent
    curl -s "$torrent_link" -b "${cache_dir}/cookie" --compressed > "${TORRENT_DIR}/${torrent_name}.torrent"
    
    file_length=$(wc -l "${TORRENT_DIR}/${torrent_name}.torrent" | cut -d ' ' -f 1)
    
    # On vérifie que c'est bien un fichier torrent en regardant son nombre de lignes
    if [ "$file_length" -gt 1 ]; then
        echo "${GREEN}fichier torrent téléchargé avec succès.${NC}"
        [ "$(command -v aria2c)" ] && leech
    else
        echo "${RED}erreur lors du téléchargement du fichier torrent.${NC}"
    fi
}

login_prompt() {
    if [ -z "$credentials" ]; then
        printf "Nom d'utilisateur>"
        set -f
        read -r username
        stty -echo
        printf "mot de passe>"
        read -r password
        stty echo
        printf "\n"
    else
        username=$(head -1 "$credentials")
        password=$(tail -1 "$credentials")
    fi
    login_req
}

login_req() {
    # Requête POST permettant de se connecter au site + on stocke le cookie généré
    curl -s "https://yggtorrent.${EXT}/user/login" -X POST \
        -H 'User-Agent: libcurl/8.0.1' \
        -H 'Accept: */*' \
        -H 'Accept-Encoding: gzip, deflate' \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -H "Origin: www.yggtorrent.${EXT}" \
        -H 'Connection: keep-alive' \
        -H 'Cache-Control: no-cache' \
        -d "id=${username}&pass=${password}" --cookie-jar "${cache_dir}/cookie" --compressed > "${cache_dir}/login_output"
    
    grep -q "Bad credentials." "${cache_dir}/login_output" && echo "Identifiants erronés" && login_prompt
    account_infos
}

account_infos() {
    curl "https://www3.yggtorrent.${EXT}/engine/search?name=&do=search" -b "${cache_dir}/cookie" -o "${cache_dir}/account.html" -s
    upload=$(grep "ico_upload" "${cache_dir}/account.html" -A 1 | tail -1 | awk '{print $1}')
    up_num=$(echo "$upload" | cut -d '.' -f 1)
    download=$(grep "ico_upload" "${cache_dir}/account.html" -A 2 | tail -1 | awk '{print $1}')
    down_num=$(echo "$download" | cut -d '.' -f 1)
    actif=$(grep -i "actif" "${cache_dir}/account.html" | awk -F '<' '{print $4}' | awk -F '>' '{print $NF}' )
    echo ""
    echo "UP => ${upload}"
    echo "DOWN => ${download}"
    echo "RESTANT => $((up_num-down_num))Go"
    echo "STATUT => $actif"
    echo ""
}

leech() {
    printf 'Lancer le torrent ? [O/n] '
    set -f
    read -r ans
    case "$ans" in
        'y'|'Y'|'o'|'O'|'')
            aria2c --torrent-file="${TORRENT_DIR}/${torrent_name}.torrent" ;;
        *) exit 0 ;;
    esac

}

build_config() {
    curl "$RM_TORRENT" -o "${cache_dir}/ratio.torrent" -s
    {
        echo "{"
        echo "\"torrent\": \"${cache_dir}/ratio.torrent\"," 
        echo "\"upload\": \"$UP_SPEED\""
        echo "}" >> "${cache_dir}/config.json"
    } >> "${cache_dir}/config.json"
}

[ ! "$(command -v curl)" ] && echo "${RED}Erreur, curl n'est pas installé sur votre système.${NC}" && exit 1
[ ! "$(command -v aria2c)" ] && echo "${ORANGE}Attention, aria2 n'est pas installé, vous ne pourrez pas télécharger les torrents depuis le script.${NC}"
[ ! -d "$cache_dir" ] && mkdir -p "$cache_dir"

# On lance la fonction de connexion
login_prompt

# On lance la fonction de sélection de la catégorie (tout suivra...)
sel_category
