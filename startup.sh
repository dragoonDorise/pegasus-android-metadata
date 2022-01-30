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
	"4" "Uninstall Pegasus Installer" OFF \
	"5" "Reset Screen Scraper credentials" OFF \
	"6" "Open Termux CLI" OFF \
	3>&1 1>&2 2>&3)
	case $selected_option in
		[1]* ) break;;
		[2]* ) break;;
		[3]* ) break;;
		[4]* ) break;;
		[5]* ) break;;
		[6]* ) break;;
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
	/bin/bash ~/undo.sh
fi
if [[ $selected_option == "5" ]]
then
	rm ~/dragoonDoriseTools/.screenScraperUser
	rm ~/dragoonDoriseTools/.screenScraperPass
	
	echo -e "You need to have an account on ${BOLD}https://www.screenscraper.fr${NONE} for scraping your roms"	
	echo -e "Press the ${RED}A Button${NONE} if you already have an account"
	echo -e "Type y and press the ${RED}A Button${NONE} and I'll open ScreenScraper on your browser, remember to come back when you are registered"
	read account
	if [[ $account == "y" ]]; then
		termux-open "https://www.screenscraper.fr/membreinscription.php"
	fi
	
	if [[ $account == "Y" ]]; then
		termux-open "https://www.screenscraper.fr"
	fi
	
	echo -e "Now I'm going to ask for your user and password. Both will be stored on your device, ${BOLD}I won't send them or read them${NONE}"
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
	clear
fi

if [[ $selected_option == "" ]]
then
	am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null
fi

