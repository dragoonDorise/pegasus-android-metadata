import QtQuick 2.12

  Rectangle {
      id: header
      color: headerCSS.background
      width: headerCSS.width
      height: headerCSS.height-headerHeightCorrection // Zoom option
      anchors.top: parent.top      
      
      Text{
          id: header__time
          text: Qt.formatTime(new Date(), "hh:mm")          
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.topMargin: 34
          anchors.rightMargin: 24
          color: theme.title
          font.pixelSize: 18
          visible: headerHeightCorrection === 0 ? 1 : 0;
      }      
      
  }