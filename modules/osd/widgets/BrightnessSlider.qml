import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.services
import qs.config

Item {
    id: root

    property int brightness

    function setBrightness(value: int) {
        const cmd = ["sh", "-c", `brightnessctl -s set ${value}%`];
        Quickshell.execDetached(cmd);
    }

    function brightnessIcon(v) {
        if (v <= 0)
            return "󰃞";
        if (v < 0.33)
            return "󰃟";
        if (v < 0.66)
            return "󰃝";

        return "󰃠";
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
            if (e.angleDelta.y < 0) {
                root.setBrightness(root.brightness + 5);
                root.brightness = Math.min(100, Math.max(0, root.brightness + 5));
            } else {
                root.setBrightness(root.brightness - 5);
                root.brightness = Math.min(100, Math.max(0, root.brightness - 5));
            }
        }
    }

    Timer {
        id: timmer
        interval: 500
        running: false
        onTriggered: {
            text.text = root.brightnessIcon(slider.value / 100);
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
                // Use visualPosition safely in clip coordinates
                y: (clipRect.height - height) * slider.visualPosition
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: text
                    color: Appearance.colors.primaryContainer
                    text: Math.round(slider.value) + "%"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
