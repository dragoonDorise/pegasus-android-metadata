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
hasCitra=false
hasAether=false

#Handheld model
handheldModel=$(cat ~/dragoonDoriseTools/.device)

#Retroarch?
FOLDER=~/storage/shared/RetroArch
if [ -d "$FOLDER" ]; then
	hasRetroArch=true
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
FOLDERPRO=~/storage/shared/Android/data/org.mupen64plusae.v3.fzurita.pro
if [ -d "$FOLDER" ] || [ -d "FOLDERPRO" ]; then
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
FOLDER=~/storage/shared/dolphin-mmjr
if [ -d "$FOLDER" ]; then
	hasDolphin=true
fi
clear
echo -e ""
echo -e "Checking installed emulators..."
echo -e ""

#Common emulators

echo -ne "Retroarch..."
if [ $hasRetroArch == false ]; then
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


#Only ODIN & ANDROID
if [ $handheldModel == "ODIN" ] || [ $handheldModel == "ANDROID" ] || ; then

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
	echo -ne "Nintendo Wii & GameCube - Dolphin MMJR..."
	if [ $hasDolphin == true ]; then
		echo -e  "${GREEN}Installed${NONE}"
	else
		echo -e  "${RED}Not installed${NONE}"
	fi
	echo ""		

fi

#Only on RG552 or Android
if [ $handheldModel == "RG552" ] || [ $handheldModel == "ANDROID" ] ; then
	echo -ne "Nintendo 64 - Mupen 64 Plus..."
	if [ $hasMupen == true ]; then
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
fi
echo -e ""
echo -e "We're going to download all missing emulators."
echo -e "${BOLD}Remember to open every emulator right after installing it and to grant them folder permissions.${NONE}"
echo -e "Come back in here after every installation to continue the installation."
echo -e  "Press the ${RED}A button${NONE} to install the missing emulators."
read pause
clear

#We prevent to download some emulators

if [ $handheldModel == "RG552" ] || [ $handheldModel == "ANDROID" ] || ; then
	hasCitra=true
	hasAether=true
fi

if [ $hasRetroArch == false ]; then
	echo -e "Multisystem - RetroArch..."
	echo ""
	wget  -q --show-progress https://buildbot.libretro.com/stable/1.9.14/android/RetroArch.apk -P ~/dragoonDoriseTools/
	echo ""
	echo -e "We need to install RetroArch before we can continue..."
	echo -e  "When RetroArch is installed click ${BOLD}OPEN${NONE} in the installation window so RetroArch is opened."
	echo -e  "Wait for Retroarch files to be downloaded, then quit Retroarch and come back here."
	echo -e  "Press the ${RED}A button${NONE} to install RetroArch now"
	read pause
	xdg-open ~/dragoonDoriseTools/RetroArch.apk
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi

if [ $hasRedDream == false ]; then
	echo -e "Dreamcast - Redream..."	
	termux-open "https://play.google.com/store/apps/details?id=io.recompiled.redream"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	
fi
if [ $hasDolphin == false ]; then
	echo -e "Nintendo Wii & GameCube - Dolphin MMJR..."
	wget  -q --show-progress https://github.com/Bankaimaster999/Dolphin-MMJR/releases/download/1.0-11460/Dolphin.MMJR.v11460.apk -P ~/dragoonDoriseTools/
	echo -e  "Press the ${RED}A button${NONE} to install Dolphin"
	read pause		
	xdg-open ~/dragoonDoriseTools/Dolphin.MMJR.v11460.apk
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasYaba == false ]; then
	echo -e "Saturn - Yaba Sanshioro 2..."
	termux-open "https://play.google.com/store/apps/details?id=org.devmiyax.yabasanshioro2"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasMupen == false ]; then
	echo -e "Nintendo 64 - Mupen 64 Plus..."
	termux-open "https://play.google.com/store/apps/details?id=org.mupen64plusae.v3.fzurita"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasPPSSPP == false ]; then
	echo -e "PSP - PPSSPP..."
	termux-open "https://play.google.com/store/apps/details?id=org.ppsspp.ppsspp"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasDuckstation == false ]; then
	echo -e "Playstation - Duckstation..."	
	termux-open "https://play.google.com/store/apps/details?id=com.github.stenzek.duckstation"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasAether == false ]; then
	echo -e "Playstation2 - AetherSX2..."	
	termux-open "https://play.google.com/store/apps/details?id=xyz.aethersx2.android"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasDrastic == false ]; then
	echo -e "Nintendo DS - Drastic..."
	termux-open "https://play.google.com/store/apps/details?id=com.dsemu.drastic"
	echo -e  "Press the ${RED}A button${NONE} to install the next emulator"
	read pause
fi
if [ $hasCitra == false ]; then
	echo -e "Nintendo 3DS - Citra MMJ..."		
	wget  -q --show-progress https://github.com/weihuoya/citra/releases/download/20220120/Citra_MMJ_20220120.apk -P ~/dragoonDoriseTools/
	echo -e  "Press the ${RED}A button${NONE} to install Citra MMJ"
	read pause				
	xdg-open ~/dragoonDoriseTools/Citra_MMJ_20220120.apk
fi
		
