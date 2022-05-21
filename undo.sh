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

hasRetroArch64=false
FOLDER64=~/storage/shared/Android/data/com.retroarch.aarch64
if [ -d "$FOLDER64" ]; then
	hasRetroArch64=true
fi

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
rm -rf ~/dragoonDoriseTools  &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
#Restoring Pegasus
echo -ne "Restoring Pegasus settings if they exist..."
cp ~/storage/shared/pegasus-frontend/settings.txt.bak ~/storage/shared/pegasus-frontend/settings.txt  &>> ~/storage/shared/pegasus_installer_log.log
cp ~/storage/shared/pegasus-frontend/game_dirs.txt.bak ~/storage/shared/pegasus-frontend/settings.txt  &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo -ne "Deleting scripts..."
rm -f scrap.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f compress.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f update.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f run_update.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f undo.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f startup.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f snes_config.sh  &>> ~/storage/shared/pegasus_installer_log.log
rm -f ~/storage/shared/scrap.log  &>> ~/storage/shared/pegasus_installer_log.log
echo "" > ~/.bashrc
echo -e "${GREEN}OK${NONE}"
echo -ne "Deleting Pegasus apk..."
rm -f ~/dragoonDoriseTools/pegasus-fe_alpha16_android.apk  &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
#Restoring Retroarch
echo -ne "Restoring RetroArch config..."
if [[ $hasRetroArch64 == false ]]; then
	cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log
fi
if [[ $hasRetroArch64 == true ]]; then
	cp ~/storage/shared/Android/data/com.retroarch.aarch64/files/retroarch.bak.cfg ~/storage/shared/Android/data/com.retroarch.aarch64/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log
fi



#We check there is a config_bak folder so we can safely delete the config folder
FOLDER=~/storage/shared/RetroArch/config_bak/
if [ -d "$FOLDER" ]; then
	rm -rf ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg  &>> ~/storage/shared/pegasus_installer_log.log
	rm -rf ~/storage/shared/RetroArch/config/  &>> ~/storage/shared/pegasus_installer_log.log
	cp ~/storage/shared/RetroArch/config_bak/ ~/storage/shared/RetroArch/config/  &>> ~/storage/shared/pegasus_installer_log.log
	rm ~/storage/shared/RetroArch/config_bak/  &>> ~/storage/shared/pegasus_installer_log.log
fi
echo -e "${GREEN}OK${NONE}"
rm -rf ~/storage  &>> ~/storage/shared/pegasus_installer_log.log


FOLDER=~/storage/shared/dolphin-mmjr_bak/
if [ -d "$FOLDER" ]; then
	echo -ne "Restoring Dolphin MMJR config..."
	cp ~/storage/shared/dolphin-mmjr_bak/ ~/storage/shared/dolphin-mmjr/  &>> ~/storage/shared/pegasus_installer_log.log
	rm ~/storage/shared/dolphin-mmjr_bak/  &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi

FOLDER=~/storage/shared/Android/data/org.dolphinemu.dolphinemu_bak
if [ -d "$FOLDER" ]; then
	echo -ne "Restoring Dolphin config..."
	cp ~/storage/shared/Android/data/org.dolphinemu.dolphinemu_bak ~/storage/shared/Android/data/org.dolphinemu.dolphinemu  &>> ~/storage/shared/pegasus_installer_log.log
	rm ~/storage/shared/Android/data/org.dolphinemu.dolphinemu_bak  &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi


FOLDER=~/storage/shared/duckstation_bak/
if [ -d "$FOLDER" ]; then
	echo -ne "Restoring RetroArch config..."
	cp ~/storage/shared/duckstation_bak/ ~/storage/shared/duckstation/  &>> ~/storage/shared/pegasus_installer_log.log
	rm ~/storage/shared/duckstation_bak/  &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi

echo -e "${GREEN}All cleaned up!${NONE}"
echo -e  "We hope to see you come back soon!"
echo -e  "${BOLD}NOTE:${NONE} Termux, Pegasus and all the emulators have to be uninstalled like any other Android app. Pegasus themes were not deleted either"
if [ $useInternalStorage == false ]; then
	echo -e "${RED}IMPORTANT${NONE}"
	echo -e "Be aware that if you delete the Termux app Android will ${RED}DELETE${NONE} all the roms on your SD Card"
fi
echo -e  "Press the ${RED}A button${NONE} to finish"
read pause
am startservice -a com.termux.service_stop com.termux/.app.TermuxService
