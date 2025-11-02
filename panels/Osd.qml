import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.widgets.osd
import Quickshell.Hyprland

Scope {
    id: root

    IpcHandler {
        target: "osd"
        function expand(monitorId: int) {
            const instance = variants.instances[monitorId];
            instance.expandThisBar();
        }
        function collapse(monitorId: int) {
            const instance = variants.instances[monitorId];
            instance.collapseThisBar();
        }
    }
    Variants {
        id: variants
        model: Quickshell.screens

        delegate: PanelWindow {
            id: window
            property var modelData
            anchors.right: true
            implicitWidth: 232
            implicitHeight: 300
            exclusiveZone: 0
            // TODO  brighness for multi monitors
            visible: OsdManager.showOsd && Hyprland.focusedMonitor.name === modelData.name
            color: "transparent"

            function expandThisBar() {
                OsdManager.restart();
            }
            Rectangle {
                implicitWidth: 200
                implicitHeight: 300
                anchors.right: parent.right
                anchors.rightMargin: 32
                color: Appearance.colors.background
                radius: 32

                border.color: Appearance.colors.outlineVariant
                border.width: 1
                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    onEntered: OsdManager.stop()
                    onExited: OsdManager.restart()
                }
                AudioSlider {
                    //w:40px
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                }
                BrightnessSlider {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 40
                }
            }
        }
    }
}
