import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick.Controls
import qs.services
import qs.widgets.bar
import qs.widgets.controls
import Quickshell.Wayland
import qs.icons

Scope {
    id: root
    IpcHandler {
        target: "bar"
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
            property ShellScreen modelData
            property bool showControls: false
            anchors.top: true
            implicitWidth: 800
            implicitHeight: 100
            exclusiveZone: 0
            visible: false
            color: "transparent"

            function expandThisBar() {
                window.visible = true;
            }

            function collapseThisBar() {
                if (!showControls)
                    window.visible = false;
            }

            Rectangle {
                id: myRect
                anchors.top: parent.top
                anchors.topMargin: 36
                implicitHeight: 64
                implicitWidth: window.implicitWidth
                color: Appearance.colors.background
                radius: implicitWidth / 2
                layer.enabled: true

                border.color: Appearance.colors.outlineVariant
                border.width: 1

                Time {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 32
                }

                Workspaces {
                    anchors.centerIn: parent
                }

                Battery {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 32 + 40 + 20
                }

                Button {
                    id: btn
                    anchors.right: parent.right
                    anchors.rightMargin: 32
                    anchors.verticalCenter: parent.verticalCenter

                    implicitWidth: 36
                    implicitHeight: 36

                    onClicked: window.showControls = !window.showControls
                    onPressed: btn.scale = 0.85
                    onReleased: btn.scale = 1

                    background: Rectangle {
                        radius: btn.implicitWidth / 2
                        color: Appearance.colors.primaryContainer
                    }
                    contentItem: WidgetsIcon {
                        anchors.centerIn: parent
                    }
                }

                WlrLayershell {
                    id: qsLayer
                    anchors {
                        top: true
                        bottom: true
                        left: true
                        right: true
                    }
                    focusable: true
                    visible: window.showControls
                    color: "transparent"

                    FocusScope {
                        id: escScope
                        anchors.fill: parent
                        focus: window.showControls

                        Keys.onPressed: event => {
                            if (event.key === Qt.Key_Escape) {
                                console.log("close via key");
                                window.showControls = false;
                                Config.showProfile= false
                                event.accepted = true;
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("close via mouse click");
                                window.showControls = false;
                                Config.showProfile= false
                            }

                            PopupWindow {
                                id: contorlWindow
                                anchor.window: window
                                anchor.rect.x: window.implicitWidth / 2 - implicitWidth / 2
                                anchor.rect.y: window.implicitHeight + 32

                                implicitWidth: 1000
                                implicitHeight: 500
                                visible: window.showControls
                                color: "transparent"

                                Main {}
                            }

                            PopupWindow {
                                id: powerMenu
                                anchor.window: window
                                anchor.rect.x: contorlWindow.anchor.rect.x - implicitWidth + contorlWindow.implicitWidth * 0.15
                                anchor.rect.y: contorlWindow.anchor.rect.y + contorlWindow.implicitHeight - implicitHeight - 90
                                implicitWidth: contorlWindow.implicitWidth * 0.15
                                implicitHeight: 200
                                visible: window.showControls &&  Config.showProfile
                                color: "transparent"
                                ProfilePopup {}
                            }
                        }
                    }
                }
            }
        }
    }
}
