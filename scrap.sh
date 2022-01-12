#!/bin/sh
#

selected_device_descriptions=$(whiptail --title "Pegasus Rom Scrapper" \
   --checklist "Move using yout DPAD and select your platforms with the Space" 10 80 4 \
		"gb" "" ON \
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
		
  		gb)
			remoteSystem="Nintendo - Game Boy"
			;;
		
  		Romania | Moldova)
			echo -n "Romanian"
			;;
		
  		Italy | "San Marino" | Switzerland | "Vatican City")
			echo -n "Italian"
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