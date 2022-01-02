import QtQuick 2.12

  Rectangle {
      id: header
      color: headerCSS.background
      width: headerCSS.width
      height: headerCSS.height-headerHeightCorrection // Zoom option
      anchors.top: parent.top      
      z:99
      visible: currentPage === 'HomePage' ? 1 : 0 ;
      Rectangle{
        id: header__battery
        width:84
        color:"transparent"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 12
        anchors.rightMargin: 24
        
        Text{
            id: header__battery_number
            text: api.device.batteryPercent+" %"    
            anchors { top: parent.top }   
            color: theme.title
            font.pixelSize: 18
            visible: headerHeightCorrection === 0 ? 1 : 0;
        }      
        
        Image {
              id: header__battery_icon
              height: 22   
              width: 30
              fillMode: Image.PreserveAspectFit
              source: "../assets/icons/battery.png"
              asynchronous: true      
              anchors { top: parent.top }   
              anchors.left: header__battery_number.right
              anchors.leftMargin: 6
              z:3999
              
         }        
      }
      
      Text{
          id: header__time
          text: Qt.formatTime(new Date(), "hh:mm")         
          anchors.right: header__battery.left
          anchors.top: parent.top
          anchors.topMargin: 12
          anchors.rightMargin: 24
          color: theme.title
          font.pixelSize: 18
          visible: headerHeightCorrection === 0 ? 1 : 0;
      }      
      
      
      Text{
          id: header__music
          text: "Music: "+music[api.memory.get('musicArray')]
          anchors.right: header__time.left
          anchors.top: parent.top
          anchors.topMargin: 12
          anchors.rightMargin: 24
          color: theme.title
          font.pixelSize: 18
          visible: headerHeightCorrection === 0 ? 1 : 0;
      }      
      
      
      
  }