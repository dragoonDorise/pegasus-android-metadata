#!/bin/sh

rm -rf ~/dragoonDoriseTools

#Restoring Pegasus
cp ~/storage/shared/pegasus-frontend/settings.txt.bak ~/storage/shared/pegasus-frontend/settings.txt
cp ~/storage/shared/pegasus-frontend/game_dirs.txt.bak ~/storage/shared/pegasus-frontend/settings.txt

#Restoring Pegasus
rm -f scrap.sh
rm -f update.sh
rm -f undo.sh

rm -f pegasus-fe_alpha15-85-gfff1a5b2_android.apk

clear

echo "All cleaned up!"
echo "We Hope to see you come back soon!"
echo "NOTE: Termux and Pegasus have to be uninstalled like any other Android app. Pegasus themes are not deleted either"

exit