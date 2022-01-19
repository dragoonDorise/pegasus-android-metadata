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
cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans
version=$(cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md)

#update scripts
echo -ne  "Updating Scripts..."
cd ~/dragoonDoriseTools/pegasus-android-metadata/ &> ~/storage/shared/pegasus_installer_log.log 
git reset --hard &> ~/storage/shared/pegasus_installer_log.log 
git pull &> ~/storage/shared/pegasus_installer_log.log 
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh
chmod a+rwx ~/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh
chmod a+rwx ~/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh
chmod a+rwx ~/undo.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/startup.sh  ~/startup.sh &> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/startup.sh &> ~/storage/shared/pegasus_installer_log.log
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
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1 &> ~/storage/shared/pegasus_installer_log.log
#cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log
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

echo -e "${GREEN}OK${NONE}"

#Handheld detector
handheldModel="169"

FILE=~/dragoonDoriseTools/.isRG552
if [ -f "$FILE" ]; then
	handheldModel="RG552"
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
echo -ne  "Installed version is now: ${GREEN}$newVersion${NONE}"
echo -e""

echo -e "${RED}REMEMBER TO INSTALL CORES${NONE} If you downloaded new cores.. Go to Retroarch's Main Menu -> Load Core -> Install or Restore a Core"
echo -e "And just select the core you want to install"
echo -e  "Type ${BOLD}exit${NONE} and press the A button to finish"
read pause
am startservice -a com.termux.service_stop com.termux/.app.TermuxService