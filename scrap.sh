#!/bin/sh
#
useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"
	
fi

get_sc_id(){
	#SS ID systems
	case $1 in
		
		genesis)
		ssID="1";;
		genesiswide)
		ssID="1";;
		mastersystem)
		ssID="2";;
		nes)
		ssID="3";;
		snes)
		ssID="4";;
		gb)
		ssID="9";;
		gbc)
		ssID="10";;
		virtualboy)
		ssID="11";;
		gba)
		ssID="12";;
		gamecube)
		ssID="13";;
		n64)
		ssID="14";;
		nds)
		ssID="15";;
		wii)
		ssID="16";;
		sega32x)
		ssID="19";;
		segacd)
		ssID="20";;
		gamegear)
		ssID="21";;
		saturn)
		ssID="22";;
		dreamcast)
		ssID="23";;
		ngp)
		ssID="25";;
		atari2600)
		ssID="26";;
		jaguar)
		ssID="27";;
		lynx)
		ssID="28";;
		3do)
		ssID="29";;
		pcengine)
		ssID="31";;
		bbcmicro)
		ssID="37";;
		atari5200)
		ssID="40";;
		atari7800)
		ssID="41";;
		atarist)
		ssID="42";;
		atari800)
		ssID="43";;			
		wswan)
		ssID="45";;
		wswanc)
		ssID="46";;
		colecovision)
		ssID="48";;
		pcengine)
		ssID="50";;
		gw)
		ssID="52";;
		psx)
		ssID="57";;
		ps2)
		ssID="58";;			
		psp)
		ssID="61";;
		amiga600)
		ssID="64";;
		amstradcpc)
		ssID="65";;
		c64)
		ssID="66";;
		scv)
		ssID="67";;			
		neogeocd)
		ssID="70";;
		pcfx)
		ssID="72";;
		vic20)
		ssID="73";;			
		zxspectrum)
		ssID="76";;
		zx81)
		ssID="77";;
		x68000)
		ssID="79";;
		channelf)
		ssID="80";;			
		ngpc)
		ssID="82";;
		apple2)
		ssID="86";;
		gx4000)
		ssID="87";;
		dragon)
		ssID="91";;
		bk)
		ssID="93";;
		vectrex)
		ssID="102";;
		supergrafx)
		ssID="105";;
		fds)
		ssID="106";;
		satellaview)
		ssID="107";;
		sufami)
		ssID="108";;
		sg1000)
		ssID="109";;
		amiga1200)
		ssID="111";;
		msx,msx1)
		ssID="113";;
		pcenginecd)
		ssID="114";;
		intellivision)
		ssID="115";;
		msx,msx2)
		ssID="116";;
		msx,msx2)
		ssID="117";;
		msxturbor)
		ssID="118";;
		64dd)
		ssID="122";;
		scummvm)
		ssID="123";;
		gb)
		ssID="127";;
		gb)
		ssID="128";;
		amigacdtv)
		ssID="129";;
		amigacd32)
		ssID="130";;
		oricatmos)
		ssID="131";;
		amiga)
		ssID="134";;
		dos)
		ssID="135";;
		prboom)
		ssID="135";;
		amigacd32)
		ssID="139";;
		thomson)
		ssID="141";;
		neogeo)
		ssID="142";;
		psp)
		ssID="172";;						
		snes)
		ssID="202";;
		sneswide)
		ssID="202";;
		megadrive)
		ssID="203";;
		ti994a)
		ssID="205";;
		lutro)
		ssID="206";;
		supervision)
		ssID="207";;
		pc98)
		ssID="208";;
		pokemini)
		ssID="211";;
		samcoupe)
		ssID="213";;
		openbor)
		ssID="214";;
		uzebox)
		ssID="216";;
		apple2gs)
		ssID="217";;
		spectravideo)
		ssID="218";;
		palm)
		ssID="219";;
		x1)
		ssID="220";;
		pc88)
		ssID="221";;
		tic80)
		ssID="222";;
		solarus)
		ssID="223";;
		mame)
		ssID="230";;
		easyrpg)
		ssID="231";;
		pico8)
		ssID="234";;
		pcv2)
		ssID="237";;
		pet)
		ssID="240";;
		lowresnx)
		ssID="244";;
	
	  *)
		echo -n "unknown"
		;;
	esac		
}

