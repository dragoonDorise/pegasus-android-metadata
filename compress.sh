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
useInternalStorage=false
enableCompression=false
FILE=~/dragoonDoriseTools/.storageInternal

if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"
	
fi



if (whiptail --title "Rom compressor" --yesno "Would you like to compress your roms now?" 10 80); then


else
echo -e "User chose not to compress roms. If you change your mind you can always run this script again \n"
read -n 1 -r -s -p $'Press any key to continue...\n' 
fi


done