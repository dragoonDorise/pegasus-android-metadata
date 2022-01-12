#!/bin/sh
#

selected_device_descriptions=$(whiptail --title "Pegasus Rom Scrapper" \
   --checklist "Move using yout DPAD and select your platforms with the Space" 10 80 4 \
	"atari2600" "Atari - 2600" ON \
	"atarilynx" "Atari - Lynx" ON \
	"doom" "DOOM" ON \
	"dos" "DOS" ON \
	"fbneo" "FBNeo - Arcade Games" ON \
	"pcengine" "NEC - PC Engine - TurboGrafx 16" ON \
	"pcenginecd" "NEC - PC Engine CD - TurboGrafx-CD" ON \
	"gb" "Nintendo - Game Boy" ON \
	"gba" "Nintendo - Game Boy Advance" ON \
	"gbc" "Nintendo - Game Boy Color" ON \
	"gc" "Nintendo - GameCube" ON \
	"3ds" "Nintendo - Nintendo 3DS" ON \
	"n64" "Nintendo - Nintendo 64" ON \
	"nds" "Nintendo - Nintendo DS" ON \
	"nes" "Nintendo - Nintendo Entertainment System" ON \
	"pokemini" "Nintendo - Pokemon Mini" ON \
	"snes" "Nintendo - Super Nintendo Entertainment System" ON \
	"wii" "Nintendo - Wii" ON \
	"neogeo" "SNK - Neo Geo" ON \
	"neogeocd" "SNK - Neo Geo CD" ON \
	"ngp" "SNK - Neo Geo Pocket" ON \
	"ngpc" "SNK - Neo Geo Pocket Color" ON \
	"scummvm" "ScummVM" ON \
	"sega32x" "Sega - 32X" ON \
	"dreamcast" "Sega - Dreamcast" ON \
	"gamegear" "Sega - Game Gear" ON \
	"mastersystem" "Sega - Master System" ON \
	"genesis" "Sega - Mega Drive - Genesis" ON \
	"segacd" "Sega - Mega-CD - Sega CD" ON \
	"saturn" "Sega - Saturn" ON \
	"psx" "Sony - PlayStation" ON \
	"ps2" "Sony - PlayStation 2" ON \
	"psp" "Sony - PlayStation Portable" ON \
	"3do" "The 3DO Company - 3DO" ON \
   3>&1 1<&2 2>&3)

mapfile -t selected_device_names <<< $selected_device_descriptions

for device_name in ${selected_device_names[@]};
 do
	 message=$device_name
	  system="${message//'"'/}"            
	 #ls ~/storage/external-1/$system
	 mkdir ~/storage/external-1/$system/media
	 mkdir ~/storage/external-1/$system/media/screenshot
	 mkdir ~/storage/external-1/$system/media/box2dfront
	 mkdir ~/storage/external-1/$system/media/wheel
	 for entry in ~/storage/external-1/$system/*
	 do
	 
	 #	echo $entry;
		 firstString=$entry
		 secondString=".png"
		 capture="${firstString/.7z/"$secondString"}"   
		 
		 firstString=$capture
		 secondString=""
		 capture="${firstString/"/data/data/com.termux/files/home/storage/external-1/$system/"/"$secondString"}"   
		 
		case $system in
					
			atari2600)
				remoteSystem="Atari - 2600"
				;;
			atarilynx)
				remoteSystem="Atari - Lynx"
				;;
			doom)
				remoteSystem="DOOM"
				;;
			dos)
				remoteSystem="DOS"
				;;
			fbneo)
				remoteSystem="FBNeo - Arcade Games"
				;;
			pcengine)
				remoteSystem="NEC - PC Engine - TurboGrafx 16"
				;;
			pcenginecd)
				remoteSystem="NEC - PC Engine CD - TurboGrafx-CD"
				;;
			gb)
				remoteSystem="Nintendo - Game Boy"
				;;
			gba)
				remoteSystem="Nintendo - Game Boy Advance"
				;;
			gbc)
				remoteSystem="Nintendo - Game Boy Color"
				;;
			gc)
				remoteSystem="Nintendo - GameCube"
				;;
			3ds)
				remoteSystem="Nintendo - Nintendo 3DS"
				;;
			n64)
				remoteSystem="Nintendo - Nintendo 64"
				;;
			nds)
				remoteSystem="Nintendo - Nintendo DS"
				;;
			nes)
				remoteSystem="Nintendo - Nintendo Entertainment System"
				;;
			pokemini)
				remoteSystem="Nintendo - Pokemon Mini"
				;;
			snes)
				remoteSystem="Nintendo - Super Nintendo Entertainment System"
				;;
			wii)
				remoteSystem="Nintendo - Wii"
				;;
			neogeo)
				remoteSystem="SNK - Neo Geo"
				;;
			neogeocd)
				remoteSystem="SNK - Neo Geo CD"
				;;
			ngp)
				remoteSystem="SNK - Neo Geo Pocket"
				;;
			ngpc)
				remoteSystem="SNK - Neo Geo Pocket Color"
				;;
			scummvm)
				remoteSystem="ScummVM"
				;;
			sega32x)
				remoteSystem="Sega - 32X"
				;;
			dreamcast)
				remoteSystem="Sega - Dreamcast"
				;;
			gamegear)
				remoteSystem="Sega - Game Gear"
				;;
			mastersystem)
				remoteSystem="Sega - Master System"
				;;
			genesis)
				remoteSystem="Sega - Mega Drive - Genesis"
				;;
			segacd)
				remoteSystem="Sega - Mega-CD - Sega CD"
				;;
			saturn)
				remoteSystem="Sega - Saturn"
				;;
			psx)
				remoteSystem="Sony - PlayStation"
				;;
			ps2)
				remoteSystem="Sony - PlayStation 2"
				;;
			psp)
				remoteSystem="Sony - PlayStation Portable"
				;;
			3d0)
				remoteSystem="The 3DO Company - 3DO"
				;;
		
		  *)
			echo -n "unknown"
			;;
		esac		 
				
		FILE=~/storage/external-1/$system/media/screenshot/$capture
		if [ -f "$FILE" ]; then
			echo "$FILE exists, ignoring"
		else 
			wget  "http://thumbnails.libretro.com/$remoteSystem/Named_Snaps/$capture" -P ~/storage/external-1/$system/media/screenshot/
		fi
		
		FILE=~/storage/external-1/$system/media/box2dfront/$capture
		if [ -f "$FILE" ]; then
			echo "$FILE exists, ignoring"
		else 
			wget  "http://thumbnails.libretro.com/$remoteSystem/Named_Boxarts/$capture" -P ~/storage/external-1/$system/media/box2dfront/
		fi
		
		FILE=~/storage/external-1/$system/media/wheel/$capture
		if [ -f "$FILE" ]; then
			echo "$FILE exists, ignoring"
		else 
			wget  "http://thumbnails.libretro.com/$remoteSystem/Named_Titles/$capture" -P ~/storage/external-1/$system/media/wheel/
		fi
				
		
		
		#for rom in $entry
		#do
		#	firstString=$rom
		 #	secondString=".png"
		 #	echo capture="${firstString/.7z/"$secondString"}"             
		#
		#done
	 #	
	 
	  # wget http://thumbnails.libretro.com/$system/Named_Snaps/$capture
	 done
	 
   #rsync -r ~/pegasus-artwork/$system/ ~/storage/external-1/$system/
 done
 
 #rm -rf pegasus-artwork