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

echo -ne  "Updating Themes..."
cd ~/storage/shared/pegasus-frontend/themes/RP-epic-noir
git reset --hard &> /dev/null 
git pull &> /dev/null 

cd ~/storage/shared/pegasus-frontend/themes/RP-switch
git reset --hard &> /dev/null 
git pull &> /dev/null 
echo -e "${GREEN}OK${NONE}"
clear
echo -e  "${GREEN}Done!${BOLD}If you want to update the metadata pack press the A Button, ${BOLD}close Termux otherwise.${NONE}"
echo -e  "${RED}DISCLAIMER:${BOLD} This will remove any changes you could have made to Pegasus metadata files or RetroArch core overrides"
echo -e  "${BOLD}This won't delete any roms${NONE}"
read pause

#RetroArch Update
echo -ne  "Updating Retroarch Configs..."
cd ~/dragoonDoriseTools/pegasus-android-metadata/ &> /dev/null 
git reset --hard &> /dev/null 
git pull &> /dev/null 
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/ &> /dev/null 
sed -i 's/config_save_on_exit = "true"/config_save_on_exit = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_overlay_enable = "true"/input_overlay_enable = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/menu_show_load_content_animation = "true"/menu_show_load_content_animation = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_autoconfig = "true"/notification_show_autoconfig = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_config_override_load = "true"/notification_show_config_override_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_refresh_rate = "true"/notification_show_refresh_rate = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_remap_load = "true"/notification_show_remap_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_screenshot = "true"/notification_show_screenshot = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_set_initial_disk = "true"/notification_show_set_initial_disk = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/video_scale_integer = "false"/video_scale_integer = "true"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
echo -e "${GREEN}OK${NONE}"
cd ~/dragoonDoriseTools/
#Metadata update
echo -ne  "Updating Metadata..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1
echo -e "${GREEN}OK${NONE}"

#update scripts
echo -ne  "Updating Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/dragoonDoriseTools/update.sh
chmod a+rwx ~/dragoonDoriseTools/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/dragoonDoriseTools/scrap.sh
chmod a+rwx ~/dragoonDoriseTools/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/dragoonDoriseTools/undo.sh
chmod a+rwx ~/dragoonDoriseTools/undo.sh
echo -e "${GREEN}OK${NONE}"
echo ""
echo -e  "${GREEN}Update Complete${NONE}"