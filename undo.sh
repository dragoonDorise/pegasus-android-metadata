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
echo -ne "Deleting Metadata Pack for Android..."
rm -rf ~/dragoonDoriseTools  &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
#Restoring Pegasus
echo -ne "Restoring Pegasus settings if they exist..."
cp ~/storage/shared/pegasus-frontend/settings.txt.bak ~/storage/shared/pegasus-frontend/settings.txt  &> ~/storage/shared/pegasus_installer_log.log
cp ~/storage/shared/pegasus-frontend/game_dirs.txt.bak ~/storage/shared/pegasus-frontend/settings.txt  &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo -ne "Deleting scripts..."
rm -f scrap.sh  &> ~/storage/shared/pegasus_installer_log.log
rm -f update.sh  &> ~/storage/shared/pegasus_installer_log.log
rm -f undo.sh  &> ~/storage/shared/pegasus_installer_log.log
rm -f startup.sh  &> ~/storage/shared/pegasus_installer_log.log
echo "" > ~/.bashrc
echo -e "${GREEN}OK${NONE}"
echo -ne "Deleting Pegasus apk..."
rm -f ~/dragoonDoriseTools/pegasus-fe_alpha15-98-gf3dcfab5_android.apk  &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
#Restoring Retroarch
echo -ne "Restoring RetroArch config..."
cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log
#We check there is a config_bak folder so we can safely delete the config folder
FOLDER=~/storage/shared/RetroArch/config_bak/
if [ -d "$FOLDER" ]; then
	rm -rf ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg  &> ~/storage/shared/pegasus_installer_log.log
	rm -rf ~/storage/shared/RetroArch/config/  &> ~/storage/shared/pegasus_installer_log.log
	cp ~/storage/shared/RetroArch/config_bak/ ~/storage/shared/RetroArch/config/  &> ~/storage/shared/pegasus_installer_log.log
	rm ~/storage/shared/RetroArch/config_bak/  &> ~/storage/shared/pegasus_installer_log.log
fi
echo -e "${GREEN}OK${NONE}"
rm -rf ~/storage  &> ~/storage/shared/pegasus_installer_log.log


echo -e "${GREEN}All cleaned up!${NONE}"
echo -e  "We hope to see you come back soon!"
echo -e  "${BOLD}NOTE:${NONE} Termux and Pegasus have to be uninstalled like any other Android app. Pegasus themes were not deleted either"
if [ $useInternalStorage == false ]; then
	echo -e "${RED}IMPORTANT${NONE}"
	echo -e "Be aware that if you delete the Termux app Android will ${RED}DELETE${NONE} all the roms on your SD Card"
	echo -e "${RED}IMPORTANT${NONE}"
fi
echo -e  "Press the ${RED}A button${NONE} to finish"
read pause
am startservice -a com.termux.service_stop com.termux/.app.TermuxService