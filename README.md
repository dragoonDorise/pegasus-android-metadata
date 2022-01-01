# Android - Pegasus metadata pack

This guide will help you make it as easy as possible to use your Android Handheld with the Pegasus Frontend, in my opinion it's one of the best Frontend Emulators out there.

The bad thing about Pegasus is that you need to do a lot of tinkering and configuration, This pack tries to make the experience as plug & play as possible so you don't have to tinker with config files.

Table of contents:

- **Pegasus Metadata to launch the emulators**
- **RPSwitch Pegasus Theme**
- **Retroarch configuration**
- **Installing this pack**
- **Some Tips**

## Pegasus Metadata

This pack offers support for the following systems with their respective emulators, you might need to download them separately from the Google Play Store or within Retroarch when a core is used for that system.

| System                    | Emulator                             |
| ------------------------- | ------------------------------------ |
| Atari 2600                | Retroarch 1.9 stella core            |
| Doom                      | Retroarch 1.9 PrBoom core            |
| GameBoy                   | Retroarch 1.9 Gambatte core          |
| GameBoy Color             | Retroarch 1.9 Gambatte core          |
| GameBoy Advance           | Retroarch 1.5 mGBA core              |
| Dreamcast                 | Reddream                             |
| Dos                       | Retroarch 1.9 DOSBox core            |
| Final Burn Alpha          | Retroarch 1.9 fba 2020 core          |
| Final Burn Neo            | Retroarch 1.9 fbn core               |
| Mame 2010 ( 0.139 )       | Retroarch 1.9 Mame 2010 core         |
| Master System             | Retroarch 1.9 Genesis Plus GX core   |
| Neo Geo                   | Retroarch 1.9 fba 2020 Neo Geo core  |
| Neo Geo CD                | Retroarch 1.9 fbn core               |
| Neo Geo Pocket & Color    | Retroarch 1.9 Beetle NeoPop          |
| Nintendo DS               | Drastic                              |
| Nintendo NES              | Retroarch 1.9 Nestopia core          |
| Nintendo 64               | Mupen64plus FZ                       |
| Nintendo Gamecube         | Mupen64plus FZ                       |
| PC engine                 | Retroarch 1.9 mednafen pce fast core |
| Playstation               | Retroarch 1.9 PCSX Rearmed core      |
| Pokemon Mini              | Retroarch 1.9 PokeMini core          |
| PSP                       | PPSSPP                               |
| ScummVM                   | Retroarch 1.9 scummvm core           |
| Sega 32X                  | Retroarch 1.9 Genesis Plus GX core   |
| Sega CD                   | Retroarch 1.9 Genesis Plus GX core   |
| Sega Game Gear            | Retroarch 1.9 Genesis Plus GX core   |
| Sega Genesis / Mega Drive | Retroarch 1.9 Genesis Plus GX core   |
| Sega Saturn               | Yaba Sanshiro 2 Pro                  |
| Super Nintendo            | Retroarch 1.9 Snes9x Current core    |
| Wonderswan & Color        | Retroarch 1.9 Beetle Cygne core      |

Keep in mind not all Android Systems are powerful enough to run all those systems. You can check your device compatibility in these Community maintained guides:

