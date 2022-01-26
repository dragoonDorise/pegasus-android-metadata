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
selected_device_descriptions=$(whiptail --title "Pegasus Rom Compressor" \
   --checklist "Move using your DPAD and select your options with the Y button. Press the A button to select." 10 80 5 \
	"dreamcast" "Sega - Dreamcast" OFF \
	"saturn" "Sega - Saturn" OFF \
	"psx" "Sony - PlayStation" OFF \
	"ps2" "Sony - PlayStation 2" OFF \

   3>&1 1<&2 2>&3)
for device_name in ${selected_device_names[@]};
 		do
	 		message=$device_name
	 		system="${message//'"'/}"          
cd ~/storage/$storageLocation/$system


#Convert cue to chd
for f in ./*.cue
do
	name=${f%.cue} # Remove '.cue' from file name
	chdman createcd -i "$name.cue" -o "$name.chd" --force
	#rm -rf "$name.cue"
	#rm -rf "$name.bin"
done

#Convert iso to chd
for f in ./*.iso
do
	name=${f%.iso} # Remove '.iso' from file name
	chdman createcd -i "$name.iso" -o "$name.chd" --force
	#rm -rf "$name.iso"
	
done
done
else
echo -e "User chose not to compress roms. If you change your mind you can always run this script again \n"
read -n 1 -r -s -p $'Press any key to continue...\n' 
fi

exit