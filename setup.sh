#!/bin/sh

echo "Hi! We're gonna start configuring your Android Device"
echo "Make sure your SD Card is inserted"
echo "Press Enter to start"
read pausa
#pkg update -y && pkg upgrade -y
#pkg install x11-repo build-essential qt5-qtbase -y 
pkg install git wget rsync unzip -y
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
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ./
chmod a+rwx update.sh
echo "Remember the XXXX-XXXX number we get from RetroArch? Now is the time to use it:)"
echo "Type it here and press Enter"
read sdcard

sed -i "s/0000-0000\//${sdcard}\/Android\/data\/com.termux\/files/g" ~/storage/shared/pegasus-frontend/game_dirs.txt 

# Instaling roms folders

rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1
#git clone https://github.com/dragoonDorise/pegasus-artwork.git ~/storage/external-1/.
#unzip 
#Configure Retroarch
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/


# Install Themes for Pegasus
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themesRP-epic-noir
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themesRP-switch


echo "You can now remove your SD Card"
echo "Insert your SD Card on your computer and copy your roms to the /Android/data/com.termux/files folder you will see there, every system has it's own folder for each set of roms"
echo "Meanwhile press Enter, we will install Pegasus"
echo "If you need to update Pegasus or the themes presents on this guide just come back to Termux and execute update.sh and follow the instructions"
read pause

rm -rf ~/dragoonDoriseTools/

#Launch Pegasus
xdg-open pegasus-fe_alpha15-85-gfff1a5b2_android.apk

echo "All Done! You can now close Termux"