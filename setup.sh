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
#Uninstall everything first
rm -rf ~/dragoonDoriseTools  &>> /dev/null
rm -f scrap.sh &>> /dev/null
rm -f update.sh  &>> /dev/null
rm -f run_update.sh  &>> /dev/null
rm -f undo.sh  &>> /dev/null
rm -f startup.sh  &>> /dev/null
rm -f snes_config.sh  &>> /dev/null
rm -f ~/storage/shared/scrap.log  &>> /dev/null

rm -rf ~/storage &>> /dev/null
termux-setup-storage
echo -e "Pegasus installer 1.3.1"
echo -e  "${BOLD}Hi!${NONE} We're gonna start configuring your ${GREEN}Android Device${NONE}"
echo -e  "We recommend you to hide the virtual keyboard by swiping from the left of the screen."
echo -e  "${RED}Read before continuing${NONE}"
echo -e  "If you are going to store your roms in the SD Card make sure your SD Card is inserted"
echo -e  "${BOLD}Because of Termux limitations you can't use custom folders for your roms${NONE}"
echo -e  "${BOLD}This script will create all the rom folders for you in your device${NONE}"
echo -e  "Nothing will be erased from your SD Card"
echo -e  "Press the ${RED}A button${NONE} to start"

read clear

echo -ne "Installing components, please be patient..."
rm ~/storage/shared/pegasus_installer_log.log &>> /dev/null
touch ~/storage/shared/pegasus_installer_log.log &>> /dev/null
sleep .5
pkg update -y -F &>> ~/storage/shared/pegasus_installer_log.log && pkg upgrade -y -F &>> ~/storage/shared/pegasus_installer_log.log
pkg install git wget jq rsync unzip whiptail -y  &>> ~/storage/shared/pegasus_installer_log.log

mkdir ~/dragoonDoriseTools &>> ~/storage/shared/pegasus_installer_log.log
cd ~/dragoonDoriseTools &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"



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

while true; do
	#touch ~/dragoonDoriseTools/.device
	echo $handheldModel > ~/dragoonDoriseTools/.device

	FILE=~/dragoonDoriseTools/.device
	if [ -f "$FILE" ]; then
		break;
	fi
	handheldModel=$(whiptail --title "What Android Device do you have" \
	   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
		"RG552" "Anbernic RG552" OFF \
		"ODIN" "AYN Odin" OFF \
		"RP2+" "Retroid Pocket 2+" OFF \
		"ANDROID" "A regular Android Device" OFF \
	   3>&1 1<&2 2>&3)
done



echo -e "Downloading Metadata Pack for Android, please be patient..."
#Download Pegasus Metadata files
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git ~/dragoonDoriseTools/pegasus-android-metadata
#Validate
FOLDER=~/dragoonDoriseTools/pegasus-android-metadata/
if [ -d "$FOLDER" ]; then
	echo -e "${GREEN}Download OK${NONE}"
else
	echo -e "${RED}ERROR${NONE}"
	echo -e "It seems Termux repositories are down. Let's fix it"
	echo -e "When you press the ${RED}A button${NONE} selector will open. In the first screen ${BOLD}select all three options with the ${GREEN}Y button${NONE} and then Accept using the ${RED}A button${NONE}${NONE}"
	echo -e "Then in the next screen select the first option and press the ${RED}A button${NONE}"
	read pause
	termux-change-repo
	pkg update -y -F &>> ~/storage/shared/pegasus_installer_log.log && pkg upgrade -y -F &>> ~/storage/shared/pegasus_installer_log.log
	pkg install git wget rsync unzip whiptail -y  &>> ~/storage/shared/pegasus_installer_log.log
	
	
fi

clear

cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans

#Detect installed emulators

/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emu_check.sh


#Download Pegasus
echo -e "Downloading Pegasus, please be patient..."
wget   -q --show-progress https://github.com/mmatyas/pegasus-frontend/releases/download/weekly_2021w40/pegasus-fe_alpha15-85-gfff1a5b2_android.apk -P ~/dragoonDoriseTools

echo -e  "Now let's install ${RED}Pegasus${NONE}"
echo -e  "Press the ${RED}A button${NONE} to install Pegasus, when Pegasus is installed click ${BOLD}DONE${NONE} in the installation window so you can come back to continue the next steps"
read pause
clear
echo -ne  "Installing ${RED}Pegasus${NONE}..."
#Launch Pegasus
xdg-open ~/dragoonDoriseTools/pegasus-fe_alpha15-85-gfff1a5b2_android.apk
echo -e  "${GREEN}OK${NONE}"
echo ""


