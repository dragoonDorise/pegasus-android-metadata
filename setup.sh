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
echo -e "Pegasus installer 1.3.4b"
echo -e  "${BOLD}Hi!${NONE} We're gonna start configuring your ${GREEN}Android Device${NONE}"
echo -e  "We recommend you to hide the virtual keyboard by swiping from the left of the screen."
echo -e  "${RED}Read before continuing${NONE}"
echo -e  "If you are going to store your roms in the SD Card make sure your SD Card is inserted"
echo -e  "${BOLD}Because of Termux limitations you can't use custom folders for your roms${NONE}"
echo -e  "${BOLD}This script will create all the rom folders for you in your device${NONE}"
echo -e  "Nothing will be erased from your SD Card"
echo -e  "If the script seems to be stuck in this frst step for several minutes or if asks you some questions, just press Y ( capital ) and ENTER when prompted"
echo -e  "This ussually happens on the Nvidia Shield"

echo -e  "Press the ${RED}A button${NONE} to start"
read clear
echo "### Installing pkgs"  &>> ~/storage/shared/pegasus_installer_log.log
echo -n "Installing components, please be patient..."

rm ~/storage/shared/pegasus_installer_log.log &>> /dev/null
touch ~/storage/shared/pegasus_installer_log.log &>> /dev/null
sleep .5
export DEBIAN_FRONTEND=noninteractive
apt-get update && 
	apt-get -o "Dpkg::Options::=--force-confold"  upgrade -q -y --force-yes &&
	apt-get -o "Dpkg::Options::=--force-confold"  dist-upgrade -q -y --force-yes
pkg autoclean
pkg update -y && pkg upgrade -y
pkg install git wget jq rsync unzip whiptail binutils build-essential liblz4 libuv ninja -y
echo "### Creating Dragoon Folder "  &>> ~/storage/shared/pegasus_installer_log.log
mkdir ~/dragoonDoriseTools &>> ~/storage/shared/pegasus_installer_log.log
cd ~/dragoonDoriseTools &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"

echo "### Git cloning "  &>> ~/storage/shared/pegasus_installer_log.log
echo -e "Downloading Metadata Pack for Android, please be patient..."
#Download Pegasus Metadata files
git clone https://github.com/dragoonDorise/pegasus-android-metadata.git ~/dragoonDoriseTools/pegasus-android-metadata
#Validate
FOLDER=~/dragoonDoriseTools/pegasus-android-metadata/
if [ -d "$FOLDER" ]; then
	echo -e "${GREEN}Download OK${NONE}"
	echo "### Repo cloned "  &>> ~/storage/shared/pegasus_installer_log.log
else
	echo "### Termux Mirrors down"  &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${RED}ERROR${NONE}"
	echo -e "It seems Termux repositories are down. Let's fix it"
	echo -e "When you press the ${RED}A button${NONE} selector will open. In the first screen ${BOLD}select all three options with the ${GREEN}Y button${NONE} and then Accept using the ${RED}A button${NONE}${NONE}"
	echo -e "Then in the next screen select the first option and press the ${RED}A button${NONE}"
	read pause
	termux-change-repo
	pkg update -y -F &>> ~/storage/shared/pegasus_installer_log.log && pkg upgrade -y -F &>> ~/storage/shared/pegasus_installer_log.log
	pkg install git wget jq rsync unzip whiptail binutils build-essential liblz4 libuv ninja -y  &>> ~/storage/shared/pegasus_installer_log.log
	
	
fi

clear

echo "### Handheld selection "  &>> ~/storage/shared/pegasus_installer_log.log

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
echo "### HandHeld Selected : ${handheldModel} "  &>> ~/storage/shared/pegasus_installer_log.log
while true; do
	#touch ~/dragoonDoriseTools/.device
	echo $handheldModel > ~/dragoonDoriseTools/.device
	echo "### Handlhedl selection failed first time "  &>> ~/storage/shared/pegasus_installer_log.log
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




cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans

#Detect installed emulators

/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emu_check.sh

echo "### Downloading Pegasus "  &>> ~/storage/shared/pegasus_installer_log.log

#Download Pegasus
echo -e "Downloading Pegasus, please be patient..."
wget   -q --show-progress https://github.com/mmatyas/pegasus-frontend/releases/download/alpha16/pegasus-fe_alpha16_android.apk -P ~/dragoonDoriseTools
echo "### Pegasus downloaded"  &>> ~/storage/shared/pegasus_installer_log.log

