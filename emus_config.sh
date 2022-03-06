#!/bin/sh

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

handheldModel=$(cat ~/dragoonDoriseTools/.device)



if [ $handheldModel == "ODIN" ]; then

	hasDuckstation=false
	hasDolphinMMJ=false

	FOLDER=~/storage/shared/dolphin-mmjr
	if [ -d "$FOLDER" ]; then
		hasDolphinMMJ=true
	fi
	FOLDER=~/storage/shared/duckstation
	if [ -d "$FOLDER" ]; then
		hasDuckstation=true
	fi
	
	
	echo -ne "Creating Dolphin Backup..."
	#We create the backup only if we don't have one, to prevent erasing the original backup if the user reinstalls
	FOLDER=~/storage/shared/dolphin-mmjr_bak/
	if [ -d "$FOLDER" ]; then
		echo -e "${GREEN}OK${NONE}"
	else
		if [ $hasDolphinMMJ == true ]; then
			cp -r ~/storage/shared/dolphin-mmjr ~/storage/shared/dolphin-mmjr_bak
			rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/odin/dolphin-mmjr/ ~/storage/shared/dolphin-mmjr &>> ~/storage/shared/pegasus_installer_log.log
		fi
		echo -e "${GREEN}OK${NONE}"
	fi
	
	echo -ne "Creating Duckstation Backup..."	
	FOLDER=~/storage/shared/duckstation/
	if [ -d "$FOLDER" ]; then
		echo -e "${GREEN}OK${NONE}"
	else
		if [ $hasDuckstation == true ]; then
			cp -r ~/storage/shared/duckstation/ ~/storage/shared/duckstation_bak/
			rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/odin/duckstation/ ~/storage/shared/duckstation/ &>> ~/storage/shared/pegasus_installer_log.log
		fi
		echo -e "${GREEN}OK${NONE}"
	fi
	

fi
	