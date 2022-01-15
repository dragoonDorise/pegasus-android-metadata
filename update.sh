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
version=$(cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md)
echo -e  "Lets update your themes, shall we?"
echo -e  "${BOLD}Press the A button if you agree ;)${NONE}"
read pause

echo -ne  "Updating Themes..."
cd ~/storage/shared/pegasus-frontend/themes/RP-epic-noir
git reset --hard &> /dev/null 
git pull &> /dev/null 

cd ~/storage/shared/pegasus-frontend/themes/RP-switch
git reset --hard &> /dev/null 
git pull &> /dev/null 
echo -e "${GREEN}OK${NONE}"
clear
echo -e  "${GREEN}Done!${NONE}If you want to update the metadata pack press the A Button, ${BOLD}close Termux otherwise.${NONE}"
echo -e  "${RED}DISCLAIMER:${NONE} This will remove any changes you could have made to Pegasus metadata files or RetroArch core overrides"
echo -e  "${BOLD}This won't delete any roms${NONE}"
read pause

#RetroArch Update
echo -ne  "Updating Retroarch Configs..."
cd ~/dragoonDoriseTools/pegasus-android-metadata/ &> /dev/null 
git reset --hard &> /dev/null 
git pull &> /dev/null 

#RetroArch Configs
/bin/bash retroarch_config.sh &> /dev/null


echo -e "${GREEN}OK${NONE}"
cd ~/dragoonDoriseTools/
#Metadata update
echo -ne  "Updating Metadata..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1
echo -e "${GREEN}OK${NONE}"

#update scripts
echo -ne  "Updating Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh
chmod a+rwx ~/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh
chmod a+rwx ~/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh
chmod a+rwx ~/undo.sh
echo -e "${GREEN}OK${NONE}"
echo ""
echo -e  "${GREEN}Update Complete${NONE}"
echo ""
echo -e  "${YELLOW}Changelog${NONE}"
echo -e  "Your version was${PURPLE}$version${NONE}"
echo -ne  "Installed version is: "
cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md
echo -e  "${GREEN}Changelog:${NONE}"
cat ~/dragoonDoriseTools/pegasus-android-metadata/changelog.md
