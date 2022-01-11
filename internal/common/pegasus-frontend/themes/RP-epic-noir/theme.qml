import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtMultimedia 5.9
import SortFilterProxyModel 0.2

import 'components' as Components

FocusScope {
    id: root  

  //
  //
  //Variables, functions
  //
  //  
  
  Component.onCompleted: homeMusic()
  
  //System index
  property var currentCollectionIndex : 0
  property var currentCollection: allCollections[currentCollectionIndex]
  
  //Games index
  property var currentGameIndex: 0

  property var currentGame: {
      if (currentCollection.shortName === "all-favorites")
          return api.allGames.get(allFavorites.mapToSource(currentGameIndex))
      if (currentCollection.shortName === "all-lastplayed")
          return api.allGames.get(allLastPlayed.mapToSource(currentGameIndex))
      if (searchValue !== '')
          return  currentCollection.games.get(searchGames.mapToSource(currentGameIndex))   
      return currentCollection.games.get(currentGameIndex)
  }
      
  property var allCollections: {
      let collections = api.collections.toVarArray()
      collections.unshift({"name": "All Games", "shortName": "all-allgames", "games": api.allGames})      
      collections.unshift({"name": "Last Played", "shortName": "all-lastplayed", "games": filterLastPlayed})
      collections.unshift({"name": "Favorites", "shortName": "all-favorites", "games": allFavorites})
      return collections
  }  
  
  FontLoader { id: titleFont; source: "assets/fonts/BebasNeue.otf" }
  FontLoader { id: bodyFont; source: "assets/fonts/Acre.otf" }
  property var currentPage : 'HomePage';
  
  property var themeLight : {
      "background": "#000",
      "accent": "#10adc5",
      "buttons": "white",
      "text":"#fff",
      "footer_icon":"rp2.png",
      "system_icon":"allsoft_icon.svg",
      "title":"#444"
  } 
  
  property var themeDark : {
    "background": "#000",
    "accent": "#10adc5",
    "buttons": "#4a4a4a",
    "text":"#fff",
    "footer_icon":"rp2_dark.png",
    "system_icon":"allsoft_icon_dark.svg",    
    "title":"white"    
  }
    
  property var systemDescription:{
    "all-allgames": "Access and quickly play every single game across the entire library",
    "all-favorites": "Access and quickly play your favorite games across the entire library",  
    "all-lastplayed": "Access and quickly play your favorite games across the entire library",  
    "atari2600": "The Atari 2600 is credited with popularizing the use of microprocessor-based hardware and ROM cartridges containing game code",
    "atasrilynx":"The Lynx was the world's first handheld electronic game with a color LCD and was also notable for its advanced graphics and ambidextrous layout",
    "doom": "Doom is a 1993 first-person shooter (FPS) game developed by id Software for MS-DOS. Players assume the role of a space marine, popularly known as Doomguy",
    "dos": "MS-DOS is an operating system for x86-based personal computers mostly developed by Microsoft",
    "dreamcast": "The Dreamcast was Sega's final home console, marking the end of the company's 18 years in the console market",
    "fba":"Coin-operated entertainment machines. The golden age is defined as a period between the late 1970s and ending in the mid-1980s",
    "fbn": "Coin-operated entertainment machines. The golden age is defined as a period between the late 1970s and ending in the mid-1980s",
    "gc": "The Nintendo GameCube is the successor to the Nintendo 64 and is the first Nintendo console to use optical discs as its primary storage medium",
    "gamegear": "The Game Gear shares much of its hardware with the Master System and is able to play its own titles as well as those of the Master System",
    "gb": "Nintendo's second handheld system following the Game & Watch series. It mainly competed with Game Gear and Lynx",
    "gba": "Successor to the Game Boy Color. Market competitors at the time were the Neo Geo Pocket Color, Wonder Swan, GP32 and the N-Gage",
    "gbc": "The Game Boy Color features a color screen. It is slightly thicker and taller and features a slightly smaller screen then the Game Boy Pocket",
    "genesis": "Sega's third console and the successor to the Master System. First released as the Mega Drive in Japan",
    "mame": "Coin-operated entertainment machines. The golden age is defined as a period between the late 1970s and ending in the mid-1980s",
    "mastersystem": "Succeeding the SG-1000, the Master System was released as a direct competitor to the Nintendo Entertainment System (NES)",
    "n64": "The N64 was the last major home console to use the cartridge as its primary storage format until Nintendo's seventh console, the Nintendo Switch",
    "nds": "The Nintendo DS is a dual-screen handheld game console developed and released by Nintendo that featured two LCD screens working in tandem",
    "neogeo": "Originally launched as the MVS coin-operated arcade machine. It was ranked 19th out of 25 best video game consoles of all time",
    "neogeocd": "Originally launched as the MVS coin-operated arcade machine. It was ranked 19th out of 25 best video game consoles of all time",
    "nes": "The best selling gaming console of its time, the NES helped revitalize the US video game industry following the video game crash of 1983",
    "ngp":"Monochrome handheld game console released by SNK. It was the company's first handheld system and is part of the Neo Geo family",
    "ngpc": "The Neo Geo Pocket Color is the successor to SNK's monochrome Neo Geo Pocket, with the Color being fully backward compatible",
    "pcengine": "Originally intended to compete with the NES, it ended up competing with the Sega Genesis, and later on the Super Nintendo",
    "pokemon_mini": "xxxx",
    "psp": "Sony's first handheld, it was also the first real competition to Nintendo handhelds since the Game Gear",
    "psx": "The Sony PlayStation primarily competed with the Nintendo 64 and the Sega Saturn as part of the fifth generation of video game consoles",
    "ps2": "The PlayStation 2 is the best-selling video game console of all time, selling over 155 million units.",    
    "saturn": "Fifth generation home video game console developed by Sega and successor to the successful Sega Genesis",
    "scummvm": "Play the classic Point and Click graphic adventure games from different platforms and systems like MS-DOS, C64, Apple II or PC",
    "sega32x": "Designed to expand the power of the Megadrive and serve as a transitional console into the 32-bit era until the release of the Sega Saturn",
    "segacd": "CD-ROM add-on to the Megadrive, it launched many FMV games, including the infamous Night Trap, which led to the creation of the ESRB",
    "snes": "Nintendo's second home console introduced advanced graphics and sound capabilities compared with other systems at the time",
    "wii":"The Wii introduced the Wii Remote controller, which can be used as a handheld pointing device and detects movement in three dimensions",
    "wiiu":"Successor to the Wii and the first eighth-gen video game console, as it competed with Microsoft's Xbox One and Sony's PS4.",    
    "wonderswan": "Powered by a 16 bit central processing unit, it took advantage of a low price point and long battery life in comparison to its competition"
  }     
  
property var systemDetail:{
  "allgames": "All Consoles / Handhelds",
  "favorites": "All Consoles / Handhelds",
  "atari2600": "1977  ·  8-bit Console",
  "atasrilynx":"1989  ·  16-bit Handheld Console",
  "doom": "1983  ·  PC",
  "dos": "1980s  ·  PC",
  "dreamcast": "1998  ·  128-bit Console",
  "fba":"Coin Operated Cabinet",
  "fbn": "Coin Operated Cabinet",
  "gc": "2001  ·  128-bit Console",
  "gamegear": "1990  ·  8-bit Handheld Console",
  "gb": "1989  ·  8-bit Handheld Console",
  "gba": "2001  ·  32-bit Handheld Console",
  "gbc": "1998  ·  8-bit Handheld Console",
  "genesis": "1988  ·  16-bit Console",  
  "mame": "Coin Operated Cabinet",
  "mastersystem": "1985  ·  8-bit Console",
  "n64": "1996  ·  64-bit Console",
  "nds": "2004  ·  32-bit Handheld Console",
  "neogeo": "1990  ·  24-bit Console",
  "neogeocd": "1990  ·  24-bit Console",
  "nes": "1983  ·  8-bit Console",
  "ngp": "1998  ·  16-bit Handheld Console",  
  "ngpc": "1999  ·  16-bit Handheld Console",
  "pcengine": "1987  ·  16-bit Console",
  "pokemon_mini": "xxxx",
  "psp": "2004  ·  32-bit Handheld Console",
  "psx": "1994  ·  32-bit Console",
  "ps2": "2000  ·  128-bit Console",
  "saturn": "1994  ·  32-bit Console",
  "scummvm": "Cross Platform Computer",
  "sega32x": "1994  ·  32-bit Console",
  "segacd": "1991  ·  16-bit Console",
  "snes": "1990  ·  16-bit Console",
  "wii":"2006  ·  32-bit Console",  
  "wiiu":"2012  ·  Handheld Console",    
  "wonderswan": "1999  ·  16-bit Handheld Console"
}     
    
  property var theme : api.memory.get('theme') === 'themeLight' ? themeLight : themeDark ;
  
  property var searchValue: '';
  property var screenRatio: root.height < 481 ? 1.98 : 1.88;
  property var screenProportion: root.width / root.height;
  

  function calculateAspectRatio(screenProportion){
      if (screenProportion < 1.34){
        return 43;
      }
     // if (screenProportion < 1.666666666666668){
     //   return 53;
     // }
        return 169;    
  }
  property var aspectRatio : calculateAspectRatio(screenProportion)
  
// To do, typography calculator  
//function typography(heading){
// switch(heading){
//   case 'h1'
//     aspectRatio = 43 ? return 40 : return 40
//     break;
//   default:
//     return 169
//     break;
// }
//  
  
  
  
 //  : root.width / root.height < 1.34 ? 43 : 169
//
 // 4:3-> 1.333333333333333
 // 5:3-> 1.666666666666667
 // 16:9-> 1.777777777777778

  property var itemsNumber : aspectRatio === 43 ? 3 : 4
  
  //used by Zoom in game lists
  property var itemsRow : api.memory.get('itemsRow') ? api.memory.get('itemsRow') : itemsNumber ;
  
  //Used to hide or show the header
  property var headerHeightCorrection: api.memory.get('headerHeightCorrection') === headerCSS.height ? headerCSS.height : 0;
  property var wrapperCSS : {
      "width": parent.width,
      "height": parent.height,
      "background": theme.background,      
  }
  

  
  property var headerCSS : {
      "width": wrapperCSS.width,
      "height": 45,
      "background": "transparent",
  }
  
  property var mainCSS : {
      "width": wrapperCSS.width,
      "height": wrapperCSS.height,
      "background": "transparent",
      
  }     
  
  property var footerCSS : {
      "width": wrapperCSS.width,
      "height": 49*screenRatio,
      "background": "transparent",
      
  }    
  
  //Percentage calculator
  function vw(pixel){
    //in 100
    //out 1280
    switch (aspectRatio) {
        case 43:
        return vpx(pixel*12.8)
        break;
        case 169:
        return vpx(pixel*12.8)
        break;
        default:
        return vpx(pixel*12.8)
        break;
    }
  }
  
  function toggleDarkMode(){
    if(theme === themeLight){
      api.memory.set('theme', 'themeDark');
    }else{
      api.memory.set('theme', 'themeLight');
    }
  }
  
 
  function toggleZoom(){
    if(headerHeightCorrection === headerCSS.height){
      api.memory.set('headerHeightCorrection', 0);
      headerHeightCorrection = 0
      toggleSound.play()
    }else{
      api.memory.set('headerHeightCorrection', headerCSS.height);
      headerHeightCorrection = headerCSS.height
      toggleSound.play()
    }
  }
  
 
  function toggleItemsRow(){
    
      if(aspectRatio === 43){
            
        if ( api.memory.get('itemsRow') >= 5 ){
          api.memory.set('itemsRow', 3);
        }else{
          api.memory.set('itemsRow', itemsRow+1);
        }
      
      }else{
            
        if ( api.memory.get('itemsRow') >= 7 ){
          api.memory.set('itemsRow', 5);
        }else{
          api.memory.set('itemsRow', itemsRow+1);
        }
      
      
      }

  }  
  
  function navigate(page){
    currentPage = page
    
    goBackSound.play()
    /*pageNames    
    'HomePage'
    'ListPage'
    */
  }
  
  property var music :[
    "Silence",
    "Arcadia",
    "Diotic",
    "Dreamlines",
    "Nightwanderer",
    "Outlander",
    "Tapes",
    "Vice",  
    "Laundromat",
    "Pawnshop",
    "Playertwo",
    "VYBES",
    "Virtualfuture",
  ]

  
function changeMusic(){
  if (api.memory.get('musicArray') == undefined ){
    api.memory.set('musicArray',0);
  }
  stopMusic(music[api.memory.get('musicArray')])
  api.memory.set('musicArray',api.memory.get('musicArray')+1);
  if (api.memory.get('musicArray') == 12 ){
    api.memory.set('musicArray',0);
  }
  
  playMusic(music[api.memory.get('musicArray')])
}


function homeMusic(){
  api.memory.set('musicArray',8);
  playMusic(music[api.memory.get('musicArray')])
}
  
function playMusic(name){  
  switch(name){
    case "Arcadia":
      arcadiaMusic.play()
      break;
    case "Diotic":
      dioticMusic.play()
      break;
    case "Dreamlines":
      dreamlinesMusic.play()
      break;
    case "Nightwanderer":
      nightwandererMusic.play()
      break;
    case "Outlander":
      outlanderMusic.play()
      break;
    case "Tapes":
      tapesMusic.play()
      break;
    case "Vice":
      viceMusic.play()
      break;
    case "Laundromat":
      laundromatMusic.play()
      break;
    case "Pawnshop":
      pawnshopMusic.play()
      break;
    case "Playertwo":
      playertwoMusic.play()
      break;
    case "VYBES":
      vybesMusic.play()
      break;
    case "Virtualfuture":
      virtualfutureMusic.play()
      break;
    case "Silence":
      virtualfutureMusic.stop()
      break;
      
    default:
      laundromatMusic.play()      
      break;
  };
}  

// TODO Do this the right way, yikes!  
function stopMusic(name){  
  switch(name){
    case "Arcadia":
      arcadiaMusic.stop()
      break;
    case "Diotic":
      dioticMusic.stop()
      break;
    case "Dreamlines":
      dreamlinesMusic.stop()
      break;
    case "Nightwanderer":
      nightwandererMusic.stop()
      break;
    case "Outlander":
      outlanderMusic.stop()
      break;
    case "Tapes":
      tapesMusic.stop()
      break;
    case "Vice":
      viceMusic.stop()
      break;
    case "Laundromat":
      laundromatMusic.stop()
      break;
    case "Pawnshop":
      pawnshopMusic.stop()
      break;
    case "Playertwo":
      playertwoMusic.stop()
      break;
    case "VYBES":
      vybesMusic.stop()
      break;
    case "Virtualfuture":
      virtualfutureMusic.stop()
      break;
    case "Silence":
      virtualfutureMusic.stop()
      break;
      
    default:
      laundromatMusic.stop()      
      break;
  };
}  
  
  //Music  

  Audio {
    id: arcadiaMusic
    source: "assets/music/Alumo - Arcadia Sunset.mp3"
    volume: 0.2
  }   
    
  Audio {
    id: dioticMusic
    source: "assets/music/Alumo - Diotic.mp3"
    volume: 0.2
  }
  Audio {
    id: dreamlinesMusic
    source: "assets/music/Alumo - Dreamlines.mp3"
    volume: 0.2
  }
  Audio {
    id: nightwandererMusic
    source: "assets/music/Alumo - Night Wanderer.mp3"
    volume: 0.2
  }
  Audio {
    id: outlanderMusic
    source: "assets/music/Alumo - Outlander.mp3"
    volume: 0.2
  }
  Audio {
    id: tapesMusic
    source: "assets/music/Alumo - Tapes.mp3"
    volume: 0.2
  }
  Audio {
    id: viceMusic
    source: "assets/music/Alumo - Vice.mp3"
    volume: 0.2
  }
  Audio {
    id: laundromatMusic
    source: "assets/music/Bolt Action - Laundromat.mp3"
    volume: 0.2
  }
  Audio {
    id: pawnshopMusic
    source: "assets/music/Bolt Action - Pawn Shop.mp3"
    volume: 0.2
  }
  Audio {
    id: playertwoMusic
    source: "assets/music/Bolt Action - Player Two.mp3"
    volume: 0.2
  }
  Audio {
    id: vybesMusic
    source: "assets/music/Bolt Action - v y b e s.mp3"
    volume: 0.2
  }
  Audio {
    id: virtualfutureMusic
    source: "assets/music/Bolt Action - Virtual Future.mp3"
    volume: 0.2
  }
    

  
  //Sounds
  SoundEffect {
    id: homeSound
    source: "assets/sound/Home.wav"
    volume: 1.0
  }   
  
  SoundEffect {
    id: navSound
    source: "assets/sound/Interface Click 1.wav"
    volume: 1.0
  }   
  
  
  SoundEffect {
    id: toggleSound
    source: "assets/sound/Interface Click 1.wav"
    volume: 1.0
  }   
    
  SoundEffect {
    id: goBackSound
    source: "assets/sound/EnterBack.wav"
    volume: 1.0
  }   
  SoundEffect {
    id: launchSound
    source: "assets/sound/PopupRunTitle.wav"
    volume: 1.0
  }       
  SoundEffect {
    id: settingsSound
    source: "assets/sound/Settings.wav"
    volume: 1.0
  }     

  SoundEffect {
    id: favSound
    source: "assets/sound/Border.wav"
    volume: 0.1
  }     
    
    property int maximumPlayedGames: {
        if (allLastPlayed.count >= 17) {
            return 17
        }
        return allLastPlayed.count
    }

    SortFilterProxyModel {
        id: allFavorites
        sourceModel: api.allGames
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    SortFilterProxyModel {
        id: allLastPlayed
        sourceModel: api.allGames
        filters: ValueFilter { roleName: "lastPlayed"; value: ""; inverted: true; }
        sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder }
    }

    SortFilterProxyModel {
        id: filterLastPlayed
        sourceModel: allLastPlayed
        filters: IndexFilter { maximumIndex: maximumPlayedGames }
    }

    SortFilterProxyModel {
        id: currentFavorites
        sourceModel: currentCollection.games
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }
                            
    
    SortFilterProxyModel {
    id: searchGames

        sourceModel: currentCollection.games
        filters: [            
             RegExpFilter { roleName: "title"; pattern: searchValue; caseSensitivity: Qt.CaseInsensitive; enabled: searchValue != "" }                       
        ]
        // sorters: [
        //     RoleSorter { roleName: sortByFilter[sortByIndex]; sortOrder: orderBy }
        // ]
    }    
  
  
  //
  //
  //Actual UI
  //
  //
  


  //RP2 screen Boundaries, use it to trace a design
  Rectangle {
      id: wrapper
      color: wrapperCSS.background
      width: wrapperCSS.width
      height: wrapperCSS.height
      anchors.top: parent.top
        // Image {
        //     id: collectionLogo
        //     height: wrapperCSS.height        
        //     fillMode: Image.PreserveAspectFit
        //     source: "assets/bg.jpg"
        //     asynchronous: true        
        //     anchors.top: parent.top
        //     
        // }      
        
        // Rectangle{
        //     id: cropzone
        //     width: 640
        //     height: 480
        //     color: "transparent"
        //     border.color: "red"
        //     border.width: 1          
        // }
      

    
    
    Components.HomePage {
      //visible: currentPage === 'HomePage' ? 1 : 0 ;
      opacity: currentPage === 'HomePage' ? 1 : 0.3 ;
    }
    
    Components.ListPage {
      visible: currentPage === 'ListPage' ? 1 : 0 ;
    }  
  
  }   
  




}