#Configure Pegasus
echo -ne "Configuring Pegasus..."
mkdir ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
mkdir ~/storage/shared/pegasus-frontend/themes &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

#Backup
echo -ne "Creating Backups of everything..."
cp ~/storage/shared/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &>> ~/storage/shared/pegasus_installer_log.log
cp ~/storage/shared/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -ne "Installing Scrap, Update & Undo Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/update.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/run_update.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/run_update.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/scrap.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/undo.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/startup.sh  ~/startup.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/startup.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/snes_config.sh  ~/snes_config.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/snes_config.sh &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"
clear
while true; do
	storageOption=$(whiptail --title "Where do you want to store your roms?" \
   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"SDCard" "The roms will be stored in your SD Card or external HD" ON \
	"Internal" "The roms will be stored in your Internal Storage " OFF \
   3>&1 1<&2 2>&3)
	case $storageOption in
		[SDCard]* ) break;;
		[Internal]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
   
 done

rm ~/dragoonDoriseTools/.storageInternal &> /dev/null
rm ~/dragoonDoriseTools/.storageSD &> /dev/null
echo -ne "Storage Selected..."
if [[ $storageOption == 'Internal' ]]; then
	touch ~/dragoonDoriseTools/.storageInternal &> /dev/null
	storageLocation="shared/roms"
	echo -e "${GREEN}Internal${NONE}"
