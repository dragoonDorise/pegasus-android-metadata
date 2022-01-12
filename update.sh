#!/bin/sh
echo 'Lets update your themes, shall we? Press Enter if you agree ;)'
read pause
cd ~/storage/shared/pegasus-frontend/themesRP-epic-noir
git pull

cd ~/storage/shared/pegasus-frontend/themesRP-switch
git pull


echo 'Done! If you want to update the metadata pack press Enter, close Termux otherwise.'
echo 'DISCLAIMER: This will remove any changes you could have made to Pegasus metadata files or RetroArch core overrides'
echo "This won't delete any roms"
read pause

#RetroArch Update
cd ~/dragoonDoriseTools/pegasus-android-metadata/
git reset --hard
git pull
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/
cd ~/dragoonDoriseTools/
#Metadata update
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/external-1

#update scripts
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/dragoonDoriseTools/update.sh
chmod a+rwx ~/dragoonDoriseTools/update.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/dragoonDoriseTools/scrap.sh
chmod a+rwx ~/dragoonDoriseTools/scrap.sh
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/dragoonDoriseTools/undo.sh
chmod a+rwx ~/dragoonDoriseTools/undo.sh

#rm -rf ~/dragoonDoriseTools/

echo "All done, you can now close Termux. See you!"