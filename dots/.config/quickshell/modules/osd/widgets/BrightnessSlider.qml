import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.services
import qs.config
import qs.assets.icons

Item {
    id: root

    property int brightness: 0
    property bool suppressIcons: false

    function setBrightness(value: int) {
        const cmd = ["sh", "-c", `brightnessctl -s set ${value}%`];
        Quickshell.execDetached(cmd);
    }

    function handleBrightnessIcon(v) {
        if (root.suppressIcons)
            return;
        brightnessEmpty.iconOpacity = 0;
        brightnessLow.iconOpacity = 0;
        brightnessHigh.iconOpacity = 0;
        brightnessFull.iconOpacity = 0;
        if (v === 0) {
            brightnessEmpty.iconOpacity = 1;
        } else if (v < 50) {
            brightnessLow.iconOpacity = 1;
        } else if (v < 80) {
            brightnessHigh.iconOpacity = 1;
        } else {
            brightnessFull.iconOpacity = 1;
        }
    }

    Process {
        id: get
        running: true
        command: ["sh", "-c", "brightnessctl -m | awk -F, '{gsub(/%/, \"\", $4); print $4}'"]
        stdout: StdioCollector {
            onStreamFinished: root.brightness = parseInt(this.text.trim())
        }
    }

    IpcHandler {
        target: "osdBrightness"
        function handleChange(v: int) {
            OsdManager.restart();
            root.brightness = Math.min(100, Math.max(0, root.brightness + v));
            root.setBrightness(root.brightness);
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: e => {
            root.suppressIcons = true;
            if (e.angleDelta.y < 0) {
                root.brightness = Math.min(100, root.brightness + 5);
            } else {
                root.brightness = Math.max(0, root.brightness - 5);
            }
            root.setBrightness(root.brightness);
            timmer.restart();
        }
    }

    Timer {
        id: timmer
        interval: 500
        running: false
        onTriggered: {
            root.suppressIcons = false;
            root.handleBrightnessIcon(slider.value);
            text.opacity = 0;
        }
    }

    ClippingRectangle {
        id: clipRect
        anchors.fill: parent
        radius: width / 2
        color: "transparent"

        Slider {
            id: slider
            anchors.fill: parent
            orientation: Qt.Vertical
            from: 0
            to: 100
            value: root.brightness

            onValueChanged: {
                text.opacity = 1;
                root.suppressIcons = true;
                brightnessEmpty.iconOpacity = 0;
                brightnessFull.iconOpacity = 0;
                brightnessHigh.iconOpacity = 0;
                brightnessLow.iconOpacity = 0;

                text.text = Math.round(slider.value) + "%";
                timmer.restart();
                root.setBrightness(slider.value);
            }

            background: Rectangle {
                id: background
                anchors.fill: parent
                color: Appearance.colors.primaryContainer

                Rectangle {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    height: parent.height - handle.y - handle.height / 2
                    color: Appearance.colors.primary
                }
            }

            handle: Rectangle {
                id: handle
                width: parent.width
                height: width
                radius: width / 2
                color: Appearance.colors.onPrimaryContainer
                y: (clipRect.height - height) * slider.visualPosition
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: text
                    font.family: Appearance.font
                    color: Appearance.colors.primaryContainer
                    text: Math.round(slider.value) + "%"
                    anchors.centerIn: parent
                }

                BrightnessEmpty {
                    id: brightnessEmpty
                    fillColor: Appearance.colors.primaryContainer
                    anchors.centerIn: parent
                    iconOpacity: 0
                    Behavior on iconOpacity {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                BrightnessFull {
                    id: brightnessFull
                    fillColor: Appearance.colors.primaryContainer
                    anchors.centerIn: parent
                    iconOpacity: 0
                    Behavior on iconOpacity {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                BrightnessLow {
                    id: brightnessLow
                    fillColor: Appearance.colors.primaryContainer
                    anchors.centerIn: parent
                    iconOpacity: 0
                    Behavior on iconOpacity {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                BrightnessHigh {
                    id: brightnessHigh
                    fillColor: Appearance.colors.primaryContainer
                    anchors.centerIn: parent
                    iconOpacity: 0
                    Behavior on iconOpacity {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }
}
