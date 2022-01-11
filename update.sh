#!/bin/sh
echo 'Lets update your themes, shall we? Press Enter if you agree ;)'
read pause
cd ~/storage/shared/pegasus-frontend/themesRP-epic-noir
git pull

cd ~/storage/shared/pegasus-frontend/themesRP-switch
git pull

echo 'Done! If you want to update the metadata pack press Enter, close Termux otherwise.'
echo 'DISCLAIMER: This will remove any changes you could have made to Pegasus metatada files or RetroArch core overrides'
echo "This won't delete any roms"
read pause

#RetroArch Update
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/

#Metadata update
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git pegasus-android-metadata/
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1

#update script update
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ./
chmod a+rwx update.sh

rm -rf ~/dragoonDoriseTools/

echo "All done, you can now close Termux. See you!"