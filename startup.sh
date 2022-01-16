#!/bin/sh
#

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
BLINK='\x1b[5m'

selected_option=$(whiptail --title "Pegasus Installer Menu" --radiolist "Move using your DPAD and select your option with the Space. Press the A button when ready." 20 40 15 \
"1" "Reinstall Pegasus Metadata" OF \
"2" "Update Pegasus Metadata & Themes" OFF \
"3" "Scrap your Roms" OFF \
"4" "Open Termux CLI" OFF \
"5" "Exit" OFF \
3>&1 1>&2 2>&3)

echo $selected_option