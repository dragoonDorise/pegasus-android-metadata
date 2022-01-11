#!/bin/sh

echo "Hi! We're gonna start configuring your Android Device, if the systems asks you any question, just press y and enter :)"
echo "Press Enter to start"
read pausa
#pkg update -y && pkg upgrade -y
#pkg install x11-repo build-essential qt5-qtbase -y 
pkg install git wget rsync -y
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

#Configure Retroarch
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/


# Install Themes on Pegasus
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themesRP-epic-noir
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themesRP-switch

#Configure RetroArch

#Launch Pegasus
xdg-open pegasus-fe_alpha15-85-gfff1a5b2_android.apk