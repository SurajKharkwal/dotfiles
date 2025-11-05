import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.config
import qs.modules.osd.widgets
import qs.services

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        anchors.right: true
        exclusiveZone: 0
        implicitHeight: Metrics.osdPanelHeight
        implicitWidth: Metrics.osdPanelWidth
        color: "transparent"

        mask: Region {
            id: maskLayer
            item: maskRegion
        }

        Item {
            id: maskRegion
            anchors {
                fill: parent
                leftMargin: OsdManager.openOsd ? 0 : hoverMaskRegion.containsMouse ? 0 : Metrics.osdPanelWidth - 2
            }
        }
        MouseArea {
            id: hoverMaskRegion
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                console.log("entered");
                OsdManager.stop();
            }
            onExited: {
                console.log("exited");
                OsdManager.restart();
            }
        }

        Rectangle {
            id: osdBackground
            anchors {
                fill: parent
                leftMargin: OsdManager.openOsd ? 0 : Metrics.osdPanelWidth + 10
                rightMargin: Metrics.osdPanelRightMargin
            }
            radius: 32
            opacity: OsdManager.openOsd ? 1 : 0
            color: Appearance.colors.surface
            AudioSlider {
                implicitHeight: Metrics.osdSliderHeight
                implicitWidth: Metrics.osdSliderWidth
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 30
                }
            }
            BrightnessSlider {
                implicitHeight: Metrics.osdSliderHeight
                implicitWidth: Metrics.osdSliderWidth
                anchors {
                    left: parent.left
                    leftMargin: Metrics.osdPanelWidth - Metrics.osdPanelRightMargin - Metrics.osdSliderWidth - Metrics.osdPanelXPad
                    verticalCenter: parent.verticalCenter
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on anchors.leftMargin {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
