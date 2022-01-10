import QtQuick 2.12


  Item{
    id: homepage  
  
    HeaderHome{
      id: header
    }
    
    Rectangle {
        id: main
        color: mainCSS.background
        width: wrapperCSS.width
        height: mainCSS.height + headerHeightCorrection  // Zoom option
        anchors.top: header.bottom
        
        
        Rectangle{
          id:systems
          color:"transparent"
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          height: main.height-options.height-anchors.topMargin
          anchors.leftMargin: 64;
          anchors.topMargin: headerHeightCorrection === 0 ? 0 : 24 ;
          
              ListView{
                id: systemsListView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: systems.top
                anchors.bottom: parent.bottom
                model: api.collections
                delegate: systemsDelegate  
                orientation: ListView.Horizontal

                
                focus: currentPage === 'HomePage' ? true : false ;
                highlightRangeMode: ListView.StrictlyEnforceRange
                preferredHighlightBegin: 0
                preferredHighlightEnd: vpx(1057)
                snapMode: ListView.SnapToItem
                highlightMoveDuration: 300
                highlightMoveVelocity: -1
                keyNavigationWraps: true     
                
                 Keys.onLeftPressed: {  decrementCurrentIndex(); navSound.play(); } 
                 Keys.onRightPressed: {  incrementCurrentIndex(); navSound.play();  }
      
                  Component {
                      id: systemsDelegate
                   
                   
                      Item {
                          id: systems__item_container
                          width: systems.height-systems__item_title.height
                          height: systems.height-systems__item_title.height
                          // anchors.top: parent.top
                          
                          Keys.onPressed: {
                            if (api.keys.isAccept(event)) {
                                event.accepted = true;
                                
                                //We update the collection we want to browse
                                currentCollectionIndex = systems__item_container.ListView.view.currentIndex+3
                                //We change Pages
                                navigate('ListPage');
                                
                                return;
                            }      
                            if (api.keys.isFilters(event)) {
                                event.accepted = true;
                                toggleZoom();
                                return;
                            }  
                            // if (api.keys.isDetails(event)) {
                            //     event.accepted = true;
                            //     toggleZoom();
                            //     return;
                            // }  

                                    
                          }                          
                          
                          Text {
                              id: systems__item_title
                              text: modelData.name
                              anchors.top: parent.top
                              color: theme.accent
                              font.pixelSize: vpx(12*screenRatio)
                              font.bold: true
                              font.family: titleFont.name
                              height: vpx(20*screenRatio)
                              verticalAlignment: Text.AlignVCenter
                              elide: Text.ElideRight
                              width: systems.height-systems__item_title.height
                              opacity: systems__item_container.ListView.isCurrentItem ? 1 : 0
                          }
                          
                          Rectangle {
                              id: systems__item
                              width: parent.width
                              height: parent.height       
                              
                              anchors.top : systems__item_title.bottom
  
  
  
                              Rectangle{
                                id: systems__item_inner
                                anchors.top: systems__item.top
                                anchors.left: systems__item.left
                                anchors.topMargin: 4
                                anchors.leftMargin: 4
                                width: parent.width-8
                                height: parent.width-8
                                border.color: systems__item_container.ListView.isCurrentItem ? "white" : wrapperCSS.background
                                border.width: 4     
                                color:"transparent"    
                                
                                Image {
                                    id: systems__img_bg
                                    height: parent.height      
                                    width: parent.width      
                                    fillMode: Image.PreserveAspectFit
                                    source: "../assets/images/systems-bg/"+modelData.shortName+".jpg"
                                    asynchronous: true                                       
                                }                                                     
                                                                                 
                              }
                              
                              
                              Rectangle{
                                id: systems__item_border
                                width: parent.width
                                height: parent.height
                                border.color: systems__item_container.ListView.isCurrentItem ? "#10adc5" : wrapperCSS.background
                                border.width: 4     
                                color:"transparent"                                                     
                              }      
                                                                                  
                          }
                          
                          // DropShadow {
                          //     anchors.fill: systems__item
                          //     horizontalOffset: 3
                          //     verticalOffset: 3
                          //     radius: 8.0
                          //     samples: 17
                          //     color: "#80000000"
                          //     source: systems__item
                          // }                        
                
                      }
                  }      
                  
                
              }
        }
  
  
        Rectangle{
          id: options
          color:"transparent"
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: systems.bottom
          opacity:1
          height: 120
          width: parent.width
          
          Rectangle{
            id: options_buttons
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height:58
            width: 280
            color: "transparent"
            
            
            // Fav icon
             Rectangle{
              id: options_buttons_fav
              width:58
              height:58
              color: theme.buttons
              radius:100
              anchors.left: parent.left
              border.color: focus ? theme.accent : theme.background
              border.width: 4     
              
              KeyNavigation.up: systemsListView    
              KeyNavigation.left: options_buttons_theme 
              KeyNavigation.right: options_buttons_played  
              
              Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                  //We update the collection we want to browse
                  currentCollectionIndex = 0
                  //We change Pages
                  navigate('ListPage');
                }
              }
              
              Image {              
                  width: 36
                  fillMode: Image.PreserveAspectFit
                  source: focus ? "../assets/icons/heart.svg" : "../assets/icons/heart.svg"
                  asynchronous: true     
                     
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter 
              }    
              Text {
                  text: "Favorites"
                  anchors.top: parent.bottom
                  color: "#10adc5"
                  font.pixelSize: 16
                  font.family: titleFont.name
                  height: 16
                  width: 64
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter
                  opacity: parent.focus ? 1 : 0
              }
           
  
             }
  
             // Played
             Rectangle{
              id: options_buttons_played
              width:58
              height:58
              color: theme.buttons
              radius:100
              anchors.left: options_buttons_fav.right
              anchors.leftMargin: 16
               
              border.color: focus ? theme.accent : theme.background
              border.width: 4     
              
              KeyNavigation.up: systemsListView    
              KeyNavigation.left: options_buttons_fav 
              KeyNavigation.right: options_buttons_all  
              
              Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                  //We update the collection we want to browse
                  currentCollectionIndex = 1
                  //We change Pages
                  navigate('ListPage');
                }
              }
              
              Image {              
                  width: 36
                  fillMode: Image.PreserveAspectFit
                  source: focus ? "../assets/icons/clock.svg" : "../assets/icons/clock.svg"
                  asynchronous: true     
                     
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter 
              }    
              Text {
                  text: "Played"
                  anchors.top: parent.bottom
                  color: "#10adc5"
                  font.pixelSize: 16
                  font.family: titleFont.name
                  height: 16
                  width: 64
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter
                  opacity: parent.focus ? 1 : 0
              }     
  
             }
            
            // All icon
             Rectangle{
              id: options_buttons_all
              width:58
              height:58
              color: theme.buttons
              radius:100
              anchors.left: options_buttons_played.right
              anchors.leftMargin: 16
               
              border.color: focus ? theme.accent : theme.background
              border.width: 4     
              
              KeyNavigation.up: systemsListView    
              KeyNavigation.left: options_buttons_played 
              KeyNavigation.right: options_buttons_theme  
              
              Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                  //We update the collection we want to browse
                  currentCollectionIndex = 2
                  //We change Pages
                  navigate('ListPage');
                }
              }
              
              Image {              
                  width: 36
                  fillMode: Image.PreserveAspectFit
                  source: focus ? "../assets/icons/play-circle.svg" : "../assets/icons/play-circle.svg"
                  asynchronous: true     
                     
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter 
              }    
              Text {
                  text: "All Games"
                  anchors.top: parent.bottom
                  color: "#10adc5"
                  font.pixelSize: 16
                  font.family: titleFont.name
                  height: 16
                  width: 64
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter
                  opacity: parent.focus ? 1 : 0
              }     
  
             }
            
            
            // Theme icon
             Rectangle{
              id: options_buttons_theme
              width:58
              height:58
              color:theme.buttons
              radius:100
              anchors.left: options_buttons_all.right
              anchors.leftMargin: 16
              border.color: focus ? theme.accent : theme.background
              border.width: 4             
              
              KeyNavigation.up: systemsListView    
              KeyNavigation.left: options_buttons_all   
              KeyNavigation.right: options_buttons_fav    
              
              Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                    event.accepted = true;
                    settingsSound.play()
                    toggleDarkMode();
                    
                    return;
                }   
                           
              }
                          
              Image {              
                  width: 36
                  fillMode: Image.PreserveAspectFit
                  source: focus ? "../assets/icons/moon.svg" : "../assets/icons/moon.svg"
                  asynchronous: true        
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter
              }      
              Text {
                  text: "Theme"
                  anchors.top: parent.bottom
                  color: "#10adc5"
                  font.pixelSize: 16
                  font.family: titleFont.name
                  height: 16
                  width:64
                  verticalAlignment: Text.AlignVCenter
                  clip:true
                  elide: Text.ElideRight
                  horizontalAlignment: Text.AlignHCenter
                  opacity: parent.focus ? 1 : 0
                  
              }
              
             }
                     
                      
                     
            // Theme icon
             Rectangle{
              id: options_buttons_search
              width:58
              height:58
              color:theme.buttons
              radius:100
              anchors.left: options_buttons_theme.right
              anchors.leftMargin: 16
              border.color: focus ? theme.accent : theme.background
              border.width: 4             
              visible: false
              KeyNavigation.up: systemsListView    
              KeyNavigation.left: options_buttons_theme 
              KeyNavigation.right: options_buttons_fav    
             
              
              Image {              
                  width: 30
                  fillMode: Image.PreserveAspectFit
                  source: focus ? "../assets/icons/search.svg" : "../assets/icons/search.svg"
                  asynchronous: true        
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter
              }      
              Text {
                  text: "Search"
                  anchors.top: parent.bottom
                  color: "#10adc5"
                  font.pixelSize: 16
                  font.family: titleFont.name
                  height: 16
                  width:64
                  verticalAlignment: Text.AlignVCenter
                  clip:true
                  elide: Text.ElideRight
                  horizontalAlignment: Text.AlignHCenter
                  opacity: parent.focus ? 1 : 0
                  
              }
              
             }
             
          }
          
        } 
        
    }  
    
     Footer{
      id: footer
    }   

}