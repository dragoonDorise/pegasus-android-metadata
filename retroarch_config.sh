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

handheldModel=$(cat ~/dragoonDoriseTools/.device)
useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"
	
fi
snesMode="CLASSIC"
FILE=~/dragoonDoriseTools/.snes87
if [ -f "$FILE" ]; then
	snesMode="INTERNAL"
fi
echo -e "Detecting model...${GREEN}$handheldModel${NONE}"
echo -ne "Creating config files & backup old ones..."
echo "### RA config files "  &>> ~/storage/shared/pegasus_installer_log.log
mkdir ~/storage/shared/RetroArch/overlays/ &>> ~/storage/shared/pegasus_installer_log.log
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/ &>> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo -ne "Installing overlays..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/overlays/ ~/storage/shared/RetroArch/overlays/ &>> ~/storage/shared/pegasus_installer_log.log


echo -e "${GREEN}OK${NONE}"
echo "### RA Hotkeys "  &>> ~/storage/shared/pegasus_installer_log.log
echo -ne "Applying hotkeys..."
sed -i 's/config_save_on_exit = "true"/config_save_on_exit = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_overlay_enable = "true"/input_overlay_enable = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/menu_show_load_content_animation = "true"/menu_show_load_content_animation = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_autoconfig = "true"/notification_show_autoconfig = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_config_override_load = "true"/notification_show_config_override_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_refresh_rate = "true"/notification_show_refresh_rate = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_remap_load = "true"/notification_show_remap_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_screenshot = "true"/notification_show_screenshot = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_set_initial_disk = "true"/notification_show_set_initial_disk = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_patch_applied = "true"/notification_show_patch_applied = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/video_scale_integer = "false"/video_scale_integer = "true"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_menu_toggle_gamepad_combo = "0"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_enable_hotkey_btn = "nul"/input_enable_hotkey_btn = "109"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_exit_emulator_btn = "nul"/input_exit_emulator_btn = "108"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_load_state_btn = "nul"/input_load_state_btn = "102"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_menu_toggle_gamepad_combo = "nul"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_rewind_btn = "nul"/input_rewind_btn = "104"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_save_state_btn = "nul"/input_save_state_btn = "103"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_state_slot_decrease_btn = "nul"/input_state_slot_decrease_btn = "h0down"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_state_slot_increase_btn = "nul"/input_state_slot_increase_btn = "h0up"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_toggle_fast_forward_btn = "nul"/input_toggle_fast_forward_btn = "105"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/menu_driver = "glui"/menu_driver = "ozone"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &>> ~/storage/shared/pegasus_installer_log.log 
echo -e "${GREEN}OK${NONE}"



#Cores https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/

#Snes configuration
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/snes_config.sh



echo -e "Downloading RetroArch Recommended Cores..."
installCores="true"
echo "### RA Installing cores "  &>> ~/storage/shared/pegasus_installer_log.log

if [ $installCores == "true" ]; then
	
	# Do this in a better way!
	cd ~/storage/shared/RetroArch/downloads
	#find . -name "*.so" -type f -delete
		
	echo -ne "Downloading a5200 (Atari 5200)..."
	FILE=~/storage/shared/RetroArch/downloads/opera_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/a5200_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
	
	echo -ne "Downloading Pro System (Atari 7800)..."
	FILE=~/storage/shared/RetroArch/downloads/opera_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/prosystem_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
	
		
	echo -ne "Downloading Opera..."
	FILE=~/storage/shared/RetroArch/downloads/opera_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/opera_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi

	echo -ne "Downloading Intellivision..."
	FILE=~/storage/shared/RetroArch/downloads/freeintv_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/freeintv_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi	
	
	echo -ne "Downloading Final Burn Alpha..."
	FILE=~/storage/shared/RetroArch/downloads/fbalpha2012_neogeo_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/fbalpha2012_neogeo_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
	
	echo -ne "Downloading Final Burn Neo..."	
	FILE=~/storage/shared/RetroArch/downloads/fbneo_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/fbneo_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
	echo -ne "Downloading Mame 2010..."
	FILE=~/storage/shared/RetroArch/downloads/mame2010_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mame2010_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	echo -ne "Downloading Mame 2003 Plus..."
	FILE=~/storage/shared/RetroArch/downloads/mame2003_plus_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mame2003_plus_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi

	echo -ne "Downloading Atari 2600..."
	FILE=~/storage/shared/RetroArch/downloads/stella_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/stella_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
		
	echo -ne "Downloading Atari Lynx..."
	FILE=~/storage/shared/RetroArch/downloads/mednafen_lynx_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_lynx_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading WonderSwan..."
	FILE=~/storage/shared/RetroArch/downloads/mednafen_wswan_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_wswan_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading DooM..."
	FILE=~/storage/shared/RetroArch/downloads/prboom_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/prboom_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading DOS..."
	FILE=~/storage/shared/RetroArch/downloads/dosbox_pure_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/dosbox_pure_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	echo -ne "Downloading PC Engine..."
	FILE=~/storage/shared/RetroArch/downloads/mednafen_pce_fast_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_pce_fast_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading GameBoy..."
	FILE=~/storage/shared/RetroArch/downloads/gambatte_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/gambatte_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading GameBoy Advance..."
	FILE=~/storage/shared/RetroArch/downloads/mgba_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mgba_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading NES..."
	FILE=~/storage/shared/RetroArch/downloads/nestopia_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/nestopia_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading SNES Widescreen..."
	FILE=~/storage/shared/RetroArch/downloads/bsnes_hd_beta_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/bsnes_hd_beta_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	echo -ne "Downloading SNES..."
	FILE=~/storage/shared/RetroArch/downloads/snes9x_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/snes9x_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Genesis & Sega CD & GameGear & Master System..."
	FILE=~/storage/shared/RetroArch/downloads/genesis_plus_gx_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/genesis_plus_gx_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Genesis Widescreen..."
	FILE=~/storage/shared/RetroArch/downloads/genesis_plus_gx_wide_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/genesis_plus_gx_wide_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Sega32x..."
	FILE=~/storage/shared/RetroArch/downloads/picodrive_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/picodrive_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi

	echo -ne "Downloading Neo Geo..."
	FILE=~/storage/shared/RetroArch/downloads/neocd_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/neocd_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	

	echo -ne "Downloading Neo Geo Pocket..."
	FILE=~/storage/shared/RetroArch/downloads/mednafen_ngp_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_ngp_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi

	echo -ne "Downloading PSX..."
	FILE=~/storage/shared/RetroArch/downloads/pcsx_rearmed_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/pcsx_rearmed_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi	

	echo -ne "Downloading ScummVM..."
	FILE=~/storage/shared/RetroArch/downloads/scummvm_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/scummvm_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	

