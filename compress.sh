#Functions for CHDMAN & Maxcso
compressCHDMAN () {
    for file in ./*.{iso,cue}; do
    name="${file%.*}" #Remove extension
    chdman createcd -i "file" -o "name.chd" --force
done

compressMaxcso () {
    for file in ./*.{iso,cue}; do
    maxcso "$file"
done

#Check for .storageInternal and determine if ROMs are in internal or not
useInternalStorage=false
FILE=~/dragoonDoriseTools/.storageInternal
if [ -f "$FILE" ]; then
	useInternalStorage=true
	storageLocation="shared/roms"
else
	useInternalStorage=false
	storageLocation="external-1"

fi

#Pick the systems
SYSTEMS=$(whiptail --title "ROM Compressor" --checklist "Please select the systems whose ROMs you want to compress" 20 78 15 \
	"dreamcast" "Sega - Dreamcast" OFF \
	"ps2" "Sony - PlayStation 2" OFF \
	"psp" "Sony - PlayStation Portable" OFF \
	"psx" "Sony - PlayStation" OFF \
	"saturn" "Sega - Saturn" OFF \
 3>&1 1>&2 2>&3)


#Option to delete original uncompressed ROMs
while true; do
	removeOldROM=$(whiptail --title "Do you want to automatically PERMANENTELY delete the uncompressed ROMs after compression?" \
   --radiolist "Move using your DPAD and select your platforms with the Y button. Press the A button to select." 10 80 4 \
	"YES" "Delete old ROMs" OFF \
	"NO" "Keep the old ROMs" OFF \
   3>&1 1<&2 2>&3)
	case $compressNow in
		[YES]* ) break;;
		[NO]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done

for system in $(eval echo "${SYSTEMS}"); do
    cd ~/storage/$storageLocation/$system/
    if [ "$system" = psp ]; then
    compressMaxcso
    else
    compressCHDMAN
    fi
	if [ "$removeOldROM" = "YES" ]; then
    rm -rf ./*.{iso,cue,bin}
    fi
done
