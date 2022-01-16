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
clear
selected_option=$(whiptail --title "Pegasus Installer Menu" --radiolist "Move using your DPAD and select your option with the Space. Press the A button when ready." 20 40 15 \
"1" "Update Pegasus Metadata & Themes" OFF \
"2" "Scrap your Roms" OFF \
"3" "Uninstall Pegasus Metadata" OFF \
"4" "Open Termux CLI" OFF \
3>&1 1>&2 2>&3)

if [ $selected_option == "1" ]
then
	/bin/bash ~/update.sh
fi

if [ $selected_option == "2" ]
then
	/bin/bash ~/scrap.sh
fi

if [ $selected_option == "3" ]
then
	/bin/bash ~/undo.sh
fi

if [ $selected_option == "4" ]
then
	clear
fi