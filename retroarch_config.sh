#!/bin/sh


mkdir ~/storage/shared/RetroArch/overlays/ &> /dev/null
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/config/ ~/storage/shared/RetroArch/config/ &> /dev/null
rsync -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/common/RetroArch/overlays/ ~/storage/shared/RetroArch/overlays/ &> /dev/null

sed -i 's/config_save_on_exit = "true"/config_save_on_exit = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_overlay_enable = "true"/input_overlay_enable = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/menu_show_load_content_animation = "true"/menu_show_load_content_animation = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_autoconfig = "true"/notification_show_autoconfig = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_config_override_load = "true"/notification_show_config_override_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_refresh_rate = "true"/notification_show_refresh_rate = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_remap_load = "true"/notification_show_remap_load = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_screenshot = "true"/notification_show_screenshot = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_set_initial_disk = "true"/notification_show_set_initial_disk = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/notification_show_patch_applied = "true"/notification_show_patch_applied = "false"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/video_scale_integer = "false"/video_scale_integer = "true"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_menu_toggle_gamepad_combo = "0"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_enable_hotkey_btn = "nul"/input_enable_hotkey_btn = "109"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_exit_emulator_btn = "nul"/input_exit_emulator_btn = "108"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_load_state_btn = "nul"/input_load_state_btn = "102"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_menu_toggle_gamepad_combo = "nul"/input_menu_toggle_gamepad_combo = "6"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_rewind_btn = "nul"/input_rewind_btn = "104"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_save_state_btn = "nul"/input_save_state_btn = "103"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_state_slot_decrease_btn = "nul"/input_state_slot_decrease_btn = "h0down"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_state_slot_increase_btn = "nul"/input_state_slot_increase_btn = "h0up"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/input_toggle_fast_forward_btn = "nul"/input_toggle_fast_forward_btn = "105"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
sed -i 's/menu_driver = "glui"/menu_driver = "ozone"/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 

if [ $handheldModel == "53" ]
then
	
	cp -r ~/dragoonDoriseTools/pegasus-android-metadata/internal/rg552/RetroArch/config/Snes9x/snes9x.cfg ~/storage/shared/RetroArch/config/Snes9x &> /dev/null

	#Overlay Fixes for 5:3 screens
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/genesis.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/mame.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/ngp.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/ngpc.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/wswan.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/wswanc.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/lynx.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/ngp.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/ngpc.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/gb.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/gbc.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/gamegear.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/nes.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/gba.cfg &> /dev/null 
	sed -i 's/input_overlay_scale_landscape = "1.000"/input_overlay_scale_landscape = "1.150000"/g' ~/storage/shared/RetroArch/config/snes.cfg &> /dev/null 

fi
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
#sed -i 's/A/B/g' ~/storage/shared/Android/data/com.retroarch/files/retroarch.cfg &> /dev/null 
