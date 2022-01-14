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

clear
echo "${BOLD}Hi!${NONE} We're gonna start configuring your ${GREEN}Android Device${NONE}"
echo "Make sure your SD Card is ${UNDERLINE}inserted${NONE}"
echo "The script might ask you to confirm some steps of the installation, just type Y ( capital ) and press A button when asked"
echo "Press now Enter to start"
read pausa
pkg update -y -F && pkg upgrade -y -F
#pkg install x11-repo build-essential qt5-qtbase -y 
pkg install git wget rsync unzip whiptail -y
termux-setup-storage
mkdir ~/dragoonDoriseTools
cd dragoonDoriseTools


#Download Pegasus Metadata files
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git pegasus-android-metadata/ 
#git clone https://github.com/muldjord/skyscraper.git skyscraper

#Download Pegasus
wget https://github.com/mmatyas/pegasus-frontend/releases/download/weekly_2021w40/pegasus-fe_alpha15-85-gfff1a5b2_android.apk

#Install Skyscraper
#cd skyscraper
#qmake
#make
#chmod a+rwx Skyscraper
#cp Skyscraper /data/data/com.termux/files/usr/bin
#cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/artwork.xml /data/data/com.termux/files/usr/bin
#cd ..

#Configure Pegasus
mkdir ~/storage/shared/pegasus-frontend
mkdir ~/storage/shared/pegasus-frontend/themes

#Backup
cp ~/storage/shared/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend/settings.txt.bak
cp ~/storage/shared/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend/settings.txt.bak

cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend

cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh
chmod a+rwx ~/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh
chmod a+rwx ~/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh
chmod a+rwx ~/undo.sh


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
 

sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt 

# Instaling roms folders

rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1
#git clone https://github.com/dragoonDorise/pegasus-artwork.git ~/dragoonDoriseTools/
#unzip ~/dragoonDoriseTools/art.zip
#rm ~/dragoonDoriseTools/art.zip
#rsync -r ~/dragoonDoriseTools/art/ ~/storage/external-1

#Configure Retroarch
cp ~/storage/shared/RetroArch/config/ ~/storage/shared/RetroArch/config_bak/
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/


# Install Themes for Pegasus
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themesRP-epic-noir
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themesRP-switch

clear
echo "${GREEN}Success!!${NONE}"
echo "We've finish the first step"
echo ""
echo "You can now remove your SD Card"
echo "Insert your SD Card on your computer and go to this folder in your SD Card: ${GREEN}/Android/data/com.termux/files${NONE}."
echo "You will see there that every system has its own folder for each set of roms, just copy your roms on every folder. ${BOLD}We recommend roms named after no-intro romsets${NONE}"
echo "Now let's install ${RED}Pegasus${NONE}"
Echo "Press the A Button to install Pegasus, Remember to come back to scrap your roms artwork!"
read pause

#Launch Pegasus
xdg-open ~/dragoonDoriseTools/pegasus-fe_alpha15-85-gfff1a5b2_android.apk
echo "${GREEN}All Done, do you have you SD Card inserted with all your roms?${NONE}"
echo "${BOLD}Let's start getting all your artwork!${NONE}"
cd ~/
bash scrap.sh
clear
echo "${GREEN}Done!${NONE}"
echo "If you need to scrap more roms in the future, just open ${BOLD}Termus${NONE} and run this command"
echo "${UNDERLINE}bash scrap.sh${NONE}"
echo "If you need to uninstall this Pack run this command"
echo "${UNDERLINE}bash undo.sh${NONE}"
echo "If you want to update this Pack so you get more systems and themes in the future, run this command"
echo "${UNDERLINE}bash update.sh${NONE}"

exit