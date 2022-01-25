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
rm -rf ~/storage &>> /dev/null
termux-setup-storage
echo -e "Pegasus installer 1.2.3"
echo -e  "${BOLD}Hi!${NONE} We're gonna start configuring your ${GREEN}Android Device${NONE}"
echo -e  "Press the ${RED}A button${NONE} to start"

read clear
#Detect installed emulators
hasRetroArch=false
hasRetroArch64=false
#Retroarch?
FOLDER=~/storage/shared/Android/data/com.retroarch
FOLDER64=~/storage/shared/Android/data/com.retroarch.aarch64
if [ -d "$FOLDER" ]; then
	hasRetroArch=true
elif [ -d "$FOLDER64" ]; then
	hasRetroArch=true
	hasRetroArch64=true
	FOLDER=$FOLDER64
fi

clear
echo -ne "Installing components, please be patient..."
rm ~/storage/shared/pegasus_installer_log.log &>> /dev/null
touch ~/storage/shared/pegasus_installer_log.log &>> /dev/null
sleep .5
pkg update -y -F &>> ~/storage/shared/pegasus_installer_log.log && pkg upgrade -y -F &>> ~/storage/shared/pegasus_installer_log.log
pkg install git wget jq rsync unzip whiptail build-essential ninja liblz4 libuv -y  &>> ~/storage/shared/pegasus_installer_log.log

mkdir ~/dragoonDoriseTools &>> ~/storage/shared/pegasus_installer_log.log
cd ~/dragoonDoriseTools &>> ~/storage/shared/pegasus_installer_log.log

echo -e "${GREEN}OK${NONE}"

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
#Download Pegasus
echo -e "Downloading Pegasus, please be patient..."
wget   -q --show-progress https://github.com/mmatyas/pegasus-frontend/releases/download/weekly_2021w40/pegasus-fe_alpha15-85-gfff1a5b2_android.apk ~/dragoonDoriseTools

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

echo -ne "Installing Compress, Scrap, Update & Undo Scripts..."
cp ~/dragoonDoriseTools/pegasus-android-metadata/compress.sh ~/compress.sh &>> ~/storage/shared/pegasus_installer_log.log
chmod a+rwx ~/compress.sh &>> ~/storage/shared/pegasus_installer_log.log
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

#Install CHDMAN
echo -e "Downloading and installing CHDMAN..."
git clone https://github.com/CharlesThobe/chdman.git ~/dragoonDoriseTools/chdman
cd ~/dragoonDoriseTools/chdman
mkdir ~/dragoonDoriseTools/chdman/build && cd ~/dragoonDoriseTools/chdman/build
cmake -G Ninja .. && ninja
cp chdman $PREFIX/bin/chdman && chmod +x $PREFIX/bin/chdman
echo -e "${GREEN}CHDMAN Installed!${NONE}"
#Install Maxcso
echo -e "Downloading and installing Maxcso..."
git clone https://github.com/unknownbrackets/maxcso.git ~/dragoonDoriseTools/maxcso
cd ~/dragoonDoriseTools/maxcso
make
cp maxcso $PREFIX/bin/maxcso && chmod +x $PREFIX/bin/maxcso
echo -e "${GREEN}Maxcso Installed!${NONE}"

#Retroarch64 support
if [[ $hasRetroArch64 == true ]]; then
	find ~/storage/$storageLocation -type f -name "*.txt" -exec sed -i -e 's/com.retroarch/com.retroarch.aarch64/g' {} \;
fi
echo -e "${GREEN}OK${NONE}"


if [ $hasRetroArch == false ]; then
	echo -ne "You don't have RetroArch, downloading it..."
	echo ""
	wget  -q --show-progress https://buildbot.libretro.com/stable/1.9.14/android/RetroArch.apk ~/dragoonDoriseTools/
	echo ""
	echo -e "We need to install RetroArch before we can continue..."
	echo -e  "Press the ${RED}A button${NONE} to install RetroArch, when RetroArch is installed click ${BOLD}OPEN${NONE} in the installation window so RetroArch is opened."
	echo -e  "Wait for Retroarch files to be downloaded, then quit Retroarch and come back here."
	read pause
	xdg-open ~/dragoonDoriseTools/RetroArch.apk
	clear
	echo -e  "Welcome back!"	
	echo -e  "Press the ${RED}A button${NONE} to continue"
	read pause
	
