import QtQuick
import Quickshell
import qs.config
import Quickshell.Hyprland
import Quickshell.Widgets

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        id: window
        property ShellScreen modelData
        visible: modelData && Hyprland && Hyprland.focusedMonitor && Hyprland.focusedMonitor.name === modelData.name
        implicitWidth: Screen.pixelDensity * 100
        implicitHeight: Screen.pixelDensity * 50
        anchors.left: true
        exclusiveZone: 0
        color: "transparent"

        mask: Region {
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
            anchors.fill: maskItem
            propagateComposedEvents: true
        }

        Rectangle {
            implicitWidth: parent.width - Appearance.tokens.common.spacing.md
            implicitHeight: parent.height
            radius: Appearance.tokens.common.radius.lg
            color: Appearance.colors.background
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                rightMargin: mouseArea.containsMouse ? 0 : window.width
            }
            Behavior on anchors.rightMargin {
                NumberAnimation {
                    duration: 101
                }
            }

            WrapperMouseArea {
                implicitWidth: 30
                implicitHeight: 30
                hoverEnabled: true
                acceptedButtons: Qt.NoButton

                Rectangle {
                    width: 30
                    height: 30
                    color: "red"
                }
            }
        }
    }
}
