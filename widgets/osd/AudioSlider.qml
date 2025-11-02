import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import Quickshell.Io
import qs.services

ClippingRectangle {
    id: root
    implicitWidth: 45
    implicitHeight: 200
    radius: implicitWidth / 2
    property PwNode sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio.volume ?? 0

    PwObjectTracker {
        objects: [root.sink]
    }

    function setVolume(v: real) {
        const value = Math.max(0, Math.min(1, v));
        if (root.sink) {
            root.sink.audio.muted = false;
            root.sink.audio.volume = value;
        }
    }

    IpcHandler {
        target: "osdVolume"
        function handleChange(v: real) {
            OsdManager.restart();
            root.setVolume(root.volume + v);

        // console.log("handleChange()", v, "after change", root.volume);
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            OsdManager.onSliders = true;
            inc.running = true;
            // console.log("entered()");
        }
        onExited: {
            OsdManager.onSliders = false;
            dsc.running = true;
            // console.log("exited()");
        }
        onWheel: e => {
            if (e.angleDelta.y > 0) {
                root.setVolume(root.volume + 0.05);
            } else {
                root.setVolume(root.volume - 0.05);
            }
        }
    }

    NumberAnimation {
        id: inc
        target: path
        properties: "opacity"
        from: 0.6
        to: 1
        duration: 100
    }

    NumberAnimation {
        id: dsc
        target: path
        properties: "opacity"
        from: 1
        to: 0.6
        duration: 100
    }

    Slider {
        id: slider
        from: 0
        to: 1
        value: root.volume
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
        onValueChanged: root.setVolume(value)
        handle: Rectangle {}
    }
    Text {
        text: {
            if (root.volume == 0 || root.sink == null || root.sink?.muted)
                return "";
            if (root.volume > 0.7)
                return "";
            if (root.volume > 0.4)
                return "";
            else
                return "";
        }
        color: Appearance.colors.onPrimary
        font.pixelSize: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
    }
}
