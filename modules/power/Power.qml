import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.config
import Quickshell.Hyprland
import "./widgets"

Variants {
    id: variants
    model: Quickshell.screens
    delegate: PanelWindow {
        id: window
        property var modelData
        anchors.left: true
        exclusiveZone: 0
        implicitWidth: 300
        implicitHeight: 800
        color: "transparent"
        visible: modelData.name === Hyprland.focusedMonitor.name

        mask: Region {
            id: maskRegion
            item: maskItem
        }
        Item {
            id: maskItem
            anchors {
                fill: parent
                rightMargin: mouseArea.containsMouse ? 0 : window.width - 2
            }
        }

        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
        }

        ClippingRectangle {
            id: background
            color: Appearance.colors.background
            anchors.fill: parent
            topRightRadius: 32
            bottomRightRadius: 32

            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                rightMargin: mouseArea.containsMouse ? 0 : window.width
            }

            Behavior on anchors.rightMargin {
                SpringAnimation {
                    spring: 10
                    damping: 0.2
                }
            }

            Actions {
                implicitWidth: parent.width
                implicitHeight: 300
                anchors {
                    top: greet.bottom
                    left: parent.left
                }
            }

            Rectangle {
                id: greet
                implicitWidth: parent.width
                implicitHeight: 220
                color: Appearance.colors.surfaceContainer
                topRightRadius: 32

                AnimatedImage {
                    source: "/home/flyinghawk/.config/quickshell/assets/sad-cute.gif"
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 32
                    }
                    width: parent.width
                    height: parent.height - 30
                    fillMode: Image.PreserveAspectFit
                }
            }
        }
    }
}
