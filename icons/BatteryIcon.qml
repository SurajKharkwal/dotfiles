import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Shapes

ClippingRectangle {
    id: root
    property color fillColor
    property color pathColor
    property real percentage
    implicitWidth: 30
    implicitHeight: 40
    color: "transparent"
    Row {
        anchors.centerIn: parent
        Rectangle {
            id: container
            implicitWidth: root.implicitWidth * 0.9
            implicitHeight: 18
            radius: 4
            anchors.verticalCenter: parent.verticalCenter
            color: root.pathColor
        }
        Rectangle {
            id: containerTip
            implicitWidth: root.implicitWidth * 0.1
            implicitHeight: 10
            radius: 2
            color: root.pathColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Row {
        visible: true
        anchors.centerIn: parent
        ClippingRectangle {
            implicitWidth: root.implicitWidth * 0.9
            implicitHeight: 18
            radius: 4
            color: "transparent"

            Rectangle {
                id: fluidBlock
                anchors.left: parent.left
                property real myTip: root.implicitWidth * 0.1
                implicitWidth: root.percentage * root.implicitWidth - myTip
                implicitHeight: 18
                anchors.verticalCenter: parent.verticalCenter
                color: root.fillColor
            }
        }
        ClippingRectangle {
            implicitWidth: root.implicitWidth * 0.1
            implicitHeight: 18
            radius: 4
            color: "transparent"
            Rectangle {
                id: fluidTip
                property real myCont: root.implicitWidth * 0.9
                implicitWidth: root.percentage * root.implicitWidth - myCont
                implicitHeight: 10
                radius: 2
                color: root.fillColor
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
