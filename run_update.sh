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

echo "### Update started "  &>> ~/storage/shared/pegasus_installer_log.log

FILE=~/dragoonDoriseTools/.device
if [ -f "$FILE" ]; then
 echo ""
else
	while true; do
		export NEWT_COLORS="
		root=,red
		roottext=yellow,red"
			handheldModel=$(whiptail --title "What Android Device do you have" \
   		--radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
			"RG552" "Anbernic RG552" OFF \
			"ODIN" "AYN Odin" OFF \
			"RP2+" "Retroid Pocket 2+" OFF \
			"ANDROID" "A regular Android Device" OFF \
   		3>&1 1<&2 2>&3)
			case $handheldModel in
				[RG552]* ) break;;
				[ODIN]* ) break;;
				[RP2+]* ) break;;
				[ANDROID]* ) break;;
				* ) echo "Please answer yes or no.";;
			esac
   		
 	done
	 echo $handheldModel > ~/dragoonDoriseTools/.device
fi
#Handheld detector
handheldModel=$(cat ~/dragoonDoriseTools/.device)

useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"
	
fi
cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans
version=$(cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md)
#Detect installed emulators
hasRetroArch64=false
#Retroarch 64?
FOLDER64=~/storage/shared/Android/data/com.retroarch.aarch64
if [ -d "$FOLDER64" ]; then
	hasRetroArch64=true
fi
#update scripts
echo -ne  "Updating Scripts..."
pkg install git wget rsync unzip whiptail jq -y  &>> ~/storage/shared/pegasus_installer_log.log
echo "/bin/bash ~/startup.sh" > ~/.bashrc
echo -e "${GREEN}OK${NONE}"
echo "### Updating scripts "  &>> ~/storage/shared/pegasus_installer_log.log

echo -ne  "Updating Bundled Themes (won't affect any other themes)..."

FOLDER=~/storage/shared/pegasus-frontend/themes/RP-epic-noir
if [ -d "$FOLDER" ]; then
	cd ~/storage/shared/pegasus-frontend/themes/RP-epic-noir
	git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
	git pull &>> ~/storage/shared/pegasus_installer_log.log 
	
else
	echo -ne "Downloading Pegasus Theme : RP Epic Noir..."
	git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themes/RP-epic-noir &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi

FOLDER=~/storage/shared/pegasus-frontend/themes/RP-switch
if [ -d "$FOLDER" ]; then
	cd ~/storage/shared/pegasus-frontend/themes/RP-switch
	git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
	git pull &>> ~/storage/shared/pegasus_installer_log.log 
else
	echo -ne "Downloading Pegasus Theme : RP Switch..."
	#We delete the theme, for previous users
	rm -rf ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
	git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi


if [ $handheldModel != 'RP2+' ]; then
	
	FOLDER=~/storage/shared/pegasus-frontend/themes/gameOS
	if [ -d "$FOLDER" ]; then
		cd ~/storage/shared/pegasus-frontend/themes/gameOS
		git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
		git pull &>> ~/storage/shared/pegasus_installer_log.log 
		
	else
		echo -ne "Downloading Pegasus Theme : GameOS..."
		git clone https://github.com/PlayingKarrde/gameOS.git ~/storage/shared/pegasus-frontend/themes/gameOS &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"
	fi
	
	FOLDER=~/storage/shared/pegasus-frontend/themes/clearOS
	if [ -d "$FOLDER" ]; then
		cd ~/storage/shared/pegasus-frontend/themes/clearOS
		git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
		git pull &>> ~/storage/shared/pegasus_installer_log.log 
		
	else
		echo -ne "Downloading Pegasus Theme : ClearOS..."
		git clone https://github.com/PlayingKarrde/clearOS.git ~/storage/shared/pegasus-frontend/themes/clearOS &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"
	fi
	
	FOLDER=~/storage/shared/pegasus-frontend/themes/neoretro-dark
	if [ -d "$FOLDER" ]; then
		cd ~/storage/shared/pegasus-frontend/themes/neoretro-dark
		git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
		git pull &>> ~/storage/shared/pegasus_installer_log.log 
		
	else
		echo -ne "Downloading Pegasus Theme : NeoRetro Dark..."
		git clone https://github.com/TigraTT-Driver/neoretro-dark.git ~/storage/shared/pegasus-frontend/themes/neoretro-dark &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"
	fi
