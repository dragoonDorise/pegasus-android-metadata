#!/bin/sh
pkg update && pkg upgrade
pkg install git -Y
termux-setup-storage
mkdir ~/dragoonDoriseTools
cd dragoonDoriseTools


#Download Pegasus Metadata files
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git pegasus-android-metadata/ 

#Download Pegasus
curl https://github.com/mmatyas/pegasus-frontend/releases/download/weekly_2021w40/pegasus-fe_alpha15-85-gfff1a5b2_android.apk --output pegasus.15.85.apk

#Install Skyscraper
chmod a+rwx ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/Skyscraper
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/Skyscraper /data/data/com.termux/files/usr/bin
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/artwork.xml /data/data/com.termux/files/usr/bin

#Configure Pegasus
mkdir ~/storage/shared/pegasus-frontend
mkdir ~/storage/shared/pegasus-frontend/themes
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/settings.txt ~/storage/shared/pegasus-frontend
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/game_dirs.txt ~/storage/shared/pegasus-frontend

# Install Themes on Pegasus
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themesRP-epic-noir
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themesRP-switch

#Configure RetroArch

#Launch Pegasus
xdg-open pegasus.15.85.apk