[RG552 Compatibility List](https://tinyurl.com/RG552GameSettings)

[Retroid Pocket 2+ Compatibility List](https://tinyurl.com/RP2PlusGameSettings)

## RPSwitch Pegasus Theme

<img src="https://raw.githubusercontent.com/dragoonDorise/RP-Switch/main/screenshots/RG552.jpg">

You can install any [Pegasus Theme](https://pegasus-frontend.org/tools/themes/), but I'm providing one of my own that is adapted to all kinds of screens, 4:3 as seen on the Retroid Pocket 2 and 2+, 5:3 as the one in the RG552 or 16:9 like Ayn's Odin screen.

## Retroarch configuration

We're also including a Retroarch configuration preset that will do the following:

- Set the global aspect ratio to Core Provided
- Set the right aspect ratio (1:1) for Handhelds & Mame Systems
- Set the right aspect ratio (4:3 )for SNES and NES
- Install LCD3 Shader for all Handhelds
- Hide the load content splash screen
- AutoSave and AutoLoad State
- Activate Integer Scale for all systems

This configuration is based on [RGC RG552 Linux Setup](https://retrogamecorps.com/2021/12/27/anbernic-rg552-linux-setup-guide/)

# Installing this pack

Just follow the steps, it should be pretty straightforward if you are finding any trouble just open an [issue](https://github.com/dragoonDorise/pegasus-android-metadata/issues)

## 1 - Enable APK installation

First you'll need to enable installing APK packages, which can be done in your Android device on Settings → Security → Unknown Sources, turned on. You need this to install Pegasus, since it's not available on the Google App Store

## 2 - Download Pegasus

On your handheld browser go to [Pegasus website](https://pegasus-frontend.org/#downloads) and install Pegasus.

## 3 - Download the latest Pegasus Frontend metadata Pack

Just click here: [Pegasus Frontend Android Metadata ](https://github.com/dragoonDorise/pegasus-android-metadata/archive/main.zip)

Unzip it in your computer, insert your SD Card in your computer and just copy the contents of the pegasus-android-metadata-main folder, **don't copy the folder itself, only the content**. This will create several folders for each system and a **-internal** folder with the configuration for Pegasus and Retroarch.

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

For some systems need to copy some extra files because you need extra configuration, just look for your systems name folder and do the same, copy its contents in your Android internal storage.

Example, If you have an Anbernic RG552 you'll need to Copy the contents of the common folder and then copy the contents of the rg552 folder. **Always copy the common folder first**

Once this is done you can delete this folder if you want.

## 6 Download your roms Artwork

Pegasus doenst download your Rom's assets so you need to scrape those yourself if you want your theme to look nice:

<img src="https://raw.githubusercontent.com/dragoonDorise/RP-Switch/main/screenshots/hero.jpg">

If your roms come from a no intro set you can download the box art, screenshots and logo of every game by downloading this links, just unzip any of them inside every system folder so it looks like this on your sdcard:

snes/media/

**Links per system:**

- Atari 2600
- Doom
- [GameBoy](https://mega.nz/folder/lu5yBQgA#CoxWGGlI9aJy1d76Icqq2Q)
- [GameBoy Color](https://mega.nz/folder/MvgClKRL#wH69iDldpRuRbE_66j5ADw)
- [GameBoy Advance](https://mega.nz/folder/pzog0S7D#EzpGG2ZU99cKpQWMyRS_-Q)
- [Dreamcast](https://mega.nz/folder/xyoQDCAJ#IvglynI91mkk4L8W1duUMg)
- Dos
- Final Burn Alpha
- Final Burn Neo
- Mame
- [Master System](https://mega.nz/folder/g3pi3STT#cad7sYucdYs8TvZriCe4zQ)
- Neo Geo
- Neo Geo CD
- Neo Geo Pocket & Color
- Nintendo DS
- [Nintendo NES](https://mega.nz/folder/UrhUhQgZ#A_e08Z3C7XyXsUaR3O1PPA)
- [Nintendo 64](https://mega.nz/folder/ArwAgAqI#WSilmJUAbhFwiu-FzBA-zQ)
- [Nintendo Gamecube](https://mega.nz/folder/BzpUxQba#LMDJxYcsv_6UrFVBjxd6Ag)
- [PC engine](https://mega.nz/folder/Q2oCzCwb#O91-oYm2hAHhxgcYZarmig)
- [Playstation](https://mega.nz/folder/Avo2Ua7I#REu3geE9nd8c_2l1T7wMOQ)
- Pokemon Mini
- PSP
- ScummVM
- [Sega 32X](https://mega.nz/folder/huxAVI6a#Rqzg5_l9gQ7EjrFOmPL6Bw)
- [Sega CD](https://mega.nz/folder/xmwwCQKY#uwgApwaIu0jRH-VN1usaww)
- [Sega Game Gear](https://mega.nz/folder/knh2VA7C#FL-9hTBdbE94bW1cX9lmGA)
- [Sega Genesis / Mega Drive](https://mega.nz/folder/QqwEGQ4D#uLr5te_sITGdWzbxgetTBw)
- [Sega Saturn](https://mega.nz/folder/wioi0CBS#qYILme10DkLSp1o-5cNGuA)
- [Super Nintendo](https://mega.nz/folder/py401SCI#5Gm6js7zz8yzvAqYW6vkaw)
- Wonderswan & Color

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
