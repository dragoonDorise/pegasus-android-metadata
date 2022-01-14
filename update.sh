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


echo -e  "Lets update your themes, shall we?"
echo -e  "${BOLD}Press the A button if you agree ;)${NONE}"
read pause
cd ~/storage/shared/pegasus-frontend/themes/RP-epic-noir
git reset --hard
git pull

cd ~/storage/shared/pegasus-frontend/themes/RP-switch
git reset --hard
git pull

clear
echo -e  '${GREEN}Done!${BOLD}If you want to update the metadata pack press the A Button, ${BOLD}close Termux otherwise.${NONE}'
echo -e  '${RED}DISCLAIMER:${BOLD} This will remove any changes you could have made to Pegasus metadata files or RetroArch core overrides'
echo -e  "${BOLD}This won't delete any roms${NONE}"
read pause

#RetroArch Update
cd ~/dragoonDoriseTools/pegasus-android-metadata/
git reset --hard
git pull
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/
cd ~/dragoonDoriseTools/
#Metadata update
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1

#update scripts
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/dragoonDoriseTools/update.sh
chmod a+rwx ~/dragoonDoriseTools/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/dragoonDoriseTools/scrap.sh
chmod a+rwx ~/dragoonDoriseTools/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/dragoonDoriseTools/undo.sh
chmod a+rwx ~/dragoonDoriseTools/undo.sh
clear
#rm -rf ~/dragoonDoriseTools/

echo -e  "${GREEN}All done${NONE}See you!"