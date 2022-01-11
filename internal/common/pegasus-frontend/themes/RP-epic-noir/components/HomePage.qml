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
        anchors.top: parent.top
        
        
        Rectangle{
          id:systems
          color:"black"
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          height: main.height
//          anchors.topMargin: headerHeightCorrection === 0 ? 0 : 24 ;
          
              ListView{
                id: systemsListView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: systems.top
                anchors.bottom: parent.bottom
                //model: api.collections
                model: allCollections
                delegate: systemsDelegate  
                orientation: ListView.Vertical

                
                focus: currentPage === 'HomePage' ? true : false ;
                highlightRangeMode: ListView.StrictlyEnforceRange
                //preferredHighlightBegin: 0
                //preferredHighlightEnd: vpx(1057)
                snapMode: ListView.SnapToItem
                highlightMoveDuration: 0
                highlightMoveVelocity: -1
                keyNavigationWraps: true     
              
                 Keys.onUpPressed: {  decrementCurrentIndex(); navSound.play(); } 
                 Keys.onDownPressed: {  incrementCurrentIndex(); navSound.play();  }
      
                  Component {
                      id: systemsDelegate
                   
                   
                      Item {
                          id: systems__item_container
                          width: parent.width
                          height: main.height
                          // anchors.top: parent.top
                          
                          Keys.onPressed: {
                            if (api.keys.isAccept(event)) {
                                event.accepted = true;
                                
                                //We update the collection we want to browse
                                currentCollectionIndex = systems__item_container.ListView.view.currentIndex
                                //We change Pages
                                navigate('ListPage');
                                
                                return;
                            }      
                            if (api.keys.isFilters(event)) {
                                event.accepted = true;
                                changeMusic();
                                return;
                            }  
                                    
                          }                          
                          
                    
                          Rectangle {
                              id: systems__item
                              width: parent.width
                              height: main.height                                 ;                             
                              anchors.top : parent.top
                              color:"transparent"   
  
                              Rectangle {
                                id: systems__item_left
                                color:"transparent"
                                height: main.height-50
                                width: aspectRatio === 169 ? parent.width/2.2 : parent.width
                                anchors.left : parent.left
                                anchors.leftMargin: vw(5);  
                                z:20
                                visible: currentPage === 'HomePage' ? 1 : 0 ;
                                Text {
                                    id: systems__item_detail
                                    text: systemDetail[modelData.shortName]
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.topMargin: 86;  
                                    color: "#646363"
                                    font.pixelSize: aspectRatio === 169 ? vpx(6*screenRatio) :  vpx(18*screenRatio) 
                                    font.family: bodyFont.name
                                    verticalAlignment: Text.AlignTop
                                    elide: Text.ElideRight
                                    width: aspectRatio === 169 ? systems.width/2 : systems.width
                                  //  height: vpx(270)
                                    opacity: systems__item_container.ListView.isCurrentItem ? 1 : 0
                                    visible : systemDetail[modelData.shortName] == undefined ? 0: 1
                                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                }
                                
                                 Text {
                                      id: systems__item_title
                                      text: modelData.name
                                      anchors.top: systems__item_detail.bottom
                                      anchors.left: parent.left          
                                      anchors.topMargin: aspectRatio === 169 ? 26 : 12;
                                      color: "#fff"
                                      font.pixelSize: vpx(70*screenRatio)
                                      font.bold: true
                                      font.family: titleFont.name
                                      verticalAlignment: Text.AlignTop
                                      elide: Text.ElideRight
                                      width: systems.width/2
                                    //  height: vpx(270)
                                      opacity: systems__item_container.ListView.isCurrentItem ? 1 : 0
                                   
                                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                  }
                                  
                                  Text {
                                      id: systems__item_available
                                      text: modelData.games.count+" Games available"
                                      color: "#8d3837"
                                      anchors.top: systems__item_title.bottom
                                      font.pixelSize: vpx(14*screenRatio)
                                      font.bold: true
                                      font.family: bodyFont.name
                                      verticalAlignment: Text.AlignVCenter
                                      elide: Text.ElideRight
                                      width: systems.width/2
                                      opacity: systems__item_container.ListView.isCurrentItem ? 1 : 0
                                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                      font.capitalization: Font.AllUppercase
                                  }
                                  
                                  Text {
                                      id: systems__item_description
                                      text: systemDescription[modelData.shortName]
                                      color: "#646363"
                                      anchors.top: systems__item_available.bottom
                                      font.pixelSize: vpx(9*screenRatio)
                                      font.bold: true
                                      font.family: bodyFont.name
                                      verticalAlignment: Text.AlignVCenter
                                      elide: Text.ElideRight
                                      width: systems.width/3
                                      opacity: systems__item_container.ListView.isCurrentItem ? 1 : 0
                                      wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                                      visible: aspectRatio === 169 ? true: false
                                  }

                                                          
                                 Image {
                                      id: systems__controller
                                      height: 10    
                                      //width: 10
                                      anchors.top: systems__item_description.bottom
                                      fillMode: Image.PreserveAspectFit
                                      source: "../assets/controllers/"+modelData.shortName+".png"
                                      asynchronous: true      
                                      anchors { bottom: parent.bottom }   
                                      z:3999
                                      
                                 }           
                              
                              }  
  
                                             
                               
                               
                               Image {
                                 id: systems__img_bg
                                 height: parent.height      
                             //    width: parent.width   
                                // anchors: parent.right   
                                 fillMode: Image.PreserveAspectFit
                                 source: "../assets/posters/"+modelData.shortName+".jpg"
                                 asynchronous: true      
                                 anchors { right : parent.right; top: parent.top }    
                                 
                               }                                                     
                               
                           //    Rectangle {
                           //      id: systems__item_img
                           //      height: main.height   
                           //      width: parent.width/1.4
                           //      color:"blue"
                           //      anchors.right: parent.right
                           //    
                           //    }
                               
  
                            // Rectangle{
                            //   id: systems__item_inner
                            //   anchors.top: systems__item.top
                            //   anchors.left: systems__item.left
                            //   anchors.topMargin: 4
                            //   anchors.leftMargin: 4
                            //   width: parent.width-8
                            //   height: parent.width-8
                            //   border.color: systems__item_container.ListView.isCurrentItem ? "white" : wrapperCSS.background
                            //   border.width: 4     
                            //   color:"red"    
                            //   
                            //  //Image {
                            //  //    id: systems__img_bg
                            //  //    height: parent.height      
                            //  //    width: parent.width      
                            //  //    fillMode: Image.PreserveAspectFit
                            //  //    source: "../assets/images/systems-bg/"+modelData.shortName+".jpg"
                            //  //    asynchronous: true                                       
                            //  //}                                                     
                            //                                                    
                            // }
                              
                                                                                  
                          }
                
                      }
                  }      
                  
                
              }
        }
  
  //
  //      Rectangle{
  //        id: options
  //        color:"transparent"
  //        anchors.left: parent.left
  //        anchors.right: parent.right
  //        anchors.top: systems.bottom
  //        opacity:0
  //        height: 120
  //        width: parent.width
  //        
  //        Rectangle{
  //          id: options_buttons
  //          anchors.verticalCenter: parent.verticalCenter
  //          anchors.horizontalCenter: parent.horizontalCenter
  //          height:58
  //          width: 280
  //          color: "transparent"
  //          
  //          
  //          // Fav icon
  //           Rectangle{
  //            id: options_buttons_fav
  //            width:58
  //            height:58
  //            color: theme.buttons
  //            radius:100
  //            anchors.left: parent.left
  //            border.color: focus ? theme.accent : theme.background
  //            border.width: 4     
  //            
  //            KeyNavigation.up: systemsListView    
  //            KeyNavigation.left: options_buttons_theme 
  //            KeyNavigation.right: options_buttons_played  
  //            
  //            Keys.onPressed: {
  //              if (api.keys.isAccept(event)) {
  //                //We update the collection we want to browse
  //                currentCollectionIndex = 0
  //                //We change Pages
  //                navigate('ListPage');
  //              }
  //            }
  //            
  //            Image {              
  //                width: 36
  //                fillMode: Image.PreserveAspectFit
  //                source: focus ? "../assets/icons/heart.svg" : "../assets/icons/heart.svg"
  //                asynchronous: true     
  //                   
  //                anchors.verticalCenter: parent.verticalCenter
  //                anchors.horizontalCenter: parent.horizontalCenter 
  //            }    
  //            Text {
  //                text: "Favorites"
  //                anchors.top: parent.bottom
  //                color: "#10adc5"
  //                font.pixelSize: 16
  //                font.family: titleFont.name
  //                height: 16
  //                width: 64
  //                verticalAlignment: Text.AlignVCenter
  //                horizontalAlignment: Text.AlignHCenter
  //                opacity: parent.focus ? 1 : 0
  //            }
  //         
  //
  //           }
  //
  //           // Played
  //           Rectangle{
  //            id: options_buttons_played
  //            width:58
  //            height:58
  //            color: theme.buttons
  //            radius:100
  //            anchors.left: options_buttons_fav.right
  //            anchors.leftMargin: 16
  //             
  //            border.color: focus ? theme.accent : theme.background
  //            border.width: 4     
  //            
  //            KeyNavigation.up: systemsListView    
  //            KeyNavigation.left: options_buttons_fav 
  //            KeyNavigation.right: options_buttons_all  
  //            
  //            Keys.onPressed: {
  //              if (api.keys.isAccept(event)) {
  //                //We update the collection we want to browse
  //                currentCollectionIndex = 1
  //                //We change Pages
  //                navigate('ListPage');
  //              }
  //            }
  //            
  //            Image {              
  //                width: 36
  //                fillMode: Image.PreserveAspectFit
  //                source: focus ? "../assets/icons/clock.svg" : "../assets/icons/clock.svg"
  //                asynchronous: true     
  //                   
  //                anchors.verticalCenter: parent.verticalCenter
  //                anchors.horizontalCenter: parent.horizontalCenter 
  //            }    
  //            Text {
  //                text: "Played"
  //                anchors.top: parent.bottom
  //                color: "#10adc5"
  //                font.pixelSize: 16
  //                font.family: titleFont.name
  //                height: 16
  //                width: 64
  //                verticalAlignment: Text.AlignVCenter
  //                horizontalAlignment: Text.AlignHCenter
  //                opacity: parent.focus ? 1 : 0
  //            }     
  //
  //           }
  //          
  //          // All icon
  //           Rectangle{
  //            id: options_buttons_all
  //            width:58
  //            height:58
  //            color: theme.buttons
  //            radius:100
  //            anchors.left: options_buttons_played.right
  //            anchors.leftMargin: 16
  //             
  //            border.color: focus ? theme.accent : theme.background
  //            border.width: 4     
  //            
  //            KeyNavigation.up: systemsListView    
  //            KeyNavigation.left: options_buttons_played 
  //            KeyNavigation.right: options_buttons_theme  
  //            
  //            Keys.onPressed: {
  //              if (api.keys.isAccept(event)) {
  //                //We update the collection we want to browse
  //                currentCollectionIndex = 2
  //                //We change Pages
  //                navigate('ListPage');
  //              }
  //            }
  //            
  //            Image {              
  //                width: 36
  //                fillMode: Image.PreserveAspectFit
  //                source: focus ? "../assets/icons/play-circle.svg" : "../assets/icons/play-circle.svg"
  //                asynchronous: true     
  //                   
  //                anchors.verticalCenter: parent.verticalCenter
  //                anchors.horizontalCenter: parent.horizontalCenter 
  //            }    
  //            Text {
  //                text: "All Games"
  //                anchors.top: parent.bottom
  //                color: "#10adc5"
  //                font.pixelSize: 16
  //                font.family: titleFont.name
  //                height: 16
  //                width: 64
  //                verticalAlignment: Text.AlignVCenter
  //                horizontalAlignment: Text.AlignHCenter
  //                opacity: parent.focus ? 1 : 0
  //            }     
  //
  //           }
  //          
  //          
  //          // Theme icon
  //           Rectangle{
  //            id: options_buttons_theme
  //            width:58
  //            height:58
  //            color:theme.buttons
  //            radius:100
  //            anchors.left: options_buttons_all.right
  //            anchors.leftMargin: 16
  //            border.color: focus ? theme.accent : theme.background
  //            border.width: 4             
  //            
  //            KeyNavigation.up: systemsListView    
  //            KeyNavigation.left: options_buttons_all   
  //            KeyNavigation.right: options_buttons_fav    
  //            
  //            Keys.onPressed: {
  //              if (api.keys.isAccept(event)) {
  //                  event.accepted = true;
  //                  settingsSound.play()
  //                  toggleDarkMode();
  //                  
  //                  return;
  //              }   
  //                         
  //            }
  //                        
  //            Image {              
  //                width: 36
  //                fillMode: Image.PreserveAspectFit
  //                source: focus ? "../assets/icons/moon.svg" : "../assets/icons/moon.svg"
  //                asynchronous: true        
  //                anchors.verticalCenter: parent.verticalCenter
  //                anchors.horizontalCenter: parent.horizontalCenter
  //            }      
  //            Text {
  //                text: "Theme"
  //                anchors.top: parent.bottom
  //                color: "#10adc5"
  //                font.pixelSize: 16
  //                font.family: titleFont.name
  //                height: 16
  //                width:64
  //                verticalAlignment: Text.AlignVCenter
  //                clip:true
  //                elide: Text.ElideRight
  //                horizontalAlignment: Text.AlignHCenter
  //                opacity: parent.focus ? 1 : 0
  //                
  //            }
  //            
  //           }
  //                   
  //                    
  //                   
  //          // Theme icon
  //           Rectangle{
  //            id: options_buttons_search
  //            width:58
  //            height:58
  //            color:theme.buttons
  //            radius:100
  //            anchors.left: options_buttons_theme.right
  //            anchors.leftMargin: 16
  //            border.color: focus ? theme.accent : theme.background
  //            border.width: 4             
  //            visible: false
  //            KeyNavigation.up: systemsListView    
  //            KeyNavigation.left: options_buttons_theme 
  //            KeyNavigation.right: options_buttons_fav    
  //           
  //            
  //            Image {              
  //                width: 30
  //                fillMode: Image.PreserveAspectFit
  //                source: focus ? "../assets/icons/search.svg" : "../assets/icons/search.svg"
  //                asynchronous: true        
  //                anchors.verticalCenter: parent.verticalCenter
  //                anchors.horizontalCenter: parent.horizontalCenter
  //            }      
  //            Text {
  //                text: "Search"
  //                anchors.top: parent.bottom
  //                color: "#10adc5"
  //                font.pixelSize: 16
  //                font.family: titleFont.name
  //                height: 16
  //                width:64
  //                verticalAlignment: Text.AlignVCenter
  //                clip:true
  //                elide: Text.ElideRight
  //                horizontalAlignment: Text.AlignHCenter
  //                opacity: parent.focus ? 1 : 0
  //                
  //            }
  //            
  //           }
  //           
  //        }
  //        
  //      } 
  //      
    }  
    
     Footer{
      id: footer
    }   

}