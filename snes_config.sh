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

snesMode="4:3"
snesConfigured="false"
FILE=~/dragoonDoriseTools/.snes87
if [ -f "$FILE" ]; then
	snesMode="8:7"
	snesConfigured="true"
fi
FILE=~/dragoonDoriseTools/.snes43
if [ -f "$FILE" ]; then
	snesMode="4:3"
	snesConfigured="true"
fi

echo -e "Please choose your Super Nintedo resolution"
echo -e "Type 1 for 4:3 Aspect Ratio (Classic TV Resolution)"
echo -e "Type 2 for 8:7 Aspect Ratio (Real internal Resolution)"
if [ $snesConfigured == false ]; then
	echo -e "${BOLD}And then press the A button to continue${NONE}"
fi
if [ $snesConfigured == true ]; then
	echo -e "${BOLD}Or just press the A button to keep the $snesMode you selected on installation${NONE}"
fi

read ar

if [ $ar == "1" ]
then
	touch ~/dragoonDoriseTools/.snes43
	snesMode="4:3"
	
fi

if [ $ar == "2" ]
then
	touch ~/dragoonDoriseTools/.snes87
	snesMode="8:7"
fi

if [ $snesMode == "8:7" ]
then	
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/rg552/RetroArch/config/Snes9x/snes87.cfg ~/storage/shared/RetroArch/config/Snes9x/snes.cfg &> /dev/null	
fi

if [ $snesMode == "4:3" ]
then	
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/rg552/RetroArch/config/Snes9x/snes.cfg ~/storage/shared/RetroArch/config/Snes9x/snes.cfg &> /dev/null	
fi



echo ""
echo -ne  "Snes configuration..."
echo -e  "${GREEN}OK${NONE}"