fi


if [[ $handheldModel == "RG552" ]]; then

	echo "### RA 552 config "  &>> ~/storage/shared/pegasus_installer_log.log
	echo -e ""
	echo -ne "RG552 Special configuration..."

	#Overlay Fixes for 5:3 screens	
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Genesis\ Plus\ GX/genesis.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/MAME\ 2003-Plus/mame.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.625000"/input_overlay_scale_landscape = "1.735000"/g' ~/storage/shared/RetroArch/config/Beetle\ NeoPop/ngp.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.625000"/input_overlay_scale_landscape = "1.735000"/g' ~/storage/shared/RetroArch/config/Beetle\ NeoPop/ngpc.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Beetle\ Cygne/wswan.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Beetle\ Cygne/wswanc.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Beetle\ Lynx/lynx.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.680000"/input_overlay_scale_landscape = "1.780000"/g' ~/storage/shared/RetroArch/config/Gambatte/gb.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.685000"/input_overlay_scale_landscape = "1.785000"/g' ~/storage/shared/RetroArch/config/Gambatte/gbc.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.544999"/input_overlay_scale_landscape = "1.645000"/g' ~/storage/shared/RetroArch/config/Genesis\ Plus\ GX/gamegear.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Genesis\ Plus\ GX/genesis.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Nestopia/nes.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Snes9x/snes.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.125000"/g' ~/storage/shared/RetroArch/config/Genesis\ Plus\ GX/mastersystem.cfg &>> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.205000"/g' ~/storage/shared/RetroArch/config/PicoDrive/sega32x.cfg &>> ~/storage/shared/pegasus_installer_log.log 	
	sed -i 's/input_overlay_scale_landscape = "1.060000"/input_overlay_scale_landscape = "1.105000"/g' ~/storage/shared/RetroArch/config/Genesis\ Plus\ GX/segacd.cfg &>> ~/storage/shared/pegasus_installer_log.log 	
		
		
		
	echo -e "${GREEN}OK${NONE}"

fi

if [[ $handheldModel == "ODIN" ]]; then
	echo "### RA Odin config "  &>> ~/storage/shared/pegasus_installer_log.log
	echo -e ""
	echo -e "ODIN Special configuration..."
	cd ~/storage/shared/RetroArch/downloads
	#Flycast Core	
	echo -ne "Downloading Flycast..."
	FILE=~/storage/shared/RetroArch/downloads/flycast_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/flycast_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
		
	#Yaba Sanshiro Core	
	echo -ne "Downloading Yaba Sanshiro..."
	FILE=~/storage/shared/RetroArch/downloads/flycast_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/yabasanshiro_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
	
	
	
	#Mupen Core	
	echo -ne "Downloading Mupen64 Plus GLE3..."
	FILE=~/storage/shared/RetroArch/downloads/mupen64plus_next_gles3_libretro_android.so
	if [ -f "$FILE" ]; then
		echo -e "${YELLOW}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mupen64plus_next_gles3_libretro_android.so.zip  &>> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi	
	
	#Configuration
	rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/odin/RetroArch/config/ ~/storage/shared/RetroArch/config/ &>> ~/storage/shared/pegasus_installer_log.log
	
	cp ~/dragoonDoriseTools/pegasus-android-metadata/roms/dreamcast/metadata.pegasus.txt.odin ~/storage/$storageLocation/dreamcast/metadata.pegasus.txt
	rm ~/storage/$storageLocation/dreamcast/metadata.pegasus.txt.odin	
	
	cp ~/dragoonDoriseTools/pegasus-android-metadata/roms/saturn/metadata.pegasus.txt.odin ~/storage/$storageLocation/saturn/metadata.pegasus.txt
	rm ~/storage/$storageLocation/saturn/metadata.pegasus.txt.odin
	#find . -name "*.zip" -type f -delete
	
fi
echo "### RA Unzipping cores "  &>> ~/storage/shared/pegasus_installer_log.log

echo -ne "${BOLD}Unzipping${NONE} cores..."
cd ~/storage/shared/RetroArch/downloads
for entry in ~/storage/shared/RetroArch/downloads/*.zip
do
	 unzip -o $entry &>> ~/storage/shared/pegasus_installer_log.log
done

find . -name "*.zip" -type f -delete
cd ~/dragoonDoriseTools
echo -e "${GREEN}OK${NONE}"


echo -e  "Press the ${RED}A button${NONE} to continue"
read pause

#Bezels
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/ra_bezels.sh


