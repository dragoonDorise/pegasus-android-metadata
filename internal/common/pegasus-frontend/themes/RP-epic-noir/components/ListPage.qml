import QtQuick 2.12


  Item{
    id: listpage     
    property var itemWidth : 600/itemsRow
    property var itemHeight : itemWidth
    Keys.onPressed: {
      //Back to Home            
      if (api.keys.isCancel(event)) {
          event.accepted = true;
          // gameView.model = currentCollection.games
          // gameViewStyle = 'standard'
          searchValue=''
          // header__search_input.focus = false
          // gameView.focus = true 
         // header.height=0 
         // header_list__search_input.text='Search...'
          navigate('HomePage');
          return;
      }  
      
    }
 
    HeaderList{
      id: header_list
    }
       
    Rectangle {
        id: main
        //color: mainCSS.background
        color: "transparent"
        width: wrapperCSS.width
        height: mainCSS.height-104
        anchors.top: parent.top
        anchors.topMargin: headerCSS.height+60
        Rectangle {
            id: games
            color: "transparent"
            width: parent.width*0.45
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 20
            height:parent.height-anchors.topMargin-footer.height
            ListView {
                id: gameView
                width: parent.width;
                height: parent.height
                model: currentCollection.games
                delegate: gameViewDelegate
                clip:true
                anchors.left: parent.left
                anchors.leftMargin: 22
                anchors.top: parent.top
                anchors.bottom: parent.bottom        
                focus: currentPage === 'ListPage' ? true : false ;
                
                snapMode: ListView.SnapOneItem
                // highlightRangeMode: ListView.StrictlyEnforceRange
                
                // Keys.onUpPressed:       { moveCurrentIndexUp();navSound.play(); }
                // Keys.onDownPressed:     { moveCurrentIndexDown();navSound.play(); }
                // Keys.onLeftPressed:     { moveCurrentIndexLeft();navSound.play(); }
                // Keys.onRightPressed:    { moveCurrentIndexRight();navSound.play(); }
                // cellWidth: itemWidth
                // cellHeight: itemHeight
                
                Component {
                    id: gameViewDelegate 

                    Item
                    {
                      height:aspectRatio === 43 ? 40 : 60                      
                      id: delegateContainer
                      property bool selected: delegateContainer.ListView.isCurrentItem
                      property var gameViewStyle : 'standard'
                      
                      Keys.onPressed: {
                        //Launch game
                        if (api.keys.isAccept(event)) {
                            event.accepted = true;
                            currentGameIndex = index
                            launchSound.play()
                            currentGame.launch();                            
                            return;
                        }  
                        
                        //toggleItemsRow     
                        if (api.keys.isFilters(event)) {
                            event.accepted = true;
                           
                            
                            if (header.height == 50){
                              header.height=0  
                            }else{
                               header.height=50
                               searchValue = ''
                               header__search_input.clear()            
                               header__search_input.focus = true
                               
                            }
                            
                            toggleSound.play()
                            //Show only current favs, not working right now...
                            // if ( gameViewStyle === 'standard'){
                            //   gameView.model = currentFavorites
                            //   gameViewStyle = 'favs'
                            //   return;
                            // }else{
                            //   gameView.model = currentCollection.games
                            //   gameViewStyle = 'standard'
                            // }
                            
                        }  
                        //Favorite
                        if (api.keys.isDetails(event)) {
                            event.accepted = true;
                            favSound.play()                            
                            currentGameIndex = index
                            currentGame.favorite = !currentGame.favorite
                            return;
                        }                        
                        //Next collection
                        if (api.keys.isNextPage(event)) {
                            event.accepted = true;
                            goBackSound.play()
                            currentCollectionIndex = currentCollectionIndex+1                           
                            return;
                        }  
                        
                        //Prev collection
                        if (api.keys.isPrevPage(event)) {
                            event.accepted = true;
                            goBackSound.play()
                            currentCollectionIndex = currentCollectionIndex-1
                            return;
                        }  
                        
                        //Search
                        if (api.keys.isPageDown(event)) {
                            event.accepted = true;
                            goBackSound.play()
                            searchValue = ''
                            header__search_input.clear()            
                            header__search_input.focus = true
                            
                            return;
                        }  
                        
                        
                                    
                      }                          
                    
                      Rectangle{
                        color:"transparent"
                        height: parent.height
                        width:parent.width
                        
                          Rectangle{
                              id: game_selected
                              width:games.width
                              height: delegateContainer.height
                              anchors.top: parent.top
                              
                              color:"#272c35"
                              visible: selected ? true : false                          
                          }     
                          
                          Text {
                            id: game_title_selected
                            text: modelData.title     
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            color: "white"
                           
                            font.family: bodyFont.name
                            font.pixelSize: delegateContainer.height/2
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                            visible: selected ? true : false 
                            z:2
                          }                                     
                          
                          Text {
                            id: game_title
                              text: modelData.title                
                              anchors.left: parent.left
                              anchors.leftMargin: 12
                              color: "#434643"
                              font.family: bodyFont.name
                              font.pixelSize: delegateContainer.height/2
                              verticalAlignment: Text.AlignVCenter
                              elide: Text.ElideRight
                              
                              Image {              
                                  width: 10
                                  fillMode: Image.PreserveAspectFit
                                  source: "../assets/icons/heart_solid.svg"
                                  asynchronous: true     
                                  visible: modelData.favorite && currentCollection.shortName !== "all-favorites" 
                                  anchors {
                                      left: parent.right; 
                                      top: parent.top;
                                  }
                                  anchors.topMargin: 4
                                  anchors.leftMargin: 4
                              }    
                              
                          }                          
                                             
                      }
                      
                    }      
                    
                             
                }
                                
            }
        
           
        }
        
        Rectangle{
          id:game_details
          width: parent.width*0.5
          height:parent.height-footer.height
          color:"transparent"
          anchors.right:parent.right
          anchors.top: parent.top
          //anchors.bottom: parent.bottom

          Image {
              id: game_screenshot
              width: parent.width    
              height:currentCollection.games.get(gameView.currentIndex).description ? parent.height*0.6 :  parent.height
              fillMode: Image.PreserveAspectFit
              anchors.top:parent.top
              anchors.right: parent.right
              anchors.topMargin: 0
              anchors.rightMargin: 20          

              asynchronous: true    
              source: {
                  if (currentCollection.shortName !== "android") {
                      if (currentCollection.games.get(gameView.currentIndex).assets.boxFront) {
                          return currentCollection.games.get(gameView.currentIndex).assets.boxFront
                      }
                      return ""
                  }
                  return ""
              }                                                               
          }      
          
          Rectangle{
            id:game__texts
            //width: parent.width;
            height:parent.height*0.38
            color:"transparent"
            anchors.top: game_screenshot.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin:10
            anchors.rightMargin:10  
            clip: true
            
            Text{
              id:game__title_desc
              anchors.top: game_screenshot.bottom
              text:'Description'
              color: "white"
              font.family: bodyFont.name
              font.pixelSize: 20
              verticalAlignment: Text.AlignVCenter
              elide: Text.ElideRight
              visible: currentCollection.games.get(gameView.currentIndex).description ? true : false
            }  
            
            Rectangle{
              id: game__title_desc_border
              anchors.top: game__title_desc.bottom
              anchors.topMargin:10
              width: parent.width;
              height:1
              color: "#646363"
              opacity:0.4
              visible: currentCollection.games.get(gameView.currentIndex).description ? true : false
            }        
                      
            Text{
              id:game__desc
              anchors.top: game__title_desc_border.bottom
              anchors.left: parent.left
              anchors.right: parent.right
              anchors.topMargin:10
              visible: currentCollection.games.get(gameView.currentIndex).description ? true : false
              
              //height:parent.height
              
              text:currentCollection.games.get(gameView.currentIndex).description
              color: "#646363"
              font.family: bodyFont.name
              font.pixelSize: 16
              wrapMode:Text.WordWrap
             // verticalAlignment: Text.AlignVCenter
              //elide: Text.ElideRight
            }  
            
            
          }
          
                    
       //   Rectangle{
       //     id:pepito
       //     width: parent.width;
       //     height:100
       //     color:"purple"
       //     anchors.top: game_screenshot.bottom
       //     
       //   }
       //   
       //   Text{
       //     id:game__title_desc
       //     anchors.top: game_screenshot.bottom
       //     text:'Description'
       //     color: "white"
       //     font.family: bodyFont.name
       //     font.pixelSize: 20
       //     verticalAlignment: Text.AlignVCenter
       //     elide: Text.ElideRight
       //   }  
       //   
       //   Rectangle{
       //     id: game__title_desc_border
       //     anchors.top: game__title_desc.bottom
       //     anchors.topMargin:10
       //     width: parent.width;
       //     height:1
       //     color: "#646363"
       //     opacity:0.4
       //   }        
       //             
       //   Text{
       //     id:game__desc
       //     anchors.top: game__title_desc_border.bottom
       //     anchors.topMargin:10
       //     width: parent.width-100;
       //     text:currentCollection.games.get(gameView.currentIndex).description
       //     color: "#646363"
       //     font.family: bodyFont.name
       //     font.pixelSize: 16
       //     verticalAlignment: Text.AlignVCenter
       //     elide: Text.ElideRight
       //   }  
          
          
          
          
        }
        
    }  
    
     Footer{
      id: footer
    }   

}