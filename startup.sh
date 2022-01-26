#!/bin/sh
#

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
while true; do
	selected_option=$(whiptail --title "Pegasus Installer Menu" --radiolist "Move using your DPAD and select your options with the Y button. Press the A button to select." 20 40 15 \
	"1" "Update & Configure Pegasus Installer" ON \
	"2" "Scrap your Roms" OFF \
	"3" "Change SNES Aspect Ratio" OFF \
	"4" "Turn Bezels ON/OFF" OFF \
	"5" "Reset Screen Scraper credentials" OFF \
	"6" "Uninstall Pegasus Installer" OFF \
	"7" "Open Termux CLI" OFF \
	"8" "Reinstall Termux dependencies" OFF \
	"9" "Exit" OFF \
	3>&1 1>&2 2>&3)
	case $selected_option in
		[1]* ) break;;
		[2]* ) break;;
		[3]* ) break;;
		[4]* ) break;;
		[5]* ) break;;
		[6]* ) break;;
		[7]* ) break;;
		[8]* ) break;;
		[9]* ) break;;
		* ) echo "Please hide your keyboard";;
	esac
 done


if [[ $selected_option == "1" ]]
then
	/bin/bash ~/update.sh
fi

if [[ $selected_option == "2" ]]
then
	/bin/bash ~/scrap.sh
fi

if [[ $selected_option == "3" ]]
then
	/bin/bash ~/snes_config.sh
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
fi

if [[ $selected_option == "4" ]]
then
	/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/ra_bezels.sh
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
fi
if [[ $selected_option == "5" ]]
then
	rm ~/dragoonDoriseTools/.screenScraperUser
	rm ~/dragoonDoriseTools/.screenScraperPass

	if (whiptail --title "Screen Scraper" --yesno "Do you have an account on www.screenscraper.fr? If you don't we will open your browser so you can create one. Come back later" 8 78); then
		find ~/storage/shared/RetroArch/config/ -type f -name "*.cfg" -exec sed -i -e 's/input_overlay_enable = "false"/input_overlay_enable = "true"/g' {} \;
	else
		termux-open "https://www.screenscraper.fr/membreinscription.php"
		clear
		echo -e "Press the ${RED}A Button${NONE} if you already have your account created"
		read pause
	fi

	echo -e "Now I'm going to ask for your user and password. Both will be stored on your device, ${BOLD}I won't send them anywhere or read them${NONE}"
	echo -e "What is your ScreenScraper user? Type it and press the ${RED}A button${NONE}"
	read user
	echo $user > ~/dragoonDoriseTools/.screenScraperUser
	echo -e "What is your ScreenScraper password? Type it and press the ${RED}A button${NONE}"
	read pass
	echo $pass > ~/dragoonDoriseTools/.screenScraperPass

	echo -e "${GREEN}Thanks!${NONE} Press the ${RED}A Button${NONE} to start scraping your roms"
	read pause
	/bin/bash ~/scrap.sh
fi
if [[ $selected_option == "6" ]]
then
	/bin/bash ~/undo.sh
fi

if [[ $selected_option == "7" ]]
then
	clear
fi

if [[ $selected_option == "" ]]
then
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
fi
if [[ $selected_option == "8" ]]
then
	/bin/bash ~/dragoonDoriseTools/termux_pkg_install.sh
fi


if [[ $selected_option == "9" ]]
then
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
fi
