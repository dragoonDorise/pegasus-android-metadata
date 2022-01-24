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
clear
useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"
	
fi
cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans
version=$(cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md)
#Detect installed emulators
hasRetroArch64=false
#Retroarch 64?
FOLDER64=~/storage/shared/Android/data/com.retroarch.aarch64
if [ -d "$FOLDER64" ]; then
	hasRetroArch64=true
fi
#update scripts
echo -ne  "Updating Scripts..."
pkg install git wget rsync unzip whiptail jq -y  &>> ~/storage/shared/pegasus_installer_log.log
echo "/bin/bash ~/startup.sh" > ~/.bashrc
echo -e "${GREEN}OK${NONE}"

echo -ne  "Updating Bundled Themes (won't affect any other themes)..."
cd ~/storage/shared/pegasus-frontend/themes/RP-epic-noir
git reset --hard &> ~/storage/shared/pegasus_installer_log.log 
git pull &> ~/storage/shared/pegasus_installer_log.log 

cd ~/storage/shared/pegasus-frontend/themes/RP-switch
git reset --hard &> ~/storage/shared/pegasus_installer_log.log 
git pull &> ~/storage/shared/pegasus_installer_log.log 
echo -e "${GREEN}OK${NONE}"

#Metadata update
echo -ne  "Updating Metadata..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/$storageLocation &> ~/storage/shared/pegasus_installer_log.log

#Retroarch64 support
if [ $hasRetroArch64 == true ]; then	
	find ~/storage/$storageLocation -type f -name "*.txt" -exec sed -i -e 's/com.retroarch/com.retroarch.aarch64/g' {} \;
fi
#cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log


if [ $useInternalStorage == false ]; then

	#We get the SD Card Volume name
	for entry in /storage/*
 	do
	 	STR=$entry
	 	SUB='-'
	 	if grep -q "$SUB" <<< "$STR"; then
		 	firstString=$entry
			 	secondString=""
		  	sdcardID="${firstString/"/storage/"/"$secondString"}"   
	 	fi
 	done

 	sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &> ~/storage/shared/pegasus_installer_log.log 

else

	sed -i "s/0000-0000/emulated\/0\/roms\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log

fi
echo -e "${GREEN}OK${NONE}"


#Handheld detector
handheldModel="ANDROID"

FILE=~/dragoonDoriseTools/.isRG552
if [ -f "$FILE" ]; then
	rm ~/dragoonDoriseTools/.isRG552
	echo 'RG552' > ~/dragoonDoriseTools/.device	
fi

#RetroArch Update
echo -ne  "Updating Retroarch Config..."
#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/retroarch_config.sh $handheldModel

/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emu_check.sh

newVersion=$(cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md)
echo ""
echo -e  "${GREEN}Update Completed${NONE}"
echo ""
echo -e  "${YELLOW}Changelog${NONE}"
cat ~/dragoonDoriseTools/pegasus-android-metadata/changelog.md
echo ""
echo -e  "Your version was: ${PURPLE}$version${NONE}"
echo -e "Installed version is now: ${GREEN}$newVersion${NONE}"
echo -e ""

echo -e "${YELLOW}REMEMBER TO INSTALL CORES${NONE} If you downloaded new cores.."
echo -e "Go to Retroarch's Main Menu -> Load Core -> Install or Restore a Core"
echo -e "And just select the core you want to install"
echo -e  "Press the ${RED}A button${NONE} to finish"
read pause
am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
