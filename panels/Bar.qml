import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.widgets.bar
import qs.widgets.controls

Variants {
    id: variants
    model: Quickshell.screens

    delegate: PanelWindow {
        id: window
        implicitWidth: Config.barPanelImplicitWidth
        implicitHeight: Config.barPanelImplicitHeight
        exclusiveZone: 0
        anchors.top: true
        color: "transparent"

        mask: Region {
            id: hoverMask
            item: hoverMaskRegion
        }

        Item {
            id: hoverMaskRegion
            anchors {
                fill: parent
                bottomMargin: hoverMaskMouse.containsMouse ? 0 : Config.barPanelImplicitHeight - Config.barHiddenPixel
            }
        }

        MouseArea {
            id: hoverMaskMouse
            anchors.fill: hoverMaskRegion
            hoverEnabled: true
        }

        BarMain {
            id: bar
            implicitWidth: Config.barImplicitWidth
            implicitHeight: Config.barImplicitHeight

            anchors.top: parent.top
            anchors.topMargin: hoverMaskMouse.containsMouse || Config.showControlsPopUp ? Config.barTopMargin : -100
            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 200
                }
            }
        }

        PopupWindow {
            id: controls
            anchor.window: window
            implicitWidth: Config.controlsPopUpWidth
            implicitHeight: Config.controlsPopUpHeight
            anchor.rect.x: window.implicitWidth / 2 - implicitWidth / 2
            anchor.rect.y: window.implicitHeight + 24
            visible: Config.showControlsPopUp
            color: "transparent"
            ControlsMain {}
        }
        PopupWindow {
            id: powerMenu
            anchor.window: window
            implicitWidth: Config.powerMenuWidth
            implicitHeight: Config.powerMenuHeight
            anchor.rect.x: 0 + implicitWidth / 5
            anchor.rect.y: controls.implicitHeight * 0.84
            visible: Config.showPowerMenu
            color: "transparent"
            PowerMenu {}
        }

        WlrLayershell {
            id: layer
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            focusable: true
            layer: WlrLayer.Overlay
            visible: Config.showControlsPopUp
            color: "transparent"
            keyboardFocus: WlrKeyboardFocus.Exclusive

            FocusScope {
                anchors.fill: parent
                focus: true
                Keys.onPressed: event => {
                    if (event.key === Qt.Key_Escape) {
                        Config.showControlsPopUp = false;
                        Config.showPowerMenu = false;
                        event.accepted = true;
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Config.showControlsPopUp = false;
                    Config.showPowerMenu = false;
                }
            }
        }
    }
}
