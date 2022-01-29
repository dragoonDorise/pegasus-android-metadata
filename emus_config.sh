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



if [$handheldModel == "ODIN"]; then

	hasDuckstation=false
	hasDolphin=false

	FOLDER=~/storage/shared/Android/data/org.dolphinemu.dolphinemu
	if [ -d "$FOLDER" ]; then
		hasDolphin=true
	fi
	FOLDER=~/storage/shared/duckstation
	if [ -d "$FOLDER" ]; then
		hasDuckstation=true
	fi
	
	
	echo -ne "Creating Dolphin Backup..."
	#We create the backup only if we don't have one, to prevent erasing the original backup if the user reinstalls
	FOLDER=~/storage/shared/Android/data/org.dolphinemu.dolphinemu_bak/
	if [ -d "$FOLDER" ]; then
		echo -e "${GREEN}OK${NONE}"
	else
		if [ $hasDolphin == true ]; then
			cp -r ~/storage/shared/Android/data/org.dolphinemu.dolphinemu ~/storage/shared/Android/data/org.dolphinemu.dolphinemu_bak
			rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/odin/org.dolphinemu.dolphinemu/ ~/storage/shared/Android/data/org.dolphinemu.dolphinemu/ &> ~/storage/shared/pegasus_installer_log.log
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
			rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/odin/duckstation/ ~/storage/shared/duckstation/ &> ~/storage/shared/pegasus_installer_log.log
		fi
		echo -e "${GREEN}OK${NONE}"
	fi
	
#Pegasus metadatas
	cp ~/dragoonDoriseTools/pegasus-android-metadata/roms/gc/metadata.pegasus.txt.odin ~/storage/$storageLocation/gc/metadata.pegasus.txt

	cp ~/dragoonDoriseTools/pegasus-android-metadata/roms/wii/metadata.pegasus.txt.odin ~/storage/$storageLocation/wii/metadata.pegasus.txt

fi
	