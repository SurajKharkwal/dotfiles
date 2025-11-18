import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import "./widgets"

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        id: window
        property ShellScreen modelData
        visible: modelData.name && Hyprland.focusedMonitor && modelData.name === Hyprland.focusedMonitor.name
        anchors: Appearance.metrics.bar.anchors
        exclusiveZone: 0
        implicitWidth: Appearance.metrics.bar.width
        implicitHeight: Appearance.metrics.bar.height
        color: "transparent"

        mask: Region {
            id: maskRegion
            item: maskItem
        }

        Item {
            id: maskItem
            anchors {
                fill: parent
                bottomMargin: mouseArea.containsMouse ? 0 : window.implicitHeight - 2
            }
        }
        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
        }

        Rectangle {
            id: barBackground
            color: Appearance.colors.surface
            implicitHeight: window.implicitHeight
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: mouseArea.containsMouse ? 0 : -window.implicitHeight
            }
            topLeftRadius: Appearance.metrics.bar.topLeftRadius
            topRightRadius: Appearance.metrics.bar.topRightRadius
            bottomLeftRadius: Appearance.metrics.bar.bottomLeftRadius
            bottomRightRadius: Appearance.metrics.bar.bottomRightRadius

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
                    leftMargin: Appearance.metrics.bar.leftMargin
                }
            }
            Navbar {
                id: navbar
                currPanel: -1
                anchors.centerIn: parent
            }

            Battery {
                id: battery
                anchors {
                    right: navbar.left
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }
            }

            InternetSpeed {
                id: internetSpeed
                anchors {
                    left: navbar.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: 10
                }
            }
        }
    }
}
