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


if (whiptail --title "Retroarch Bezels" --yesno "Do you want to use Bezels for classic games? Those will hide the black bars on the screen with graphics of each appropiate system." 8 78); then
	find ~/storage/shared/RetroArch/config/ -type f -name "*.cfg" -exec sed -i -e 's/input_overlay_enable = "false"/input_overlay_enable = "true"/g' {} \;
else
	find ~/storage/shared/RetroArch/config/ -type f -name "*.cfg" -exec sed -i -e 's/input_overlay_enable = "true"/input_overlay_enable = "false"/g' {} \;
fi

clear