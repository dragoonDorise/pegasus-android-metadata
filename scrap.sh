#!/bin/sh
ans=$(whiptail --title "Rom Scrapper (more systems to come)" \
   --checklist "Please Select your platform with the Space" 10 80 4 \
		"atari2600" "atari2600" OFF \
		"dreamcast" "dreamcast" OFF \
		"gamecube" "gamecube" OFF \
		"gamegear" "gamegear" OFF \
		"gb" "gb" OFF \
		"gba" "gba" OFF \
		"gbc" "gbc" OFF \
		"genesis" "genesis" OFF \
		"mastersystem" "mastersystem" OFF \
		"n64" "n64" OFF \
		"nes" "nes" OFF \
		"pcengine" "pcengine" OFF \
		"psx" "psx" OFF \
		"saturn" "saturn" OFF \
		"sega32x" "sega32x" OFF \
		"segacd" "segacd" OFF \
		"snes" "snes" OFF \
		
   3>&1 1<&2 2>&3)

mapfile -t selected_system_names <<< "$ans"

for system_name in "${selected_system_names[@]}"; do
   echo "System name: ${system_name}"
 done