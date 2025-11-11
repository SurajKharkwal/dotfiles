import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.config
import qs.services
import "./widgets"

Scope {
    id: root
    IpcHandler {
        id: ipcHandler
        target: "qsLauncher"
        function toggle() {
            Launcher.toggle();
        }
    }

    Variants {
        id: variants
        model: Quickshell.screens

        delegate: PanelWindow {
            id: window
            property ShellScreen modelData
            property bool isFocusedMonitor: modelData.name && Hyprland.focusedMonitor && modelData.name === Hyprland.focusedMonitor.name
            visible: isFocusedMonitor && Launcher.openPanel
            implicitHeight: 500
            implicitWidth: 600

            focusable: true
            color: "transparent"

            ClippingRectangle {
                anchors.fill: parent
                color: Appearance.colors.background
                radius: 32
                scale: Launcher.openPanel ? 1 : 0.8
                transformOrigin: Item.Top
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
                border {
                    width: 1
                    color: Appearance.colors.outlineVariant
                }

                Search {
                    id: search
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        topMargin: 16
                    }
                    implicitHeight: 64
                    implicitWidth: parent.width
                }
                Applist {
                    apps: Launcher.displayApps
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: search.bottom
                        bottom: parent.bottom
                        topMargin: 16
                        bottomMargin: 16
                    }
                }
            }
        }
    }
}
