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

echo -e  "${BOLD}Hi!${NONE} We're gonna start configuring your ${GREEN}Android Device${NONE}"
echo -e  "Make sure your SD Card is ${UNDERLINE}inserted${NONE}"
echo -e  "${BLINK}Press now the A button  to start${NONE}"
termux-setup-storage
read pausa
clear
echo -ne "Installing components, please be patient..."
rm ~/storage/shared/pegasus_installer_log.log &> /dev/null
touch ~/storage/shared/pegasus_installer_log.log &> /dev/null
sleep .5
pkg update -y -F &> ~/storage/shared/pegasus_installer_log.log && pkg upgrade -y -F &> ~/storage/shared/pegasus_installer_log.log
#pkg install x11-repo build-essential qt5-qtbase -y 
pkg install git wget rsync unzip whiptail -y  &> ~/storage/shared/pegasus_installer_log.log

mkdir ~/dragoonDoriseTools &> ~/storage/shared/pegasus_installer_log.log
cd dragoonDoriseTools &> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Metadata, please be patient..."
#Download Pegasus Metadata files
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git pegasus-android-metadata/ &> ~/storage/shared/pegasus_installer_log.log
#git clone https://github.com/muldjord/skyscraper.git skyscraper
echo -e "${GREEN}OK${NONE}"
clear
cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans
#Download Pegasus
echo -ne "Downloading Pegasus, please be patient..."
wget https://github.com/mmatyas/pegasus-frontend/releases/download/weekly_2021w40/pegasus-fe_alpha15-85-gfff1a5b2_android.apk &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

#Install Skyscraper
#cd skyscraper
#qmake
#make
#chmod a+rwx Skyscraper
#cp Skyscraper /data/data/com.termux/files/usr/bin
#cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/artwork.xml /data/data/com.termux/files/usr/bin
#cd ..

#Configure Pegasus
echo -ne "Configuring Pegasus..."
mkdir ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log
mkdir ~/storage/shared/pegasus-frontend/themes &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

#Backup
echo -ne "Creating Backups of everything..."
cp ~/storage/shared/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &> ~/storage/shared/pegasus_installer_log.log
cp ~/storage/shared/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -ne "Installing Scrap, Update & Undo Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh &> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/update.sh &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh &> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/scrap.sh &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh &> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/undo.sh &> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/startup.sh  ~/startup.sh &> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/startup.sh &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

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
 
echo -ne "Configuring SD Card..."
sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &> ~/storage/shared/pegasus_installer_log.log 
# Instaling roms folders
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1 &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

#Configure Retroarch
echo -ne "Creating RetroArch Backup..."
cp -r ~/storage/shared/RetroArch/config/ ~/storage/shared/RetroArch/config_bak/ &> ~/storage/shared/pegasus_installer_log.log
cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -e "Do you have an Anbernic RG552? Some extra configuration will be done for your system :) "
echo -e "Type Y if you do, type N if you don't and press the button A."
read handheldQuestion


echo -ne "Configuring Retroarch..."

handheldModel="169"

if [ $handheldQuestion == "y" ]
then
	handheldModel="RG552"
fi

if [ $handheldQuestion == "Y" ]
then
	handheldModel="RG552"
fi

# 5:3 Detection flag
if [ $handheldModel == "RG552" ]
then
	touch ~/dragoonDoriseTools/.isRG552
fi


#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/retroarch_config.sh $handheldModel

echo -e "${GREEN}OK${NONE}"

# Install Themes for Pegasus
echo -ne "Downloading Pegasus Theme : RP Epic Noir..."
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themes/RP-epic-noir &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Pegasus Theme : RP Switch..."
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themes/RP-switch &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo "/bin/bash ~/startup.sh" > ~/.bashrc
sleep .5

echo -e  "${GREEN}Success!!${NONE}"
echo -e  "We've finished the first step!"
echo -e  ""
echo -e  "You can now remove your SD Card"
echo -e  "Insert your SD Card on your computer and go to this folder in your SD Card: ${GREEN}/Android/data/com.termux/files${NONE}."
echo -e  "You will see there that every system has its own folder for each set of roms, just copy your roms on the corresponding folder for each system."
echo -e  "${BOLD}We recommend roms named after no-intro romsets${NONE}"
echo -e  "Now let's install ${RED}Pegasus${NONE}"
echo -e  "Press the A Button to install Pegasus, when Pegasus is installed click ${BOLD}DONE${NONE} in the instalation window so you can come back to scrap your roms' artwork!"
read pause

#Launch Pegasus
xdg-open ~/dragoonDoriseTools/pegasus-fe_alpha15-85-gfff1a5b2_android.apk
clear
echo -e  "${GREEN}All Done${NONE}, do you have your SD Card inserted with all your roms?"
echo -e  "${BOLD}Let's start getting all your artwork!${NONE}"
echo -e  "Press the A Button to continue"
read pause
cd ~/
bash scrap.sh
clear
echo -e  "${GREEN}Done!${NONE}"

echo -e  "If you open ${BOLD}Termux${NONE} again, a Menu will appear with several options:"
echo -e  "${UNDERLINE}Uninstall Pegasus Installer${NONE}"
echo -e  "${UNDERLINE}Update Pegasus Installer${NONE}"
echo -e  "${UNDERLINE}Scrap Roms${NONE}"

echo -e "${RED}HOW TO INSTALL CORES${NONE} Remember to go to Retroarch's Main Menu -> Load Core -> Install or Restore a Core"
echo -e "And then select the core you want to install"
echo -e  "Press the A Button to finish"
read pause

exit