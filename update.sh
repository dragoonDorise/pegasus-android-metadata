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
echo -e  "Lets start updating your Pegasus Metadata Pack & Themes"
echo -e  "${BOLD}Press the A button to continue${NONE}"
read pause

#update scripts
echo -ne  "Updating Scripts..."
cd ~/dragoonDoriseTools/pegasus-android-metadata/ &> /dev/null 
git reset --hard &> /dev/null 
git pull &> /dev/null 
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh
chmod a+rwx ~/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh
chmod a+rwx ~/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh
chmod a+rwx ~/undo.sh
echo -e "${GREEN}OK${NONE}"

echo -ne  "Updating Bundled Themes (won't affect any other themes)..."
cd ~/storage/shared/pegasus-frontend/themes/RP-epic-noir
git reset --hard &> /dev/null 
git pull &> /dev/null 

cd ~/storage/shared/pegasus-frontend/themes/RP-switch
git reset --hard &> /dev/null 
git pull &> /dev/null 
echo -e "${GREEN}OK${NONE}"
clear
echo -e  "Updating Pegasus metadata files..."
#Metadata update
echo -ne  "Updating Metadata..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1

echo -e "${GREEN}OK${NONE}"
#RetroArch Update
echo -ne  "Updating Retroarch Config..."
#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/retroarch_config.sh &> /dev/null
echo -e "${GREEN}OK${NONE}"


echo ""
echo -e  "${GREEN}Update Completed${NONE}"
echo ""
echo -e  "${YELLOW}Changelog${NONE}"
echo -e  "Your version was${PURPLE}$version${NONE}"
echo -ne  "Installed version is: "
cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md
echo -e  "${GREEN}Changelog:${NONE}"
cat ~/dragoonDoriseTools/pegasus-android-metadata/changelog.md
