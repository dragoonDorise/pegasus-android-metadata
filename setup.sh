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
echo -e  "The script might ask you to confirm some steps along the installation proccess, just type Y ( capital ) and press A button when asked"
echo -e  "${BLINK}Press now the A button  to start${NONE}"
read pausa
clear
echo -ne "Installing components, please be patient..."
pkg update -y -F &> /dev/null && pkg upgrade -y -F &> /dev/null
#pkg install x11-repo build-essential qt5-qtbase -y 
pkg install git wget rsync unzip whiptail -y  &> /dev/null
termux-setup-storage &> /dev/null
mkdir ~/dragoonDoriseTools &> /dev/null
cd dragoonDoriseTools &> /dev/null
echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Metadata, please be patient..."
#Download Pegasus Metadata files
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git pegasus-android-metadata/ &> /dev/null
#git clone https://github.com/muldjord/skyscraper.git skyscraper
echo -e "${GREEN}OK${NONE}"

#Download Pegasus
echo -ne "Downloading Pegasus, please be patient..."
wget https://github.com/mmatyas/pegasus-frontend/releases/download/weekly_2021w40/pegasus-fe_alpha15-85-gfff1a5b2_android.apk &> /dev/null
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
mkdir ~/storage/shared/pegasus-frontend &> /dev/null
mkdir ~/storage/shared/pegasus-frontend/themes &> /dev/null
echo -e "${GREEN}OK${NONE}"

#Backup
echo -ne "Creating Backups of everything..."
cp ~/storage/shared/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &> /dev/null
cp ~/storage/shared/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &> /dev/null
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &> /dev/null
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &> /dev/null
echo -e "${GREEN}OK${NONE}"

echo -ne "Installing Scrap, Update & Undo Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh &> /dev/null
chmod a+rwx ~/update.sh &> /dev/null
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh &> /dev/null
chmod a+rwx ~/scrap.sh &> /dev/null
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh &> /dev/null
chmod a+rwx ~/undo.sh &> /dev/null
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
sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &> /dev/null 
# Instaling roms folders
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1 &> /dev/null
echo -e "${GREEN}OK${NONE}"

#Configure Retroarch
echo -ne "Creating RetroArch Backup..."
cp -r ~/storage/shared/RetroArch/config/ ~/storage/shared/RetroArch/config_bak/ &> /dev/null
cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg &> /dev/null
echo -e "${GREEN}OK${NONE}"

echo -e "Do you have an Anbernic RG552? Some extra Snes configuration will be done for you :) "
echo -e "Type Y if you do and press the button A."
read handheldModel


echo -ne "Configuring Retroarch..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/ &> /dev/null


if [ $handheldModel == "y" ]
then
	mkdir ~/storage/shared/RetroArch/config/Snes9x &> /dev/null
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/rg552/RetroArch/config/Snes9x/snes9x.cfg ~/storage/shared/RetroArch/config/Snes9x &> /dev/null
fi


if [ $handheldModel == "Y" ]
then
	mkdir ~/storage/shared/RetroArch/config/Snes9x &> /dev/null
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/rg552/RetroArch/config/Snes9x/snes9x.cfg ~/storage/shared/RetroArch/config/Snes9x &> /dev/null
fi

#Configs
sed -i 's/config_save_on_exit = "true"/config_save_on_exit = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_overlay_enable = "true"/input_overlay_enable = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/menu_show_load_content_animation = "true"/menu_show_load_content_animation = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_autoconfig = "true"/notification_show_autoconfig = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_config_override_load = "true"/notification_show_config_override_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_refresh_rate = "true"/notification_show_refresh_rate = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_remap_load = "true"/notification_show_remap_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_screenshot = "true"/notification_show_screenshot = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_set_initial_disk = "true"/notification_show_set_initial_disk = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 

sed -i 's/notification_show_patch_applied = "true"/notification_show_patch_applied = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/video_scale_integer = "false"/video_scale_integer = "true"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_menu_toggle_gamepad_combo = "0"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 

sed -i 's/input_enable_hotkey_btn = "nul"/input_enable_hotkey_btn = "109"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_exit_emulator_btn = "nul"/input_exit_emulator_btn = "108"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_load_state_btn = "nul"/input_load_state_btn = "102"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_menu_toggle_gamepad_combo = "nul"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 

sed -i 's/input_rewind_btn = "nul"/input_rewind_btn = "104"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_save_state_btn = "nul"/input_save_state_btn = "103"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_state_slot_decrease_btn = "nul"/input_state_slot_decrease_btn = "h0down"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_state_slot_increase_btn = "nul"/input_state_slot_increase_btn = "h0up"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_toggle_fast_forward_btn = "nul"/input_toggle_fast_forward_btn = "105"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 

#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 


echo -e "${GREEN}OK${NONE}"

# Install Themes for Pegasus
echo -ne "Downloading Pegasus Theme : RP Epic Noir..."
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themes/RP-epic-noir &> /dev/null
echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Pegasus Theme : RP Switch..."
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themes/RP-switch &> /dev/null
echo -e "${GREEN}OK${NONE}"
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
echo -e  "If you need to scrap more roms in the future, just open ${BOLD}Termux${NONE} and run this command"
echo -e  "${UNDERLINE}bash scrap.sh${NONE}"
echo -e  "If you need to uninstall this Pack run this command"
echo -e  "${UNDERLINE}bash undo.sh${NONE}"
echo -e  "If you want to update this Pack so you get more systems and themes in the future, run this command"
echo -e  "${UNDERLINE}bash update.sh${NONE}"

exit