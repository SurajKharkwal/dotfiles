import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.services
import "./widgets/"

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        id: window
        property var modelData
        visible: modelData.name === Hyprland.focusedMonitor.name
        implicitWidth: 150
        implicitHeight: 280
        anchors.right: true
        exclusiveZone: 0
        color: "transparent"
        mask: Region {
            id: maskRegion
            item: maskItem
        }

        Item {
            id: maskItem
            anchors {
                fill: parent
                leftMargin: mouseArea.containsMouse || OsdManager.openOsd ? 0 : window.width - 2
            }
        }
        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
        }
        Rectangle {
            topLeftRadius: 32
            bottomLeftRadius: 32
            implicitHeight: window.height
            implicitWidth: window.width
            color: Appearance.colors.background
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: mouseArea.containsMouse || OsdManager.openOsd ? 0 : window.width
            }

            Behavior on anchors.leftMargin {
                SmoothedAnimation {
                    duration: 150
                }
            }

            AudioSlider {
                implicitWidth: 40
                implicitHeight: 200

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 23
                }
            }

            BrightnessSlider {
                implicitWidth: 40
                implicitHeight: 200

                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 23
                }
            }
        }
    }
}
