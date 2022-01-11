import QtQuick 2.12
Rectangle {
    id: header_list
    color: headerCSS.background
    width: headerCSS.width
    height: 82
    anchors.top: parent.top
    // visible:false
    clip:true
    

    Rectangle{
      id: header_list__inner
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.topMargin: 0
      anchors.leftMargin: 0          
      color:"transparent"
      width:parent.width
      height: parent.height
      
      //Nombre          
      Rectangle{
        id: header_list__system
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 0
        width:  vw(25)
        height: parent.height  
        color:"transparent"    
        anchors.leftMargin: 20             
        Text{
          text: currentCollection.name
          anchors.left: header_list__system_logo.right
          anchors.leftMargin: 12
          color: theme.title
          font.family: bodyFont.name
          font.bold:true
          font.pixelSize: 24
          anchors.verticalCenter: parent.verticalCenter
          width:vpx(300)
          elide: Text.ElideRight       
        }
        Rectangle{
          id: header_list__system_border
          anchors.right: parent.right
          anchors.leftMargin: 20
          anchors.topMargin: 8
          width: 1;
          height:parent.height
          color: "#646363"
          opacity:0.4
        }        
        
      }    
      
      //Buscador
      Rectangle{
        id: header_list__filters
        color:"transparent"
        anchors.top: parent.top
        anchors.left: header_list__system.right
        height: parent.height
        width: parent.width-header_list__system.width-header_list__battery.width
        
        Rectangle{
          id: header_list__search
          color:"transparent";
          anchors.top: parent.top
          anchors.topMargin: 24 
          anchors.rightMargin: 20 
          anchors.right: parent.right
          width:parent.width-40
          height: 30 
          anchors.verticalCenter: parent.verticalCenter                
          radius:2
          visible:true
          
            Rectangle{
                id: header_list__search_button
                height:20*screenRatio
                width:20*screenRatio
                color:"#444"
                radius:20*screenRatio
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right 
                anchors.rightMargin: 6 
                visible: currentPage === 'ListPage' ? 1 : 0            
                Text{
                     text:"R2"
                     color:"white"                    
                     anchors.verticalCenter: parent.verticalCenter
                     anchors.horizontalCenter: parent.horizontalCenter
                     font.pixelSize: 10*screenRatio
                }
            }              
          
              TextInput{
                  id:header_list__search_input
                  text:"Search.."
                  font.family: bodyFont.name
                  font.pixelSize: 24
                  width:parent.width
                  height: parent.height                   
                  anchors.top: parent.top
                  anchors.left: parent.left
                  anchors.leftMargin: 6 
                  anchors.topMargin: 0
                  color: theme.text
                  onTextEdited: {
                      gameView.currentIndex = 0 //We move the highlight to the first item
                      searchValue = header_list__search_input.text
                      gameView.model = searchGames
                  }
                  
                    Keys.onPressed: {
                      if (api.keys.isAccept(event)) {
                          navigate('ListPage');
                          return;
                      }  
                      if (event.key == Qt.Key_Down) {
                          navigate('ListPage');  
                          return;
                      }
                      // if (api.keys.isCancel(event)) {
                      //     searchValue=''
                      //     header_list__search_input.text='Search...'                            
                      //     gameView.focus = true                           
                      //     return;
                      // }  
                      
                      
                    }
                   
              }
        }  
        
        Rectangle{
          id: header_list__filters_border
          anchors.right: parent.right
          anchors.leftMargin: 20
          anchors.topMargin: 8
          width: 1;
          height:parent.height
          color: "#646363"
          opacity:0.4
        }        
        
                    
      }      
        
      //Bateria
      Rectangle{
        id: header_list__battery
        width:120
        height:parent.height
        color:"transparent"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        anchors.rightMargin: 0
            Rectangle{
                id: header_list__battery_inner
                anchors.centerIn: parent
                anchors.right: parent.right
                anchors.left: parent.left
                height:50
                width:parent.width/1.9
                color:"transparent"
                    Text{
                      id: header_list__battery_number
                      text: Math.floor(api.device.batteryPercent*100)+" %"        
                      //anchors { top: parent.top }   
                      color: theme.title
                      font.pixelSize: 18
                      visible: headerHeightCorrection === 0 ? 1 : 0;
                      anchors.verticalCenter: parent.verticalCenter
                    }      
                    
                    Image {
                        id: header_list__battery_icon
                        height: 22   
                        width: 30
                        fillMode: Image.PreserveAspectFit
                        source: "../assets/icons/battery.png"
                        asynchronous: true      
                        //anchors { top: parent.top }   
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: header_list__battery_number.right
                        anchors.leftMargin: 6
                        z:3999
                        
                     }                      
            }
  
        }
        
        
      }
    
    Rectangle{
      id: header__list_border
      anchors.bottom: header_list.bottom
      anchors.left: parent.left
      anchors.leftMargin: 20
      anchors.topMargin: 8
      width: parent.width-40;
      height:1
      color: "#646363"
      opacity:0.4
    }        
    
}

