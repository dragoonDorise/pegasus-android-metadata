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
hasRedDream=false
hasYaba=false
hasMupen=false
hasPPSSPP=false
hasDuckstation=false
hasDrastic=false
hasDolphin=false
hasRetroArch=false
hasRetroArch64=false
hasCitra=false
hasAether=false

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

if [ $hasRetroArch == false ]; then
	echo -ne "You don't have RetroArch, downloading it..."
	echo ""
	wget  -q --show-progress https://buildbot.libretro.com/stable/1.9.14/android/RetroArch.apk -P ~/dragoonDoriseTools/
	echo ""
	echo -e "We need to install RetroArch before we can continue..."
	echo -e  "When RetroArch is installed click ${BOLD}OPEN${NONE} in the installation window so RetroArch is opened."
	echo -e  "Wait for Retroarch files to be downloaded, then quit Retroarch and come back here."
	echo -e  "Press the ${RED}A button${NONE} to install RetroArch now"
	read pause
	xdg-open ~/dragoonDoriseTools/RetroArch.apk
	clear
fi
#Aether?
FOLDER=~/storage/shared/Android/data/xyz.aethersx2.android
if [ -d "$FOLDER" ]; then
	hasAether=true
fi
#Citra?
FOLDER=~/storage/shared/citra-emu
if [ -d "$FOLDER" ]; then
	hasCitra=true
fi

#RedDream?
FOLDER=~/storage/shared/Android/data/io.recompiled.redream
if [ -d "$FOLDER" ]; then
	hasRedDream=true
fi
#YabaSanshioro?
FOLDER=~/storage/shared/Android/data/org.devmiyax.yabasanshioro2.pro
FOLDERPRO=~/storage/shared/Android/data/org.devmiyax.yabasanshioro2
if [ -d "$FOLDER" ]; then
	hasYaba=true
fi
if [ -d "$FOLDERPRO" ]; then
	hasYaba=true
fi
#Mupen64
FOLDER=~/storage/shared/Android/data/org.mupen64plusae.v3.fzurita
if [ -d "$FOLDER" ]; then
	hasMupen=true
fi
#PPSSPP
FOLDER=~/storage/shared/Android/data/org.ppsspp.ppsspp
if [ -d "$FOLDER" ]; then
	hasPPSSPP=true
fi
#duckstation
FOLDER=~/storage/shared/duckstation
if [ -d "$FOLDER" ]; then
	hasDuckstation=true
fi
#Drastic
FOLDER=~/storage/shared/DraStic
if [ -d "$FOLDER" ]; then
	hasDrastic=true
fi
#Dolphin
FOLDER=~/storage/shared/dolphin-mmj
if [ -d "$FOLDER" ]; then
	hasDolphin=true
fi
clear
echo -e ""
echo -e "Checking installed emulators..."
echo -e ""
echo -ne "PS2 - AetherSX2..."
if [ $hasCitra == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi

echo -ne "3DS - Citra..."
if [ $hasCitra == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "Dreamcast - RedDream..."
if [ $hasRedDream == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "Saturn - Yaba Sanshioro 2..."
if [ $hasYaba == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "Nintendo 64 - Mupen 64 Plus..."
if [ $hasMupen == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "PSP - PPSSPP..."
if [ $hasPPSSPP == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "Playstation - Duckstation..."
if [ $hasDuckstation == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "Nintendo DS - Drastic..."
if [ $hasDrastic == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo -ne "Nintendo Wii & GameCube - Dolphin MMJR..."
if [ $hasDolphin == true ]; then
	echo -e  "${GREEN}Installed${NONE}"
else
	echo -e  "${RED}Not installed${NONE}"
fi
echo ""

echo -e  "Press the ${RED}A button${NONE} to install the missing emulators"
read pause
clear
	emulators_names=$(whiptail --title "Install missing emulators" \
   --checklist "Move using your DPAD and select your options with the Y button. Press the A button to select." 10 80 4 \
	"DREAMCAST" "Dreamcast" OFF \
	"GC" "GameCube & Wii" OFF \
	"SATURN" "Sega Saturn" OFF \
	"N64" "Nintendo 64" OFF \
	"PSP" "Sony PSP" OFF \
	"PSX" "Sony Playstation" OFF \
	"PS2" "Playstation 2" OFF \
	"DS" "Nintendo DS - Paid Emulator" OFF \
	"3DS" "Nintendo 3DS" OFF \
   3>&1 1<&2 2>&3)




mapfile -t emulators <<< $emulators_names

for emulator in ${emulators[@]};
 do
 
	if [ $emulator == "DREAMCAST" ]; then
		echo -e "Dreamcast - Redream..."	
		termux-open "https://play.google.com/store/apps/details?id=io.recompiled.redream"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "GC" ]; then
		echo -e "Nintendo Wii & GameCube - Dolphin MMJR..."
		wget  -q --show-progress https://github.com/Bankaimaster999/Dolphin-MMJR2/releases/download/2.0-15108/MMJR.v2.0-15108.apk -P ~/dragoonDoriseTools/
		echo -e  "Press the ${RED}A button${NONE} to install Dolphin"
		read pause		
		xdg-open ~/dragoonDoriseTools/MMJR.v2.0-15108.apk
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "SATURN" ]; then
		echo -e "Saturn - Yaba Sanshioro 2..."
		termux-open "https://play.google.com/store/apps/details?id=org.devmiyax.yabasanshioro2"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "N64" ]; then
		echo -e "Nintendo 64 - Mupen 64 Plus..."
		termux-open "https://play.google.com/store/apps/details?id=org.mupen64plusae.v3.fzurita"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "PSP" ]; then
		echo -e "PSP - PPSSPP..."
		termux-open "https://play.google.com/store/apps/details?id=org.ppsspp.ppsspp"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "PSX" ]; then
		echo -e "Playstation - Duckstation..."	
		termux-open "https://play.google.com/store/apps/details?id=com.github.stenzek.duckstation"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "PS2" ]; then
		echo -e "Playstation2 - AetherSX2..."	
		termux-open "https://play.google.com/store/apps/details?id=xyz.aethersx2.android"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "DS" ]; then
		echo -e "Nintendo DS - Drastic..."
		termux-open "https://play.google.com/store/apps/details?id=com.dsemu.drastic"
		echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
		read pause
	fi
	if [ $emulator == "3DS" ]; then
		echo -e "Nintendo 3DS - Citra MMJ..."		
		wget  -q --show-progress https://github.com/weihuoya/citra/releases/download/20220120/Citra_MMJ_20220120.apk -P ~/dragoonDoriseTools/
		echo -e  "Press the ${RED}A button${NONE} to install Citra MMJ"
		read pause				
		xdg-open ~/dragoonDoriseTools/Citra_MMJ_20220120.apk
	fi
		
 
 done
