import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.config
import Quickshell.Services.Pipewire
import Quickshell.Io
import qs.services

Item {
    id: root
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
        }
    }
    MouseArea {
        anchors.fill: parent
        onWheel: e => {
            if (e.angleDelta.y > 0) {
                root.setVolume(root.volume + 0.05);
            } else {
                root.setVolume(root.volume - 0.05);
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
            to: 1
            value: root.volume
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
            onValueChanged: root.setVolume(value)
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
        text: {
            if (root.volume == 0 || root.sink == null || root.sink?.audio.muted)
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
