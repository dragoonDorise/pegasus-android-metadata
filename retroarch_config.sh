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

handheldModel=""
FILE=~/dragoonDoriseTools/.isRG552
if [ -f "$FILE" ]; then
	handheldModel="RG552"
fi

snesMode="CLASSIC"
FILE=~/dragoonDoriseTools/.snes87
if [ -f "$FILE" ]; then
	snesMode="INTERNAL"
fi
echo -ne "Creating config files & backup old ones..."
mkdir ~/storage/shared/RetroArch/overlays/ &> ~/storage/shared/pegasus_installer_log.log
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/ &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo -ne "Installing overlays..."
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/overlays/ ~/storage/shared/RetroArch/overlays/ &> ~/storage/shared/pegasus_installer_log.log
echo -e "${GREEN}OK${NONE}"
echo -ne "Applying hotkeys..."
sed -i 's/config_save_on_exit = "true"/config_save_on_exit = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_overlay_enable = "true"/input_overlay_enable = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/menu_show_load_content_animation = "true"/menu_show_load_content_animation = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_autoconfig = "true"/notification_show_autoconfig = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_config_override_load = "true"/notification_show_config_override_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_refresh_rate = "true"/notification_show_refresh_rate = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_remap_load = "true"/notification_show_remap_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_screenshot = "true"/notification_show_screenshot = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_set_initial_disk = "true"/notification_show_set_initial_disk = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/notification_show_patch_applied = "true"/notification_show_patch_applied = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/video_scale_integer = "false"/video_scale_integer = "true"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_menu_toggle_gamepad_combo = "0"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_enable_hotkey_btn = "nul"/input_enable_hotkey_btn = "109"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_exit_emulator_btn = "nul"/input_exit_emulator_btn = "108"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_load_state_btn = "nul"/input_load_state_btn = "102"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_menu_toggle_gamepad_combo = "nul"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_rewind_btn = "nul"/input_rewind_btn = "104"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_save_state_btn = "nul"/input_save_state_btn = "103"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_state_slot_decrease_btn = "nul"/input_state_slot_decrease_btn = "h0down"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_state_slot_increase_btn = "nul"/input_state_slot_increase_btn = "h0up"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/input_toggle_fast_forward_btn = "nul"/input_toggle_fast_forward_btn = "105"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
sed -i 's/menu_driver = "glui"/menu_driver = "ozone"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
echo -e "${GREEN}OK${NONE}"
#Snes configuration
/bin/bash ~/dragoonDoriseTools/pegasus-android-metadata/snes_config.sh
if [[ $handheldModel == "RG552" ]]; then
	echo -ne "RG552 Special configuration..."
	#cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/rg552/RetroArch/config/Snes9x/snes.cfg ~/storage/shared/RetroArch/config/Snes9x &> ~/storage/shared/pegasus_installer_log.log

	#Overlay Fixes for 5:3 screens
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Genesis Plus GX/genesis.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/MAME 2003-Plus/mame.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Beetle NeoPop/ngp.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Beetle NeoPop/ngpc.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Beetle Cygne/wswan.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Beetle Cygne/wswanc.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/lynx.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Gambatte/gb.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Gambatte/gbc.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Genesis\sPlus\sGX/gamegear.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Genesis\sPlus\sGX/genesis.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Nestopia/nes.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/mGBA/gba.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Snes9x/snes.cfg &> ~/storage/shared/pegasus_installer_log.log 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/Genesis\sPlus\sGX/mastersystem.cfg &> ~/storage/shared/pegasus_installer_log.log 
	
echo -e "${GREEN}OK${NONE}"

fi
#Cores https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/

echo -e "Downloading RetroArch Recommended Cores..."
installCores="true"
#if (whiptail --title "Download RetroArch Cores?" --yesno "Do you want to download all the recommended RetroArch Cores? If you installed #RetroArch from the Play Store or are unseure choose YES." 8 78); then
#	installCores="true"
#else
#	installCores="false"
#fi

if [ $installCores == "true" ]; then
	
	# Do this in a better way!
	cd ~/storage/shared/RetroArch/downloads
	find . -name "*.so" -type f -delete
	echo -ne "Downloading Final Burn Neo..."
	FILE=~/storage/shared/RetroArch/downloads/xxxx
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/fbneo_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"	
	fi
	echo -ne "Downloading Mame 2010..."
	FILE=~/storage/shared/RetroArch/downloads/xxxx
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mame2010_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	echo -ne "Downloading Mame 2003 Plus..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mame2003_plus_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi

	echo -ne "Downloading Atari 2600..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/stella_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
		
	echo -ne "Downloading Atari Lynx..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_lynx_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading WonderSwan..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_wswan_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading DooM..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/prboom_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading DOS..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/dosbox_pure_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	echo -ne "Downloading PC Engine..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_pce_fast_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading GameBoy..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/gambatte_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading GameBoy Advance..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mgba_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading NES..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/nestopia_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading SNES Widescreen..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/bsnes_hd_beta_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	echo -ne "Downloading SNES..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/snes9x_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Genesis & Sega CD & GameGear & Master System..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/genesis_plus_gx_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Genesis Widescreen..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/genesis_plus_gx_wide_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Sega32x..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/picodrive_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "Downloading Neo Geo..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/neocd_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	

	echo -ne "Downloading Neo Geo Pocket..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/mednafen_ngp_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi

	echo -ne "Downloading PSX..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/pcsx_rearmed_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi	

	echo -ne "Downloading ScummVM..."
	if [ -f "$FILE" ]; then
		echo -e "${GREEN}Already Downloaded${NONE}"	
	else	
		wget https://buildbot.libretro.com/nightly/android/latest/arm64-v8a/scummvm_libretro_android.so.zip  &> ~/storage/shared/pegasus_installer_log.log
		echo -e "${GREEN}OK${NONE}"		
	fi
	
	echo -ne "${BOLD}Unzipping${NONE} cores..."
	
	unzip ~/storage/shared/RetroArch/downloads/gambatte_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/scummvm_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/fbneo_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mame2010_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mame2003_plus_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/stella_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mednafen_lynx_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mednafen_wswan_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/prboom_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/dosbox_pure_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mednafen_pce_fast_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mgba_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/nestopia_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/bsnes_hd_beta_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/snes9x_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/genesis_plus_gx_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/genesis_plus_gx_wide_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/picodrive_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/neocd_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/mednafen_ngp_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	unzip ~/storage/shared/RetroArch/downloads/pcsx_rearmed_libretro_android.so.zip &> ~/storage/shared/pegasus_installer_log.log
	find . -name "*.zip" -type f -delete
	echo -e "${GREEN}OK${NONE}"
	
	cd ~/dragoonDoriseTools

fi


#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> ~/storage/shared/pegasus_installer_log.log 
