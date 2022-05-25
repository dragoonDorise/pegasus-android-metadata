#!/bin/bash

#Colors
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

#Functions for CHDMAN & Maxcso
compressCHDMAN () {
    for file in ./*.{iso,cue}; do
    name="${file%.*}" #Remove extension
    chdman createcd -i "$file" -o "$name".chd --force
done
}
compressMaxcso () {
    for file in ./*.{iso,cue}; do
    maxcso "$file"
done
}

#Check for .storageInternal and determine if ROMs are in internal or not
useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"

fi

#Pick the systems
SYSTEMS=$(whiptail --title "ROM Compressor" --checklist "Please select the systems whose ROMs you want to compress" 20 78 5 \
	"dreamcast" "Sega - Dreamcast" OFF \
	"ps2" "Sony - PlayStation 2" OFF \
	"psp" "Sony - PlayStation Portable" OFF \
	"psx" "Sony - PlayStation" OFF \
	"saturn" "Sega - Saturn" OFF \
 3>&1 1>&2 2>&3)


#Option to delete original uncompressed ROMs
while true; do
	removeOldROM=$(whiptail --title "Do you want to automatically PERMANENTELY delete the uncompressed ROMs after compression?" \
   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"YES" "Delete old ROMs" OFF \
	"NO" "Keep the old ROMs" OFF \
   3>&1 1<&2 2>&3)
	case $removeOldROM in
		[YES]* ) break;;
		[NO]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

for system in $(eval echo "${SYSTEMS}"); do
    cd ~/storage/$storageLocation/$system/ &>> ~/storage/shared/pegasus_installer_log.log
    if [ "$system" = psp ]; then
    compressMaxcso &>> ~/storage/shared/pegasus_installer_log.log
    else
    compressCHDMAN &>> ~/storage/shared/pegasus_installer_log.log
    fi
	if [ "$removeOldROM" = "YES" ]; then
    rm -rf ./*.{iso,cue,bin} &>> ~/storage/shared/pegasus_installer_log.log
    fi
done
clear
 echo -e "You may need to re-scrap your games after they've been compressed!"
 echo -e  "Press the ${RED}A button${NONE} to finish"
 read pause