echo -e  "Now let's install ${RED}Pegasus${NONE}"
echo -e  "Press the ${RED}A button${NONE} to install Pegasus, when Pegasus is installed click ${BOLD}DONE${NONE} in the installation window so you can come back to continue the next steps"
read pause
clear
echo -ne  "Installing ${RED}Pegasus${NONE}..."
#Launch Pegasus
xdg-open ~/dragoonDoriseTools//pegasus-fe_alpha16_android.apk
echo -e  "${GREEN}OK${NONE}"
echo ""
echo "### Pegasus installed"  &>> ~/storage/shared/pegasus_installer_log.log


#Configure Pegasus
echo "### Configuring Pegasus "  &>> ~/storage/shared/pegasus_installer_log.log
echo -ne "Configuring Pegasus..."
mkdir ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
mkdir ~/storage/shared/pegasus-frontend/themes &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo "### Pegasus configured"  &>> ~/storage/shared/pegasus_installer_log.log
#Backup
echo "### Creating Backups "  &>> ~/storage/shared/pegasus_installer_log.log

echo -ne "Creating Backups of everything..."
cp ~/storage/shared/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend/settings.txt.bak &>> ~/storage/shared/pegasus_installer_log.log
cp ~/storage/shared/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend/game_dirs.txt.bak &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/settings.txt ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/pegasus-frontend/game_dirs.txt ~/storage/shared/pegasus-frontend &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo "### Backups created"  &>> ~/storage/shared/pegasus_installer_log.log

echo "### Creating Symlinks "  &>> ~/storage/shared/pegasus_installer_log.log
echo -ne "Installing Scrap, Update & Undo Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/update.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/update.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/update.sh ~/run_update.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/run_update.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/scrap.sh  ~/scrap.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/scrap.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/compress.sh  ~/compress.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/compress.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/undo.sh  ~/undo.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/undo.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/startup.sh  ~/startup.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/startup.sh &>> ~/storage/shared/pegasus_installer_log.log
cp ~/dragoonDoriseTools/pegasus-android-metadata/snes_config.sh  ~/snes_config.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/snes_config.sh &>> ~/storage/shared/pegasus_installer_log.log
echo "### Symlinks created"  &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
clear
echo "### Storage selection "  &>> ~/storage/shared/pegasus_installer_log.log
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
echo "### Storage Selected: ${storageOption}"  &>> ~/storage/shared/pegasus_installer_log.log
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
	 	echo "### no SD Card Detected"  &>> ~/storage/shared/pegasus_installer_log.log
		 echo -e "We couldn't find your SD Card ID name"
		echo -e "Maybe you are using an extenal HD Drive" 
		echo -e "Please type the ID name of the right storage."
		echo -e "You can find the ID name using any file explorer"
		echo -e "like Retroarch built in file explorer"
		echo -e "The ID Name looks something like 23S4-SF23"
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


 echo "### Configuring Pegasus folders "  &>> ~/storage/shared/pegasus_installer_log.log
 
echo -ne "Configuring Rom Storage..."
if [ $useInternalStorage == false ]; then
	sed -i "s/0000-0000\//${sdcardID}\/Android\/data\/com.termux\/files\//g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log 
else
	sed -i "s/0000-0000/emulated\/0\/roms/g" ~/storage/shared/pegasus-frontend/game_dirs.txt &>> ~/storage/shared/pegasus_installer_log.log 
fi
echo "### Pegasus Rom folders configured"  &>> ~/storage/shared/pegasus_installer_log.log


echo "### Creating roms folders "  &>> ~/storage/shared/pegasus_installer_log.log
# Instaling roms folders
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/roms/ ~/storage/$storageLocation &>> ~/storage/shared/pegasus_installer_log.log
echo "### Rom folders created"  &>> ~/storage/shared/pegasus_installer_log.log

#Retroarch 64? We edit the metadatafiles
echo "### RA64 detection "  &>> ~/storage/shared/pegasus_installer_log.log

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
echo "### RetroArch64 sed done"  &>> ~/storage/shared/pegasus_installer_log.log

# PPSSPP Gold? We need to edit the metadata file
hasPPSSPPGold=false
PPSSPPGold=~/storage/shared/Android/data/org.ppsspp.ppssppgold
if [ -d "$PPSSPPGold" ]; then
	hasPPSSPPGold=true
fi
if [[ $hasPPSSPPGold == true ]]; then
	find ~/storage/$storageLocation/ -type f -name "*.txt" -exec sed -i -e 's/org.ppsspp.ppsspp\/.PpssppActivity/org.ppsspp.ppssppgold\/org.ppsspp.ppsspp.PpssppActivity/g' {} \;
fi
echo -e "${GREEN}OK${NONE}"
echo "### PPSSPP Gold sed done"  &>> ~/storage/shared/pegasus_installer_log.log

