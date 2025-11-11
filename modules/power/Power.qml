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
        property ShellScreen modelData
        anchors.left: true
        exclusiveZone: 0
        implicitWidth: 300
        implicitHeight: 450
        color: "transparent"
        visible: modelData.name && Hyprland.focusedMonitor && modelData.name === Hyprland.focusedMonitor.name

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

        Rectangle {
            id: background
            color: Appearance.colors.background
            topRightRadius: 32
            bottomRightRadius: 32
            implicitWidth: parent.width
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                rightMargin: mouseArea.containsMouse ? 0 : window.width
            }

            Behavior on anchors.rightMargin {
                NumberAnimation {
                    duration: 100
                }
            }

            Actions {
                width: parent.width
                height: 250
                padding: 16
                anchors {
                    top: greet.bottom
                    left: parent.left
                }
            }

            Rectangle {
                id: greet
                implicitWidth: parent.width - 32
                implicitHeight: 250 - 32
                color: Appearance.colors.surfaceContainer
                radius: 32
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: 16
                }

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
