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
echo -ne  "Updating Updater..."
cd ~/dragoonDoriseTools/pegasus-android-metadata/ &>> ~/storage/shared/pegasus_installer_log.log 
git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
git pull &>> ~/storage/shared/pegasus_installer_log.log 
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh
chmod a+rwx ~/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/run_update.sh ~/run_update.sh
chmod a+rwx ~/run_update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh
chmod a+rwx ~/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh
chmod a+rwx ~/undo.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/startup.sh  ~/startup.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/startup.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/snes_config.sh  ~/snes_config.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/snes_config.sh &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"
/bin/bash ~/run_update.sh