fi


#Configure Retroarch
echo -ne "Creating RetroArch Backup..."
#We create the backup only if we don't have one, to prevent erasing the original backup if the user reinstalls
FOLDER=~/storage/shared/RetroArch/config_bak/
if [ -d "$FOLDER" ]; then
	echo -e "${GREEN}OK${NONE}"
elif [ -d "$FOLDER64" ]; then
	cp -r ~/storage/shared/RetroArch/config/ ~/storage/shared/RetroArch/config_bak/ &>> ~/storage/shared/pegasus_installer_log.log
	cp ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg ~/storage/shared/Android/data/com.retroarch/files/retroarch.bak.cfg &>> ~/storage/shared/pegasus_installer_log.log
	echo -e "${GREEN}OK${NONE}"
fi


while true; do
	handheldModel=$(whiptail --title "What Android Device do you have" \
   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"ANDROID" "A regular Android Device" ON \
	"RG552" "An Anbernic RG552 " OFF \
   3>&1 1<&2 2>&3)
	case $handheldModel in
		[ANDROID]* ) break;;
		[RG552]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
   
 done


echo -ne "Configuring Retroarch..."

# 5:3 Detection flag
if [ $handheldModel == "RG552" ]
then
	touch ~/dragoonDoriseTools/.isRG552
fi




#RetroArch Configs
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/retroarch_config.sh $handheldModel
# Install Themes for Pegasus
echo -ne "Downloading Pegasus Theme : RP Epic Noir..."
git clone https://github.com/dragoonDorise/RP-epic-noir.git ~/storage/shared/pegasus-frontend/themes/RP-epic-noir &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo -ne "Downloading Pegasus Theme : RP Switch..."
#We delete the theme, for previous users
rm -rf ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
git clone https://github.com/dragoonDorise/RP-switch.git ~/storage/shared/pegasus-frontend/themes/RP-switch &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"

echo "/bin/bash ~/startup.sh" > ~/.bashrc
sleep .5
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
echo -e  "Now let's install ${RED}Pegasus${NONE}"
echo -e  "Press the ${RED}A button${NONE} to install Pegasus, when Pegasus is installed click ${BOLD}DONE${NONE} in the installation window so you can come back to scrape your roms' artwork!"
read pause

echo -ne  "Installing ${RED}Pegasus${NONE}..."
#Launch Pegasus
xdg-open ~/dragoonDoriseTools/pegasus-fe_alpha15-85-gfff1a5b2_android.apk
echo -e  "${GREEN}OK${NONE}"

/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/emu_check.sh

echo -e  "";
echo -e  "${GREEN}All Done${NONE}, do you have your roms ready?"
echo -e "You'll be asked if you want to be able to compress your roms in the next prompt"
echo -e  "Press the ${RED}A button${NONE} to continue"
#Launch rom compressor script
bash compress.sh
echo -e  "${BOLD}Let's start getting all your artwork!${NONE}"
echo -e  "Press the ${RED}A button${NONE} to continue"
read pause
cd ~/
bash scrap.sh
clear
echo -e  "${GREEN}Done!${NONE}"

echo -e  "${STRONG}If you want to scrape more roms, update or uninstall Pegasus Installer:${NONE}"
echo -e  "In Pegasus go to the Android Collection and look for Rom Scraper"


echo -e "${RED}INSTALL EMULATORS${NONE} Remember to go to Retroarch's Main Menu -> Load Core -> Install or Restore a Core"
echo -e "And then select the core you want to install"
echo -e ""
echo -e "${RED}IMPORTANT${NONE}"
echo -e "Be aware that if you delete the Termux app Android will ${RED}DELETE${NONE} the Termux folder on your SD Card"
echo -e "The roms on ${GREEN}/Android/data/com.termux/files/${NONE} will be deleted"
echo -e "No other files on the SD Card will be affected"
echo -e "${RED}IMPORTANT${NONE}"
echo -e  "Press the ${RED}A button${NONE} to finish"
read pause
am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null