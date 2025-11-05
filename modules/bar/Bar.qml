import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.config
import qs.icons
import qs.modules.bar.widgets
import qs.modules.control
import Quickshell.Wayland

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        id: barWindow
        property ShellScreen modelData
        visible: modelData.name == Hyprland.focusedMonitor.name
        exclusiveZone: 0
        color: "transparent"
        implicitWidth: Metrics.barWidth
        implicitHeight: Metrics.barHeight + Metrics.barTopMargin
        anchors {
            top: true
        }
        mask: Region {
            id: hoverMask
            item: hoverMaskRegion
        }

        Item {
            id: hoverMaskRegion
            anchors {
                fill: parent
                bottomMargin: Metrics.openControlPanel ? 0 : (hoverMaskMouse.containsMouse ? 0 : Metrics.barHeight + Metrics.barTopMargin - 2)
            }
        }

        MouseArea {
            id: hoverMaskMouse
            anchors.fill: hoverMaskRegion
            hoverEnabled: true
        }

        WlrLayershell {
            visible: Metrics.openControlPanel
            color: "transparent"
            anchors {
                top: true
                bottom: true
                right: true
                left: true
            }
            focusable: true

            FocusScope {
                anchors.fill: parent
                focus: true
                Keys.onPressed: e => {
                    if (e.key === Qt.Key_Escape) {
                        Metrics.openControlPanel = false;
                        e.accepted = true;
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: Metrics.openControlPanel = false
            }

            PopupWindow {
                id: controlPanel
                anchor.window: barWindow
                visible: Metrics.openControlPanel
                implicitHeight: Metrics.controlPanelHeight
                implicitWidth: Metrics.controlPanelWidth
                anchor.rect.x: barWindow.implicitWidth / 2 - implicitWidth / 2
                anchor.rect.y: barWindow.implicitHeight + Metrics.controlPanelTopOffset
                color: "transparent"
                Control {}
            }
        }
        Rectangle {
            id: bar
            visible: hoverMaskMouse.containsMouse || Metrics.openControlPanel
            radius: width / 2
            color: Appearance.colors.background
            border.width: 1
            border.color: Appearance.colors.outlineVariant
            anchors {
                top: parent.top
                topMargin: hoverMaskMouse.containsMouse || Metrics.openControlPanel ? Metrics.barTopMargin : -Metrics.barHeight - Metrics.barTopMargin
            }
            implicitWidth: Metrics.barWidth
            implicitHeight: Metrics.barHeight
            opacity: hoverMaskMouse.containsMouse || Metrics.openControlPanel ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Clock {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: Metrics.barXPadding
                }
            }
            Workspace {
                anchors {
                    centerIn: parent
                }
            }
            Battery {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: Metrics.barXPadding + 64
                }
            }

            ControlBtn {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: Metrics.barXPadding
                }
            }
        }
    }
}
