#!/bin/bash

touch ~/storage/shared/pegasus_installer_log.log
echo "##### COMPRESS #####" >> ~/storage/shared/pegasus_installer_log.log

#Colors
RED='\033[01;31m'

#Function for CHDMAN
compressCHDMAN () {
    name="${1%.*}" #Remove extension
    chdman createcd -i "$1" -o "$name".chd --force
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
	cd ~/storage/$storageLocation/$system/
    for file in ./*.{iso,cue}; do
		if [ "$system" = psp ]; then
			maxcso "$file" &>> ~/storage/shared/pegasus_installer_log.log
		else
			compressCHDMAN "$file" &>> ~/storage/shared/pegasus_installer_log.log
		fi
		if [ "$removeOldROM" = "YES" ]; then
			name="${file%.*}"
			rm -rf "$file" "$name".bin &>> ~/storage/shared/pegasus_installer_log.log
		fi

done
done
clear
 echo -e "You may need to re-scrap your games after they've been compressed!"
 echo -e "You may have leftover .bin files if the names do not exactly match the .cue file."
 echo -e  "Press the ${RED}A button${NONE} to finish"
 read pause
