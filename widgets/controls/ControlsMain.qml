import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.services

ClippingRectangle {
    id: root
    anchors.fill: parent
    color: Appearance.colors.background
    radius: 32
    border.width: 1
    border.color: Appearance.colors.outlineVariant
    Row {
        anchors.fill: parent
        Rectangle {
            id: sidebar
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
            implicitWidth: Config.controlsPopUpWidth * 0.15
            implicitHeight: Config.controlsPopUpHeight
            Sidebar {
                implicitWidth: parent.implicitWidth * 0.8
                implicitHeight: parent.implicitHeight * 0.9
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle {
            y: -1 * Config.currSettingIndex * Config.controlsPopUpHeight
            anchors.right: parent.right
            implicitWidth: Config.controlsRectWidth * 0.85
            implicitHeight: Config.controlsRectHeight * Config.settings

            Column {
                anchors.fill: parent
                Rectangle {
                    implicitWidth: Config.controlsRectWidth
                    implicitHeight: Config.controlsRectHeight
                    color: "lightblue"
                }

                Rectangle {
                    implicitWidth: Config.controlsRectWidth
                    implicitHeight: Config.controlsRectHeight
                    color: "lightpink"
                }
            }

            Behavior on y {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }
}