else
	touch ~/dragoonDoriseTools/.storageSD &> /dev/null
	storageLocation="external-1"
	#We get the SD Card Volume name
	sdcardID=false
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

	 if [ $sdcardID == false ]; then
	 
		 echo -e "We couldn't find your SD Card name"
		echo -e "Maybe you are using an extenal HD Drive" 
		echo -e "Please type the name of the right storage."
		echo -e "${BOLD}This is case sensitive${NONE}."
		echo ""			
			for entry in /storage/*
			 do
				 
				 #echo $entry
				 if [ $entry != '/storage/emulated' ] && [ $entry != '/storage/self' ]; then
					 firstString=$entry
					 secondString=""
					 path="${firstString/"/storage/"/"$secondString"}"   
					 echo $path 
				 fi
			 done			
		echo ""
		echo -e "Then press the ${RED}A button${NONE}" 		
		read sdcardID
		 
	 fi
	 
	mkdir ~/storage/shared/roms &> /dev/null
	echo -e "${GREEN}SD Card${NONE}"
fi

useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
fi


 
echo -ne "Configuring Rom Storage..."
if [ $useInternalStorage == false ]; then
	sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log 
else
	sed -i "s/0000-0000/emulated\/0\/roms/g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log 
fi



# Instaling roms folders
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/$storageLocation &>> ~/storage/shared/pegasus_installer_log.log


#Retroarch 64? We edit the metadatafiles
hasRetroArch64=false
FOLDER64=~/storage/shared/Android/data/com.retroarch.aarch64
if [ -d "$FOLDER64" ]; then
	hasRetroArch64=true
fi
if [[ $hasRetroArch64 == true ]]; then
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/com.retroarch\//com.retroarch.aarch64\//g' {} \;
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/-e DATADIR \/data\/data\/com.retroarch/-e DATADIR \/data\/data\/com.retroarch.aarch64/g' {} \;	
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/.browser.retroactivity/com.retroarch.browser.retroactivity/g' {} \;	
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/com.retroarch-1/com.retroarch.aarch64-1/g' {} \;	
fi
echo -e "${GREEN}OK${NONE}"


#Configure Retroarch
echo -ne "Creating RetroArch Backup..."
#We create the backup only if we don't have one, to prevent erasing the original backup if the user reinstalls
FOLDER=~/storage/shared/RetroArch/config_bak/
if [ -d "$FOLDER" ]; then
	echo -e "${GREEN}OK${NONE}"
else
	cp -r ~/storage/shared/RetroArch/config/ ~/storage/shared/RetroArch/config_bak/ &>> ~/storage/shared/pegasus_installer_log.log
	cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi

echo -ne "Configuring Retroarch..."

#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/retroarch_config.sh $handheldModel
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emus_config.sh

clear

# Install Themes for Pegasus
echo -ne "Downloading Pegasus Theme : RP Epic Noir..."
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themes/RP-epic-noir &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Pegasus Theme : RP Switch..."
#We delete the theme, for previous users
rm -rf ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

if [ $handheldModel != 'RP2+' ]; then

	echo -ne "Downloading Pegasus Theme : GameOS..."
	git clone https://github.com/PlayingKarrde/gameOS.git ~/storage/shared/pegasus-frontend/themes/gameOS &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"

	echo -ne "Downloading Pegasus Theme : ClearOS..."
	git clone https://github.com/PlayingKarrde/clearOS.git ~/storage/shared/pegasus-frontend/themes/clearOS &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
	
	echo -ne "Downloading Pegasus Theme : NeoRetro Dark..."
	git clone https://github.com/TigraTT-Driver/neoretro-dark.git ~/storage/shared/pegasus-frontend/themes/neoretro-dark &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"

fi

if [ $handheldModel == 'RP2+' ]; then

	echo -ne "Downloading Pegasus Theme : Retro Mega..."
	git clone https://github.com/plaidman/retromega-next.git ~/storage/shared/pegasus-frontend/themes/retromega &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"

fi
	echo -e "The default theme on Pegasus is RP Epic Noir"
	echo -e "You can change it anytime on Pegasus."
	echo -e  "Press the ${RED}A button${NONE} to continue to next step"
	read pause


echo "/bin/bash ~/startup.sh" > ~/.bashrc
sleep .5
clear
echo -e ""
echo -e ""
echo -e  "${GREEN}Success!!${NONE}"
echo -e ""
echo -e  "We've finished the first step!"
echo -e  ""
if [ $useInternalStorage == false ]; then
	echo -e  "You can now remove your SD Card and start copying your roms"
	echo -e  "Insert your SD Card in your computer and go to this folder in your SD Card: ${GREEN}/Android/data/com.termux/files/${NONE}"
	echo -e  "Because of Android Restrictions you need to have your roms there, ${BOLD}they cannot be on another folder${NONE}"
	echo -e  "You will see that every system has its own folder, just copy your roms to the corresponding folder."
else
	echo -e  "You can now copy your roms in the ${BOLD}roms${NONE} directory in the Internal Storage of your device"
	echo -e  "You will see that every system has its own folder, just copy your roms to the corresponding folder."
fi
echo -e  "${BOLD}We recommend roms named after no-intro romsets${NONE}"
echo -e ""

echo -e  "Press the ${RED}A button${NONE} to continue to next step"
read pause
clear

echo -e "${YELLOW}Retroarch Cores${NONE}"
echo -e "Remember to go to Retroarch's Main Menu -> Load Core -> Install or Restore a Core"
echo -e "And then select the core you want to install"
echo -e ""
echo -e "${YELLOW}BIOS${NONE}"
echo -e "Remember to copy your BIOS files for the following emulators:"
echo -e "RetroArch - internal storage/RetroArch/system folder"
echo -e "Duckstation & AetherSX2 on App Settings, BIOS section"
echo -e ""
echo -e "${RED}IMPORTANT${NONE}"
echo -e "Be aware that if you delete the Termux app Android will ${RED}DELETE${NONE} the Termux folder on your SD Card"
echo -e "The roms on ${GREEN}/Android/data/com.termux/files/${NONE} will be deleted"
echo -e "No other files on the SD Card will be affected"
echo -e  "Press the ${RED}A button${NONE} to continue to next step"
read pause

while true; do
	scrapNow=$(whiptail --title "Do you want to scrap your roms now?" \
   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"YES" "Scrap my roms!" OFF \
	"NO" "You can always do the scraping later by opening Termux" OFF \
   3>&1 1<&2 2>&3)
	case $scrapNow in
		[YES]* ) break;;
		[NO]* ) break;;	
		* ) echo "Please answer yes or no.";;
	esac
   
 done

if [ $scrapNow == "YES" ]; then
	clear
	echo -e  "";
	echo -e  "Do you have your roms ready on your SD Card or Internal Storage?"
	echo -e  "${BOLD}Let's start getting all your artwork!${NONE}"
	echo -e  "Press the ${RED}A button${NONE} to continue"
	read pause
	cd ~/
	bash ~/scrap.sh	
else
	clear	
	echo -e  "${STRONG}If you want to scrap more roms, update or uninstall Pegasus Installer:${NONE}"
	echo -e  "Just open the Termux app again"
	echo -e  "Press the ${RED}A button${NONE} to exit"
	read pause
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null

fi

