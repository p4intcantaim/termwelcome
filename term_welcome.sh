#!/bin/bash

GREEN="\033[1;32m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Date/Username
USER_NAME=$(whoami)
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%I:%M %p")

# OS
if [[ -f /etc/os-release ]]; then
    # For most modern Linux distributions
    . /etc/os-release
    OS_NAME=$NAME
    OS_VERSION=$VERSION
elif [[ -f /etc/lsb-release ]]; then
    # For older Debian/Ubuntu versions
    . /etc/lsb-release
    OS_NAME=$DISTRIB_ID
    OS_VERSION=$DISTRIB_RELEASE
elif [[ "$(uname)" == "Darwin" ]]; then
    # For macOS
    OS_NAME="macOS"
    OS_VERSION=$(sw_vers -productVersion)
else
    # For other Unix-like OSes
    OS_NAME=$(uname -s)
    OS_VERSION=$(uname -r)
fi


get_song() {
    # Check if Spotify is playing
    if [ "$(playerctl -p spotify metadata title)" ]; then
        echo "$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
    # Fallback to other players if Spotify is not playing
    elif [ "$(playerctl metadata title)" ]; then
        echo "$(playerctl metadata artist) - $(playerctl metadata title)"
    else
        echo "No music playing"
    fi
}

# Display the result
echo -e "${GREEN}Currently Playing:${RESET} ${CYAN}$(get_song)${RESET}"
echo -e "${GREEN}Operating System:${RESET} ${CYAN}$OS_NAME${RESET}"
echo -e "${GREEN}Uptime:${RESET} ${CYAN}$(uptime -p | sed 's/up //'
)${RESET}"
echo -e "${GREEN}Date:${RESET} ${CYAN}$DATE"
echo -e "${GREEN}Time:${RESET} ${CYAN}$TIME"
echo -e "${GREEN}Username:${RESET} ${CYAN}$USER_NAME"
echo -e "--------------------------------------------------------------"
fortune
echo -e "--------------------------------------------------------------"

