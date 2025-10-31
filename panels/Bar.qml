import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.widgets

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

        delegate: Component {
            PanelWindow {
                id: window
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

                    ToggleWidgets {
                        anchors.right: parent.right
                        anchors.rightMargin: 32
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