get_ra_alias(){
	case $1 in				
		atari2600)
			remoteSystem="Atari - 2600"
			;;
		lynx)
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
			remoteSystem="Sega - Master System - Mark III"
			;;
		genesis)
			remoteSystem="Sega - Mega Drive - Genesis"
			;;
		genesiswide)
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
}

scrap_rom () {
	urlMedia=$1
	urlSave=$2		
	media=$3
	echo -e "${BOLD}Scraping: $media.${NONE}"
	StatusString=$(wget --spider "$urlMedia" 2>&1)
	echo -ne "${BOLD}Searching World Region..."
	if [[ $StatusString == *"image/png"* ]]; then
		wget -q --show-progress "$urlMedia" -O "$urlSave" &> /dev/null
		echo -e "${GREEN}Found it!${NONE}"
	else
		echo -ne "${BOLD}Searching USA Region..."
		firstString="$urlMedia"
		secondString="(usa)"
		urlMedia="${firstString/(wor)/"$secondString"}"  	
		StatusString=$(wget --spider "$urlMedia" 2>&1)
		if [[ $StatusString == *"image/png"* ]]; then
			wget -q --show-progress "$urlMedia" -O "$urlSave" &> /dev/null
			echo -e "${GREEN}Found it!${NONE}"
		else
				echo -ne "${BOLD}Searching EU Region..."
				firstString="$urlMedia"
				secondString="(eu)"
				urlMedia="${firstString/(usa)/"$secondString"}"  	
				StatusString=$(wget --spider "$urlMedia" 2>&1)
			if [[ $StatusString == *"image/png"* ]]; then
				wget -q --show-progress "$urlMedia" -O "$urlSave" &> /dev/null
				echo -e "${GREEN}Found it!${NONE}"
			
			else
				echo -ne "${BOLD}Searching US Region..."
				firstString="$urlMedia"
				secondString="(us)"
				urlMedia="${firstString/(eu)/"$secondString"}"  
				StatusString=$(wget --spider "$urlMedia" 2>&1)
				if [[ $StatusString == *"image/png"* ]]; then
					wget -q --show-progress "$urlMedia" -O "$urlSave" &> /dev/null
					echo -e "${GREEN}Found it!${NONE}"
				else
					echo -e "${RED}NO IMG FOUND${NONE}"
				fi
				
			fi
		fi
	fi
}


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
cat ~/dragoonDoriseTools/pegasus-android-metadata/logo.ans

selected_device_descriptions=$(whiptail --title "Pegasus Rom Scrapper" \
   --checklist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"ALL" "This option will look for all systems on your SD Card" OFF \
	"atari2600" "Atari - 2600" OFF \
	"atarilynx" "Atari - Lynx" OFF \
	"doom" "DOOM" OFF \
	"dos" "DOS" OFF \
	"fbneo" "FBNeo - Arcade Games" OFF \
	"pcengine" "NEC - PC Engine - TurboGrafx 16" OFF \
	"pcenginecd" "NEC - PC Engine CD - TurboGrafx-CD" OFF \
	"gb" "Nintendo - Game Boy" OFF \
	"gba" "Nintendo - Game Boy Advance" OFF \
	"gbc" "Nintendo - Game Boy Color" OFF \
	"gc" "Nintendo - GameCube" OFF \
	"3ds" "Nintendo - Nintendo 3DS" OFF \
	"n64" "Nintendo - Nintendo 64" OFF \
	"nds" "Nintendo - Nintendo DS" OFF \
	"nes" "Nintendo - Nintendo Entertainment System" OFF \
	"pokemini" "Nintendo - Pokemon Mini" OFF \
	"snes" "Nintendo - Super Nintendo Entertainment System" OFF \
	"sneswide" "Super Nes Wide Hack" OFF \
	"wii" "Nintendo - Wii" OFF \
	"neogeo" "SNK - Neo Geo" OFF \
	"neogeocd" "SNK - Neo Geo CD" OFF \
	"ngp" "SNK - Neo Geo Pocket" OFF \
	"ngpc" "SNK - Neo Geo Pocket Color" OFF \
	"scummvm" "ScummVM" OFF \
	"sega32x" "Sega - 32X" OFF \
	"dreamcast" "Sega - Dreamcast" OFF \
	"gamegear" "Sega - Game Gear" OFF \
	"mastersystem" "Sega - Master System" OFF \
	"genesis" "Sega - Mega Drive - Genesis" OFF \
	"genesiswide" "Genesis Wide Hack" OFF \
	"segacd" "Sega - Mega-CD - Sega CD" OFF \
	"saturn" "Sega - Saturn" OFF \
	"psx" "Sony - PlayStation" OFF \
	"ps2" "Sony - PlayStation 2" OFF \
	"psp" "Sony - PlayStation Portable" OFF \
	"3do" "The 3DO Company - 3DO" OFF \
   3>&1 1<&2 2>&3)

