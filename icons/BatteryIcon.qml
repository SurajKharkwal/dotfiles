import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Shapes

ClippingRectangle {
    id: root
    property color iconColor
    implicitWidth: 30
    implicitHeight: 40
    color: "transparent"
    Row {
        anchors.centerIn: parent
        Rectangle {
            id: mainBlock
            implicitWidth: root.implicitWidth * 0.9
            implicitHeight: 20
            radius: 4
            anchors.verticalCenter: parent.verticalCenter
            color: root.iconColor
        }
        Rectangle {
            id: tip
            implicitWidth: root.implicitWidth * 0.1
            implicitHeight: 10
            radius: 2
            color: root.iconColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