#Configure Retroarch
echo "### RA Backup "  &>> ~/storage/shared/pegasus_installer_log.log
echo -ne "Creating RetroArch Backup..."
#We create the backup only if we don't have one, to prevent erasing the original backup if the user reinstalls
FOLDER=~/storage/shared/RetroArch/config_bak/
if [ -d "$FOLDER" ]; then
	echo -e "${GREEN}OK${NONE}"
else
	cp -r ~/storage/shared/RetroArch/config/ ~/storage/shared/RetroArch/config_bak/ &>> ~/storage/shared/pegasus_installer_log.log
	if [[ $hasRetroArch64 == false ]]; then
		cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg &>> ~/storage/shared/pegasus_installer_log.log
	fi
	if [[ $hasRetroArch64 == true ]]; then
		cp ~/storage/shared/Android/data/com.retroarch.aarch64/files/retroarch.cfg ~/storage/shared/Android/data/com.retroarch.aarch64/files/retroarch.bak.cfg &>> ~/storage/shared/pegasus_installer_log.log
	fi
	echo -e "${GREEN}OK${NONE}"
fi
echo "### RetroArch backup done"  &>> ~/storage/shared/pegasus_installer_log.log
echo -ne "Configuring Retroarch..."

#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/retroarch_config.sh $handheldModel
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emus_config.sh

clear
echo "### Downloading themes "  &>> ~/storage/shared/pegasus_installer_log.log
# Install Themes for Pegasus
echo -ne "Downloading Pegasus Theme : RP Epic Noir..."
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/dragoonDoriseTools/themes/RP-epic-noir &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Pegasus Theme : RP Switch..."
#We delete the theme, for previous users
rm -rf ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
git clone https://github.com/dragoonDorise/RP-switch.git ~/dragoonDoriseTools/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"
	echo -ne "Downloading Pegasus Theme : Retro Mega..."
git clone https://github.com/plaidman/retromega-next.git ~/dragoonDoriseTools/themes/retromega &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

if [ $handheldModel != 'RP2+' ]; then

	echo -ne "Downloading Pegasus Theme : GameOS..."
	git clone https://github.com/PlayingKarrde/gameOS.git ~/dragoonDoriseTools/themes/gameOS &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"

	echo -ne "Downloading Pegasus Theme : ClearOS..."
	git clone https://github.com/PlayingKarrde/clearOS.git ~/dragoonDoriseTools/themes/clearOS &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
	
	echo -ne "Downloading Pegasus Theme : NeoRetro Dark..."
	git clone https://github.com/TigraTT-Driver/neoretro-dark.git ~/dragoonDoriseTools/themes/neoretro-dark &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
	echo "### Themes installed"  &>> ~/storage/shared/pegasus_installer_log.log
	
fi
	

	echo -e "The default theme on Pegasus is RP Epic Noir"
	echo -e "You can change it anytime on Pegasus."
	echo -e  "Press the ${RED}A button${NONE} to continue to next step"
	read pause

echo "### Rsync the dl themes "  &>> ~/storage/shared/pegasus_installer_log.log
rsync -r ~/dragoonDoriseTools/themes/ ~/storage/shared/pegasus-frontend/themes/ &>> ~/storage/shared/pegasus_installer_log.log

echo "/bin/bash ~/startup.sh" > ~/.bashrc
echo "### Startup created"  &>> ~/storage/shared/pegasus_installer_log.log
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
echo -e "If you have ${RED}Android > 10${NONE} you need to manually apply RetroArch configuration"
echo -e "Go to Retroarch - > Main Menu -> Configuration File -> Load Configuration"
echo -e "and select ${BOLD}custom-retroarch.cfg${NONE} on /storage/emulated/0/RetroArch/config"
echo -e  "Press the ${RED}A button${NONE} to continue to next step"
read pause
echo "### Installation Finished"  &>> ~/storage/shared/pegasus_installer_log.log

#Compressor section (compress before scraping)
while true; do
	compressNow=$(whiptail --title "Do you want to compress your roms now?" \
   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"YES" "Compress my roms!" OFF \
	"NO" "You can always do the scraping later by opening Termux" OFF \
   3>&1 1<&2 2>&3)
	case $compressNow in
		[YES]* ) break;;
		[NO]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac

 done

if [ $compressNow == "YES" ]; then
	clear
	echo -e  "";
	echo -e  "Do you have your roms ready on your SD Card or Internal Storage?"
	echo -e  "${BOLD}Let's start compressing them!${NONE}"
	echo -e  "Press the ${RED}A button${NONE} to continue"
	read pause
	cd ~/
	bash ~/compress.sh
fi
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
	echo -e  "${STRONG}If you want to compress or scrap more roms, update or uninstall Pegasus Installer:${NONE}"
	echo -e  "Just open the Termux app again"
	echo -e  "Press the ${RED}A button${NONE} to exit"
	read pause
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null

fi