if [[ $selected_device_descriptions == "ALL" ]]; then
	selected_device_descriptions_all="atari2600 atarilynx doom dos fbneo pcengine pcenginecd gb gba gbc gc 3ds n64 nds nes pokemini snes sneswide wii neogeo neogeocd ngp ngpc scummvm sega32x dreamcast gamegear mastersystem genesis genesiswide segacd saturn psx ps2 psp 3do"
	mapfile -t selected_device_names <<< $selected_device_descriptions_all
else
	mapfile -t selected_device_names <<< $selected_device_descriptions
fi
clear
echo -e "The Roms are scrapped in two loops."
echo -e "${BOLD}First loop${NONE} - Uses Retroarch Thumbnails. It's fast but doesn't have all the systems and roms"	
echo -e "${BOLD}Second loop${NONE} - Uses ScreenScraper. It's slow but will find the images that the first loop didn't get"
echo -e "Press the ${RED}A Button${NONE} to start the First Loop"
read pause	
#System loop
for device_name in ${selected_device_names[@]};
 do
	 message=$device_name
	 system="${message//'"'/}"            
	 #ls ~/storage/$storageLocation/$system
	 mkdir ~/storage/$storageLocation/$system/media &> /dev/null
	 mkdir ~/storage/$storageLocation/$system/media/screenshot &> /dev/null
	 mkdir ~/storage/$storageLocation/$system/media/box2dfront &> /dev/null
	 mkdir ~/storage/$storageLocation/$system/media/wheel &> /dev/null
	 
	 #Retroarch system folder name
	 get_ra_alias $system
	
	 #Roms loop
	 for entry in ~/storage/$storageLocation/$system/*
	 do
		 #Cleaning up names
		firstString=$entry
		secondString=""
		romName="${firstString/"/data/data/com.termux/files/home/storage/$storageLocation/$system/"/"$secondString"}"   		
		romNameNoExtension=${romName%.*}		
		
		startcapture=true
		 
		#.txt validation
		 STR=$romName
		 SUB='.txt'
		 if grep -q "$SUB" <<< "$STR"; then
			 startcapture=false
		 fi
		#.sav validation
		 STR=$romName
		 SUB='.sav'
		 if grep -q "$SUB" <<< "$STR"; then
			 startcapture=false
		 fi
		#Directory Validation
		DIR=~/storage/$storageLocation/$system/$romName
		if [ -d "$DIR" ]; then
			startcapture=false
		fi
		
		#Blanks cleaning up, TODO: DRY
		firstString=$romNameNoExtension
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		firstString=$romNameNoExtensionNoSpace
		secondString="%20"
		romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"    						
			
		
		if [ $startcapture == true ]; then
				
			#First Scan: Retroarch				
			FILE=~/storage/$storageLocation/$system/media/screenshot/$romNameNoExtension.png
			if [ -f "$FILE" ]; then
				echo -e "Image already exists, ${YELLOW}ignoring${NONE}" &> /dev/null
			else 
				echo -ne "Image not found: $romNameNoExtension screenshot..."
				wget  -q --show-progress "http://thumbnails.libretro.com/$remoteSystem/Named_Snaps/$romNameNoExtension.png" -P ~/storage/$storageLocation/$system/media/screenshot/
				echo -e ""
			fi
			
			FILE=~/storage/$storageLocation/$system/media/box2dfront/$romNameNoExtension.png
			if [ -f "$FILE" ]; then
				echo -e "Image already exists, ${YELLOW}ignoring${NONE}" &> /dev/null
			else 
				echo -ne "Image not found: $romNameNoExtension box2dfront..."
				wget  -q --show-progress "http://thumbnails.libretro.com/$remoteSystem/Named_Boxarts/$romNameNoExtension.png" -P ~/storage/$storageLocation/$system/media/box2dfront/
				echo -e ""
			fi
			
			#exit
		
		fi

	 done
	 
   #rsync -r ~/pegasus-artwork/$system/ ~/storage/$storageLocation/$system/
 done

echo -e "First Loop...${GREEN}completed${NONE}" 
echo -e "This second loop will take longer, make sure your handheld is connected to a power source"
echo -e "Press the ${RED}A Button${NONE} to start the Second Loop"
read pause	

#We check for existing credentials
userStored=false
FILE=~/dragoonDoriseTools/.screenScraperUser
if [ -f "$FILE" ]; then
	userStored=true
	userSS=$(cat ~/dragoonDoriseTools/.screenScraperUser)
	passSS=$(cat ~/dragoonDoriseTools/.screenScraperPass)
fi

if [ $userStored == false ]; then
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
fi

 
 #ScreenScraper loop
 for device_name in ${selected_device_names[@]};
  do
			
	  message=$device_name
	  system="${message//'"'/}"            
		   
	  #ScreenScraper system ID
	  get_sc_id $system
	  
	  #Roms loop
	  for entry in ~/storage/$storageLocation/$system/*
	  do
		  #Cleaning up names
		 firstString=$entry
		 secondString=""
		 romName="${firstString/"/data/data/com.termux/files/home/storage/$storageLocation/$system/"/"$secondString"}"   		
		 romNameNoExtension=${romName%.*}		
		 
		 startcapture=true
		  
		 #.txt validation
		  STR=$romName
		  SUB='.txt'
		  if grep -q "$SUB" <<< "$STR"; then
			  startcapture=false
		  fi
		 #.sav validation
		  STR=$romName
		  SUB='.sav'
		  if grep -q "$SUB" <<< "$STR"; then
			  startcapture=false
		  fi
		 #Directory Validation
		 DIR=~/storage/$storageLocation/$system/$romName
		 if [ -d "$DIR" ]; then
			 startcapture=false
		 fi
		 
		 #Blanks cleaning up, TODO: DRY
		 firstString=$romNameNoExtension
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"   
		 firstString=$romNameNoExtensionNoSpace
		 secondString="%20"
		 romNameNoExtensionNoSpace="${firstString/" "/"$secondString"}"    						
			 
		 
		 if [ $startcapture == true ]; then
			 
			 hasWheel=false
			 hasSs=false
			 hasBox=false
			 
			FILE=~/storage/$storageLocation/$system/media/wheel/$romNameNoExtension.png
			if [ -f "$FILE" ]; then
				 hasWheel=true
			fi
				
			FILE=~/storage/$storageLocation/$system/media/screenshot/$romNameNoExtension.png
			if [ -f "$FILE" ]; then
				 hasSs=true
			fi
				
			FILE=~/storage/$storageLocation/$system/media/box2dfront/$romNameNoExtension.png
			if [ -f "$FILE" ]; then
				 hasBox=true
			fi
								 
 
			 #We only search games with no art
			 if [ $hasWheel == false ] || [ $hasSs == false ] || [ $hasBox == false ]; then
				#Second Scan: Screenscraper		
				 url="https://www.screenscraper.fr/api2/jeuInfos.php?devid=djrodtc&devpassword=diFay35WElL&softname=zzz&output=json&ssid=${userSS}&sspassword=${passSS}&crc=&systemeid=${ssID}&romtype=rom&romnom=${romNameNoExtensionNoSpace}.zip"
				
				 #ID Game
				 content=$(curl "$url") 
				 gameIDSS=$( jq -r  '.response.jeu.id' <<< "${content}" ) 
							 
				 
				urlMediaWheel="https://www.screenscraper.fr/api2/mediaJeu.php?devid=djrodtc&devpassword=diFay35WElL&softname=zzz&ssid=${userSS}&sspassword=${passSS}&crc=&md5=&sha1=&systemeid=${ssID}&jeuid=${gameIDSS}&media=wheel(wor)"			 
				urlMediaWheelHD="https://www.screenscraper.fr/api2/mediaJeu.php?devid=djrodtc&devpassword=diFay35WElL&softname=zzz&ssid=${userSS}&sspassword=${passSS}&crc=&md5=&sha1=&systemeid=${ssID}&jeuid=${gameIDSS}&media=wheel-hd(wor)"			 
				 urlMediaSs="https://www.screenscraper.fr/api2/mediaJeu.php?devid=djrodtc&devpassword=diFay35WElL&softname=zzz&ssid=${userSS}&sspassword=${passSS}&crc=&md5=&sha1=&systemeid=${ssID}&jeuid=${gameIDSS}&media=ss(wor)"
				 urlMediaBox="https://www.screenscraper.fr/api2/mediaJeu.php?devid=djrodtc&devpassword=diFay35WElL&softname=zzz&ssid=${userSS}&sspassword=${passSS}&crc=&md5=&sha1=&systemeid=${ssID}&jeuid=${gameIDSS}&media=box-2D(wor)"		
				 wheelSavePath="./storage/$storageLocation/$system/media/wheel/$romNameNoExtension.png"
				 ssSavePath="./storage/$storageLocation/$system/media/screenshot/$romNameNoExtension.png"
				 box2dfrontSavePath="./storage/$storageLocation/$system/media/box2dfront/$romNameNoExtension.png"
										 
				 echo -e "Downloading Images for $romNameNoExtension"		
				 
				if [ $hasWheel == true ]; then
					echo -e "Image already exists, ${YELLOW}ignoring${NONE}" &> /dev/null
				else 
					scrap_rom "$urlMediaWheel" "$wheelSavePath" "Wheel"
				fi
				
				#Wheel HD just in case
				FILE=~/storage/$storageLocation/$system/media/wheel/$romNameNoExtension.png
				if [ -f "$FILE" ]; then
					echo -e "Image already exists, ${YELLOW}ignoring${NONE}" &> /dev/null
				else 
					scrap_rom "$urlMediaWheelHD" "$wheelSavePath" "Wheel HD"
				fi
				
				
				if [ $hasSs == true ]; then
					echo -e "Image already exists, ${YELLOW}ignoring${NONE}" &> /dev/null
				else 
					scrap_rom "$urlMediaSs" "$ssSavePath" "Screenshot"
				fi
				
				if [ $hasBox == true ]; then
					echo -e "Image already exists, ${YELLOW}ignoring${NONE}" &> /dev/null
				else 
					scrap_rom "$urlMediaBox" "$box2dfrontSavePath" "2D Box"
				fi
			else
				echo -e "Game already scraped" &> /dev/null
			fi
			 
			
		 
		 fi
 
	  done
	  
	#rsync -r ~/pegasus-artwork/$system/ ~/storage/$storageLocation/$system/
  done
 
 echo -e "Second Loop...${GREEN}completed${NONE}" 
 echo -e "Remember to restart Pegasus to see the new artwork" 
 echo -e  "Press the ${RED}A button${NONE} to finish"
 read pause
 am startservice -a com.termux.service_stop com.termux/.app.TermuxService &> /dev/null