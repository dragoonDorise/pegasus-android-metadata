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
cat logo.ans
echo -ne "Deleting Metadata..."
rm -rf ~/dragoonDoriseTools  &> /dev/null
echo -e "${GREEN}OK${NONE}"
#Restoring Pegasus
echo -ne "Restoring Pegasus settings if existed..."
cp ~/storage/shared/pegasus-frontend/settings.txt.bak ~/storage/shared/pegasus-frontend/settings.txt  &> /dev/null
cp ~/storage/shared/pegasus-frontend/game_dirs.txt.bak ~/storage/shared/pegasus-frontend/settings.txt  &> /dev/null
echo -e "${GREEN}OK${NONE}"
echo -ne "Deleting scripts..."
rm -f scrap.sh  &> /dev/null
rm -f update.sh  &> /dev/null
rm -f undo.sh  &> /dev/null
echo -e "${GREEN}OK${NONE}"
echo -ne "Deleting Pegasus apk..."
rm -f ~/dragoonDoriseTools/pegasus-fe_alpha15-85-gfff1a5b2_android.apk  &> /dev/null
echo -e "${GREEN}OK${NONE}"
#Restoring Retroarch
echo -ne "Restoring RetroArch config..."
cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null
FILE=~/storage/shared/RetroArch/config_bak
if [ -f "$FILE" ]; then
	rm -rf ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg  &> /dev/null
	rm -rf ~/storage/shared/RetroArch/config/  &> /dev/null
	cp ~/storage/shared/RetroArch/config_bak/ ~/storage/shared/RetroArch/config/  &> /dev/null
	rm ~/storage/shared/RetroArch/config_bak/  &> /dev/null
fi
echo -e "${GREEN}OK${NONE}"
rm -rf ~/storage  &> /dev/null


echo -e "${GREEN}All cleaned up!${NONE}"
echo -e  "We hope to see you come back soon!"
echo -e  "${BOLD}NOTE:${NONE} Termux and Pegasus have to be uninstalled like any other Android app. Pegasus themes are not deleted either"

exit