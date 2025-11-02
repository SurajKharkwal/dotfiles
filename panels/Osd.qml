import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.widgets.osd
import Quickshell.Hyprland

Variants {
    id: variants
    model: Quickshell.screens

    delegate: PanelWindow {
        id: window
        property var modelData
        property string focusedMonitor: modelData.name
        anchors.right: true
        implicitWidth: Config.osdPanelWidth
        implicitHeight: Config.osdPanelHeight
        exclusiveZone: 0
        // TODO  brighness for multi monitors
        color: "transparent"

        mask: Region {
            id: hoverMask
            item: hoverMaskRegion
        }

        Item {
            id: hoverMaskRegion
            anchors {
                fill: parent
                leftMargin: OsdManager.showOsd ? 0 : Config.osdHoverLeftMargin
            }
        }

        MouseArea {
            id: hoverMaskMouse
            anchors.fill: hoverMaskRegion
            hoverEnabled: true
            onEntered: {
                OsdManager.restart();
            }
        }

        Rectangle {

            visible: OsdManager.showOsd && Hyprland.focusedMonitor.name === window.focusedMonitor
            implicitWidth: Config.osdImplicitWidth
            implicitHeight: Config.osdImplicitHeight
            anchors.right: parent.right
            anchors.rightMargin: Config.osdPanelWidth - Config.osdImplicitWidth
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
