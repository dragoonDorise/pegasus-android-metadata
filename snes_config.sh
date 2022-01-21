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
echo -e ""
echo -e "${BOLD}Please choose your Super Nintendo resolution${NONE}"
echo -e "Type 1 for 4:3 Aspect Ratio (Classic TV Resolution)"
echo -e "Type 2 for 8:7 Aspect Ratio (Real internal Resolution)"
if [ $snesConfigured == false ]; then
	echo -e "And then press the ${RED}A button${NONE} to continue"
fi
if [ $snesConfigured == true ]; then
	echo -e "Or just press the ${RED}A button${NONE} to keep the $snesMode you selected on installation"
fi
read ar
echo -ne "SNES configuration seleted..."
if [[ $ar == "1" ]]
then
	rm ~/dragoonDoriseTools/.snes43 &>> ~/storage/shared/pegasus_installer_log.log
	rm ~/dragoonDoriseTools/.snes87 &>> ~/storage/shared/pegasus_installer_log.log
	touch ~/dragoonDoriseTools/.snes43 &>> ~/storage/shared/pegasus_installer_log.log
	snesMode="4:3"
	
fi

if [[ $ar == "2" ]]
then
	rm ~/dragoonDoriseTools/.snes43 &>> ~/storage/shared/pegasus_installer_log.log
	rm ~/dragoonDoriseTools/.snes87 &>> ~/storage/shared/pegasus_installer_log.log
	touch ~/dragoonDoriseTools/.snes87 &>> ~/storage/shared/pegasus_installer_log.log
	snesMode="8:7"
fi
echo -e "${GREEN}$snesMode${NONE}"
if [ $snesMode == "8:7" ]
then	
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/Snes9x/snes87.cfg ~/storage/shared/RetroArch/config/Snes9x/snes.cfg &> ~/storage/shared/pegasus_installer_log.log	
fi

if [ $snesMode == "4:3" ]
then	
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/Snes9x/snes.cfg ~/storage/shared/RetroArch/config/Snes9x/snes.cfg &> ~/storage/shared/pegasus_installer_log.log	
fi



echo ""
echo -ne  "Snes configuration..."
echo -e  "${GREEN}OK${NONE}"
