import QtQuick 2.12

  Rectangle {
        id: header
        color: "transparent"
        width: headerCSS.width
        height: headerCSS.height
        anchors.top: parent.top
        // visible:false
        clip:true
        
        Rectangle{
          id: header_inner
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.topMargin: 18
          anchors.leftMargin: 30          
          color:"transparent"
          width:parent.width-66
          height: 40
          
          Rectangle{
            id: header__system
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 0
            width:  40
            height: 40  
            color:"transparent"          
            Image {
                id: header__system_logo
                width:parent.width
                height: parent.width
                fillMode: Image.PreserveAspectFit
                //source: "../assets/images/systems/" + currentCollection.shortName + ".png"
                source: "../assets/images/"+theme.system_icon
                asynchronous: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            
            
            Text{
              text: currentCollection.name
              anchors.left: header__system_logo.right
              anchors.leftMargin: 12
              color: theme.title
              font.pixelSize: 22
              anchors.verticalCenter: parent.verticalCenter
              width:300       
              elide: Text.ElideRight       
            }
          }    
          
          Rectangle{
            id: header__filters
            color:"transparent"
            anchors.top: parent.top
            anchors.right: parent.right
            height: 32
            width:300
            
            Rectangle{
              id: header__search
              color:"white";
              anchors.top: parent.top
              anchors.right: parent.right
              width:200
              height: 30 
              anchors.verticalCenter: parent.verticalCenter                
              border.color: theme.text
              border.width:1
              radius:2
              visible:true
              
                Rectangle{
                    height:20
                    width:20
                    color:"#444"
                    radius:20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right 
                    anchors.rightMargin: 6 
                    visible: currentPage === 'ListPage' ? 1 : 0            
                    Text{
                         text:"R2"
                         color:"white"                    
                         anchors.verticalCenter: parent.verticalCenter
                         anchors.horizontalCenter: parent.horizontalCenter
                    }
                }              
              
                  TextInput{
                      id:searchInput
                      text:"Search.."
                      width:parent.width
                      height: parent.height                   
                      anchors.top: parent.top
                      anchors.left: parent.left
                      anchors.leftMargin: 6 
                      anchors.topMargin: 8
                      color: theme.text
                      onTextEdited: {
                          gameView.currentIndex = 0 //We move the highlight to the first item
                          searchValue = searchInput.text
                          gameView.model = searchGames
                      }
                      
                        Keys.onPressed: {
                          if (api.keys.isAccept(event)) {
                              gameView.focus = true   
                              return;
                          }  
                          
                          // if (api.keys.isCancel(event)) {
                          //     searchValue=''
                          //     searchInput.text='Search...'                            
                          //     gameView.focus = true                           
                          //     return;
                          // }  
                          
                          
                        }
                       
                  }
                            // searchValue = "ninja"
                            // gameView.model = searchGames              
              
            }              
          }      
            

          
        }
        
          Rectangle{
            id: header__border
            anchors.top: header_inner.bottom
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 8
            width: parent.width-40;
            height:1
            color: theme.text
          }        
        
    }