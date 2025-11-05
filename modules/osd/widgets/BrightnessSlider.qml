import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell
import Quickshell.Io
import qs.config
import qs.services

Item {
    id: root
    property int brightness

    function setBrightness(value: int) {
        const cmd = ["sh", "-c", `brightnessctl -s set ${value}%`];
        Quickshell.execDetached(cmd);
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
            // console.log(root.brightness);
            OsdManager.restart();
            root.brightness = Math.min(100, Math.max(0, root.brightness + v));
            root.setBrightness(root.brightness);
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: e => {
            if (e.angleDelta.y > 0) {
                root.brightness = Math.min(100, Math.max(0, root.brightness + 5));
                root.setBrightness(root.brightness);
            } else {
                root.brightness = Math.min(100, Math.max(0, root.brightness - 5));
                root.setBrightness(root.brightness);
            }
        }
    }

    ClippingRectangle {
        id: clipRect
        implicitWidth: parent.width
        implicitHeight: parent.height
        anchors.verticalCenter: parent.verticalCenter
        radius: 12
        Slider {
            id: slider
            anchors.fill: parent
            from: 0
            to: 100
            value: root.brightness
            orientation: Qt.Vertical

            background: Rectangle {
                id: background
                anchors.fill: parent
                color: Appearance.colors.primaryContainer

                Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: (1 - slider.visualPosition) * parent.height
                    color: Appearance.colors.primary
                    anchors.bottom: parent.bottom
                }
            }
            onValueChanged: root.setBrightness(value)
            handle: null
        }
    }

    Rectangle {
        id: handle
        width: 70
        height: 12
        radius: 4
        color: Appearance.colors.primary
        border.width: 2
        border.color: Appearance.colors.outline

        // Position relative to slider track
        x: clipRect.x + (clipRect.width - width) / 2
        y: clipRect.y + slider.visualPosition * (clipRect.height - height)
    }
    Text {
        id: icon
        text: "󰃠"
        color: Appearance.colors.onPrimary
        font.pixelSize: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        rotation: 360 * slider.visualPosition

        Behavior on rotation {
            NumberAnimation {
                duration: 100
            }
        }
    }
}
