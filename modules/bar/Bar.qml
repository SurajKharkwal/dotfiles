import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import "./widgets"

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        property ShellScreen modelData
        visible: modelData.name && Hyprland.focusedMonitor && modelData.name === Hyprland.focusedMonitor.name
        anchors.top: true
        exclusiveZone: 0
        implicitWidth: Metrics.barWidth
        implicitHeight: Metrics.barHeight
        color: "transparent"

        mask: Region {
            id: maskRegion
            item: maskItem
        }

        Item {
            id: maskItem
            anchors {
                fill: parent
                bottomMargin: mouseArea.containsMouse ? 0 : Metrics.barHeight - 2
            }
        }
        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
        }

        Rectangle {
            id: barBackground
            color: Appearance.colors.background
            implicitHeight: Metrics.barHeight
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: mouseArea.containsMouse ? 0 : -Metrics.barHeight
            }
            bottomLeftRadius: 32
            bottomRightRadius: 32

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                }
            }

            Clock {
                id: clock
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    margins: {
                        left: 24;
                    }
                }
            }
            Navbar {
                id: navbar
                selectedIndex: 2
                anchors.centerIn: parent
            }

            Battery {
                id: battery
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: {
                        right: 24;
                    }
                }
            }
        }
    }
}