echo "### Themes updated "  &>> ~/storage/shared/pegasus_installer_log.log

fi

#RP2 Exclusive themes
if [ $handheldModel == 'RP2+' ]; then

	FOLDER=~/storage/shared/pegasus-frontend/themes/neoretro-dark
	if [ -d "$FOLDER" ]; then
	cd ~/storage/shared/pegasus-frontend/themes/retromega
	git reset --hard &>> ~/storage/shared/pegasus_installer_log.log 
	git pull &>> ~/storage/shared/pegasus_installer_log.log 
		
	else
		echo -ne "Downloading Pegasus Theme : Retro Mega..."
		git clone https://github.com/plaidman/retromega-next.git ~/storage/shared/pegasus-frontend/themes/retromega &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"
	fi
echo "### RP2+ themes updated"  &>> ~/storage/shared/pegasus_installer_log.log

fi
echo -e "${GREEN}OK${NONE}"

#Metadata update
echo -ne  "Updating Metadata..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/$storageLocation &>> ~/storage/shared/pegasus_installer_log.log
echo "### Rom folders updated "  &>> ~/storage/shared/pegasus_installer_log.log

#Retroarch64 support
if [ $hasRetroArch64 == true ]; then	
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/com.retroarch\//com.retroarch.aarch64\//g' {} \;
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/-e DATADIR \/data\/data\/com.retroarch/-e DATADIR \/data\/data\/com.retroarch.aarch64/g' {} \;	
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/.browser.retroactivity/com.retroarch.browser.retroactivity/g' {} \;	
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/com.retroarch-1/com.retroarch.aarch64-1/g' {} \;	
	echo "### RA64 sed"  &>> ~/storage/shared/pegasus_installer_log.log
	
fi
#cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log


if [ $useInternalStorage == false ]; then

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

 	sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log 

else

	sed -i "s/0000-0000/emulated\/0\/roms\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log

fi
echo -e "${GREEN}OK${NONE}"

echo "### Folder roms Pegasus updated "  &>> ~/storage/shared/pegasus_installer_log.log


FILE=~/dragoonDoriseTools/.isRG552
if [ -f "$FILE" ]; then
	rm ~/dragoonDoriseTools/.isRG552
	touch ~/dragoonDoriseTools/.device 
	echo 'RG552' > ~/dragoonDoriseTools/.device	
fi

#Emulator check
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emu_check.sh

#RetroArch Update
echo -ne  "Updating Retroarch Config..."
#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/retroarch_config.sh $handheldModel
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emus_config.sh

newVersion=$(cat ~/dragoonDoriseTools/pegasus-android-metadata/version.md)
echo ""
echo -e  "${GREEN}Update Completed${NONE}"
echo ""
echo -e  "${YELLOW}Changelog${NONE}"
cat ~/dragoonDoriseTools/pegasus-android-metadata/changelog.md
echo ""
echo -e  "Your version was: ${PURPLE}$version${NONE}"
echo -e "Installed version is now: ${GREEN}$newVersion${NONE}"
echo -e ""
echo "### Updated completed"  &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${YELLOW}REMEMBER TO INSTALL CORES${NONE} If you downloaded new cores.."
echo -e "Go to Retroarch's Main Menu -> Load Core -> Install or Restore a Core"
echo -e "And just select the core you want to install"
echo -e  "Press the ${RED}A button${NONE} to finish"
read pause
am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
