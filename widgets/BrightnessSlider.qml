import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.services

ClippingRectangle {
    id: root
    implicitWidth: 45
    implicitHeight: 200
    radius: implicitWidth / 2
    property int brightness

    function setBrightness(value: int) {
        const cmd = ["sh", "-c", `brightnessctl -s set ${value}%`];
        set.exec(cmd);
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

    Process {
        id: set
    }

    Process {
        id: get
        running: true
        command: ["sh", "-c", "brightnessctl -m | awk -F, '{gsub(/%/, \"\", $4); print $4}'"]
        stdout: StdioCollector {
            onStreamFinished: root.brightness = parseInt(this.text.trim())
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            OsdManager.onSliders = true;
            inc.running = true;
            console.log("entered()");
        }
        onExited: {
            OsdManager.onSliders = false;
            dsc.running = true;
            console.log("exited()");
        }
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

    NumberAnimation {
        id: inc
        target: path
        properties: "opacity"
        from: 0.6
        to: 1
        duration: 300
    }

    NumberAnimation {
        id: dsc
        target: path
        properties: "opacity"
        from: 1
        to: 0.6
        duration: 300
    }

    Slider {
        id: slider
        from: 0
        to: 100
        value: root.brightness
        orientation: Qt.Vertical
        anchors.centerIn: parent

        background: Rectangle {
            implicitWidth: root.implicitWidth
            implicitHeight: root.implicitHeight
            color: Appearance.colors.primaryContainer

            Rectangle {
                id: path
                implicitWidth: parent.implicitWidth
                implicitHeight: (1 - slider.visualPosition) * parent.implicitHeight
                anchors.bottom: parent.bottom
                color: Appearance.colors.primary
                opacity: 0.6
            }
        }

        handle: Rectangle {}
        onValueChanged: root.setBrightness(value)
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
