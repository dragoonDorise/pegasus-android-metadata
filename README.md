# Work in progress, only for testing purposes!

<img src="https://github.com/dragoonDorise/RP-epic-noir/blob/main/screenshots/hero-odin.jpg?raw=true">

## Android - Pegasus metadata pack

This guide will help you install, configure [Pegasus Frontend](https://pegasus-frontend.org) and scrap your roms artwork on your Android Handheld.

Table of contents:

- **Pegasus Metadata**
- **Retroarch configuration**
- **Installing this pack**
- **Some Tips**

## Pegasus Metadata

This pack offers support for the following systems with their respective emulators, you _ might need to download them separately from the Google Play Store or within RetroArch_ when a core is used for that system.

| System                    | Emulator                             |
| ------------------------- | ------------------------------------ |
| 3DO                       | Retroarch 1.9 Opera core             |
| Atari 2600                | Retroarch 1.9 Stella core            |
| Atari Lynx                | Retroarch 1.9 Beetle Lynx core       |
| Doom                      | Retroarch 1.9 PrBoom core            |
| GameBoy                   | Retroarch 1.9 Gambatte core          |
| GameBoy Color             | Retroarch 1.9 Gambatte core          |
| GameBoy Advance           | Retroarch 1.5 mGBA core              |
| Gamecube                  | Dolphin                              |
| DooM                      | Retroarch 1.9 Doom core              |
| Dos                       | Retroarch 1.9 DOSBox core            |
| Dreamcast                 | Reddream                             |
| Final Burn Alpha          | Retroarch 1.9 Fba 2020 core          |
| Final Burn Neo            | Retroarch 1.9 Fbn core               |
| Mame 2003 Plus            | Retroarch 1.9 Mame 2003 Plus core    |
| Master System             | Retroarch 1.9 Genesis Plus GX core   |
| Neo Geo                   | Retroarch 1.9 Fba 2020 Neo Geo core  |
| Neo Geo CD                | Retroarch 1.9 Fbn core               |
| Neo Geo Pocket & Color    | Retroarch 1.9 Beetle NeoPop          |
| Nintendo DS               | Drastic                              |
| Nintendo 3DS              | Citra                                |
| Nintendo NES              | Retroarch 1.9 Nestopia core          |
| Nintendo 64               | Mupen64plus FZ                       |
| Nintendo Gamecube         | Mupen64plus FZ                       |
| PC engine                 | Retroarch 1.9 Mednafen pce fast core |
| Playstation               | Retroarch 1.9 PCSX Rearmed core      |
| Playstation 2             | Aether SX2                           |
| Pokemon Mini              | Retroarch 1.9 PokeMini core          |
| PSP                       | PPSSPP                               |
| ScummVM                   | Retroarch 1.9 Scummvm core           |
| Sega 32X                  | Retroarch 1.9 PicoDrive core         |
| Sega CD                   | Retroarch 1.9 Genesis Plus GX core   |
| Sega Game Gear            | Retroarch 1.9 Genesis Plus GX core   |
| Sega Genesis / Mega Drive | Retroarch 1.9 Genesis Plus GX core   |
| Sega Saturn               | Yaba Sanshiro 2 Pro                  |
| Super Nintendo            | Retroarch 1.9 Snes9x Current core    |
| Wonderswan & Color        | Retroarch 1.9 Beetle Cygne core      |

Keep in mind not all Android Handhelds are powerful enough to run all those systems. You can check your device compatibility in these Community maintained guides:

[RG552 Compatibility List](https://tinyurl.com/RG552GameSettings)

[Retroid Pocket 2+ Compatibility List](https://tinyurl.com/RP2PlusGameSettings)

[Powkiddy X18S Compatibility List](https://tinyurl.com/X18SGameSettings)

## Retroarch configuration

We're also including a Retroarch configuration preset that will do the following:

- Set the right aspect ratio (1:1) for Handhelds & Mame Systems
- Set the right aspect ratio (4:3 )for SNES and NES
- Install LCD3 Shader for all Handhelds
- Hide the load content splash screen
- AutoSave and AutoLoad State
- 351Elec Hotkeys [Cheatsheet](https://ia802301.us.archive.org/17/items/351-elec-shortcuts-cheatsheet_20210809/351ELEC%20shortcuts%20cheatsheet.pdf)

This configuration is based on [RGC RG552 Linux Setup](https://retrogamecorps.com/2021/12/27/anbernic-rg552-linux-setup-guide/)

# Installing this pack

Just follow the next steps, it should be pretty straightforward.

## Step 0 - Enable APK installation and other preparations

First you'll need to enable installing APK packages, which can be done in your Android device on Settings → Security → Unknown Sources, turned on. You need this to install Pegasus, since it's not available on the Google App Store

## Automatic installation - Recommended

Download onto your handheld the app [Termux](https://f-droid.org/repo/com.termux_117.apk) and install it, we will use this app so we can automate everything.

Open Termux on your handheld, give it write permissions when it asks for them and just copy and paste the following command.

    /bin/bash -c "$(curl -fsSL https://bit.ly/3ntlzL8)"

Press Enter and follow the steps the script will show you, when it's finished you'll have everything installed and you'll only need to copy your roms to the specific folders created in the SD Card.

### Scraping your roms

When you have copied your roms in the SD Card, open Termux again and type this command:

    bash scrap.sh

Press Enter, this will show a dialog screen where you need to choose the platforms you want to scrap, any rom already scrapped will be ignored, use the DPAD to move in the menu and press the Space in the Android Virtual Keyboard and Press A when ready.

Right now the script uses Retroarch Thumbnail repository, so not all roms are available. Work is being done to replace this with **Screen Scrapper**

### Updating your Pegasus Metadata Pack installation.

I plan to provide updates to this Metadata Pack so more systems / themes are available and any possible bug is fixed, you can do this by opening Termux again and typing this command:

    bash update.sh

### Undoing everything

If you don't like this Metadata Pack and you had already your handheld preconfigured you can undo everything, just open Termux and execute this script.

    bash undo.sh

Press Enter and just wait for everything to finish, this will restore everything the way it was when you installed this Metadata Pack

## Manual installation.

If you want to do it all by yourselft step by step just follow these steps.

## 1 - Get your SD Card ID

Open RetroArch on your Handheld, if you don't have it installed just download it from the Google Play Store, go to "Load Content", then select "/storage" and you'll get a screen like this:

    Parent Directory
    XXXX-XXXX
    emulated
    self

Anotate the XXXX-XXXX number, it will be some random number like ECA-11EF, we will need it later.

## 2 - Download Pegasus

On your handheld browser go to [Pegasus website](https://pegasus-frontend.org/#downloads) and install Pegasus.

## 3 - Download the latest Pegasus Frontend metadata Pack

Just click here: [Pegasus Frontend Android Metadata ](https://github.com/dragoonDorise/pegasus-android-metadata/archive/main.zip)

Unzip it in your computer, insert your SD Card in your computer and just copy the contents of the _roms_ folder, **don't copy the folder itself, only the contents**.

## 4 - Transfer your Roms

Now that you have the Metadata pack in your handheld lets copy some games, just drag and drop the rom files in every system folder ( we recommend using no intro roms found on archive.org )

Example: I you want to transfer **Legend of Zelda, The - A Link to the Past (USA).zip** for Super Nintendo, just drag and drop the file to the snes/ folder in the SD Card, repeat the process with the rest of the systems you want to play.

When you are good to go, insert the SD Card on your Handheld and carry on to the next step.

## 5 - Configure Pegasus & Retroarch

Use your Android file browser app and navigate to your SD card and look for the **-internal** folder we copied before.

In there you'll see several folders.

    common
    rg552
    odin
    etc..

You need to copy the contents of the **commons** folder to your Android internal storage, on the root folder where you should have a RetroArch and pegasus-frontend folders already, make sure you merge your folders so we add these files to the ones that are already there, You'll probably need to overwrite some files. Remember: Merge folders and overwrite files.

Remember the XXXX-XXXX number we got earlier?

Edit internal/common/pegasus-frontend/game_dirs.txt and replace 0000-0000 with the number.

For some systems you need to copy some extra files because you need extra configuration, just look for your systems name folder and do the same, copy its contents in your Android internal storage.

Example, If you have an Anbernic RG552 you'll need to Copy the contents of the common folder and then copy the contents of the rg552 folder. **Always copy the common folder first**

## 6 Installing Themes

<img src="https://raw.githubusercontent.com/dragoonDorise/RP-Switch/main/screenshots/RG552.jpg">
<img src="https://github.com/dragoonDorise/RP-epic-noir/blob/main/screenshots/hero-odin.jpg?raw=true">

You can install any [Pegasus Theme](https://pegasus-frontend.org/tools/themes/), but I recommend two of my own that are adapted to all kinds of screens, 4:3 as seen on the Retroid Pocket 2 and 2+, 5:3 as the one in the RG552 or 16:9 like Ayn's Odin screen.

Just download them an unzip them in the themes folder

[RP Switch](https://github.com/dragoonDorise/RP-Switch/archive/main.zip)

[RP Epic Noir](https://github.com/dragoonDorise/RP-epic-noir/archive/main.zip)

## 7 Download your roms Artwork

Pegasus doenst download your Rom's assets so you need to scrape those yourself if you want your theme to look nice:

<img src="https://raw.githubusercontent.com/dragoonDorise/RP-Switch/main/screenshots/hero.jpg">

If your roms come from a no intro set you can download the box art, screenshots and logo of every game by downloading this links, just unzip any of them inside every system folder so it looks like this on your sdcard:

snes/media/

**Links per system:**

- [ArtBox]https://mega.nz/folder/ojQWAbqD#SXumVOa9BlQcv6KCd478Zg

**Links per system:**

- Atari 2600 - Pending
- Doom - Pending
- GameBoy
- GameBoy Color
- GameBoy Advance
- Dreamcast
- Dos - Pending
- Final Burn Alpha - Pending
- Final Burn Neo - Pending
- Mame - Pending
- Master System
- Neo Geo - Pending
- Neo Geo CD - Pending
- Neo Geo Pocket & Color - Pending
- Nintendo DS - Pending
- Nintendo NES
- Nintendo 64
- Nintendo Gamecube
- PC engine
- Playstation
- Pokemon Mini - Pending
- PSP - Pending
- ScummVM - Pending
- Sega 32X
- Sega CD
- Sega Game Gear
- Sega Genesis / Mega Drive
- Sega Saturn
- Super Nintendo
- Wonderswan & Color - Pending

Keep in mind these are complete romset's artwork so they take a lot of space, several GB in total

As soon as you have copied the media folders to your SD card you are good to go, put your SD Card back into your handheld, **open Pegasus and start playing!**

If something does not work please open an [issue](https://github.com/dragoonDorise/pegasus-android-metadata/issues)

# Some Tips

There are some some tips that can help you manage your collection Better.

- Use CHD format
- Clean your Mame roms
- Scrape your own artwork

## Use CHD format

Stop using ISO format for CD systems, you can save tons of space using the CHD format.

1 Download [CHDMAN](https://archive.org/download/chdman/CHDMAN.zip)
And put it into your ISO rom folder

2 Create a convert.bat file in the very same folder and copy this code inside that create.bat file

    for /r %%i in (_.cue, _.gdi, \*.iso) do chdman createcd -i "%%i" -o "%%~ni.chd"

3 Execute create.bat, in some minutes/hours you'll see how your old ISO roms are now in CHD format and that they now take a lot less space.

## Clean up your Mame roms

Mame romsets are usually full of clones and roms that we don't want, follow this [guide](https://www.youtube.com/watch?v=GZfoOTckURA) to fix that.

## Scrape your own artwork

It's always better to scrap your own artwork, it will be lighter [Skraper](http://skraper.net), for that you need to register yourself in [Screen Scrapper](https://www.screenscraper.fr/membreinscription.php)

**Note to Mac users**

Skraper is not available for Mac as of yet, I promise I will try to update this guide ASAP with alternatives for you guys.

I assume you have installed the application with no problem, after several minutes a wizard will appear:

In there complete your screen scrapper login data, click in VALIDATE and click NEXT.

![Screenshot](https://raw.githubusercontent.com/dragoonDorise/pegasus-rp2-metadata/master/guide/13.png)

In the next screen choose "Generic Emulation" and click NEXT

Insert your SD card onto your computer, now chose the path to your sd card with all the systems in it.

You should see a screen like this:

![Screenshot](https://raw.githubusercontent.com/dragoonDorise/pegasus-rp2-metadata/master/guide/14.png)

Click NEXT until you see this screen:

![Screenshot](https://raw.githubusercontent.com/dragoonDorise/pegasus-rp2-metadata/master/guide/15.png)

Go to the Media tab, we're going to tell Skrapper what images we need. Hit the - button until there is nothing selected

![Screenshot](https://raw.githubusercontent.com/dragoonDorise/pegasus-rp2-metadata/master/guide/16.png)

Click on the + button, then in media type click the left arrow until we get "Image - Screenshot"

Then mark "Resize width", put _640px_ in the input box an also check "mantain aspect ratio"

![Screenshot](https://raw.githubusercontent.com/dragoonDorise/pegasus-rp2-metadata/master/guide/17.png)

Click once more in the + button and repeat but now we need media type : "Image - Logo" depending of your computer language this could be called "Image - Wheel", then again mark "Resize width", put _640px_ in the input box an also check "mantain aspect ratio". Do the same with "Image - Box 2D"

![Screenshot](https://raw.githubusercontent.com/dragoonDorise/pegasus-rp2-metadata/master/guide/18.png)

Hit the play button and wait, depending of the number of roms this could take from minutes from hours.

When it's finished you will have a media folder inside of every of your rom systems. Just put your SD card back and you are good to go.

Example: The path the media folder in your SD Card for Super Nintendo should be:

    /snes/media
