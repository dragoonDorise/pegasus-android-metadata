#!/bin/sh

git clone https://github.com/dragoonDorise/pegasus-artwork.git ./pegasus-artwork

selected_device_descriptions=$(whiptail --title "Pegasus Rom Scrapper" \
   --checklist "Please Select your platform with the Space" 10 80 4 \
		atari2600 "" ON \
		"dreamcast" "dreamcast" OFF \
		"gamegear" "gamegear" OFF \
		"gb" "gb" OFF \
		"gba" "gba" OFF \
		"gbc" "gbc" OFF \
		"gamecube" "gc" OFF \
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

mapfile -t selected_device_names <<< $selected_device_descriptions

for device_name in ${selected_device_names[@]};
 do
	 message=$device_name
	 system="${message//'"'/}"            
   rsync -r ~/pegasus-artwork/$system/ ~/storage/external-1/$system/
 done
 
 rm -rf pegasus-artwork