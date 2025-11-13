import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire
import Quickshell.Io
import Quickshell.Widgets
import qs.services
import qs.config

Item {
    id: root
    property PwNode sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio.volume ?? 0

    PwObjectTracker {
        objects: [root.sink]
    }
    function setVolume(v: real) {
        OsdManager.restart();
        const value = Math.max(0, Math.min(1, v));
        if (root.sink) {
            root.sink.audio.muted = false;
            root.sink.audio.volume = value;
        }
    }

    function volIcon(v) {
        if (v <= 0)
            return "󰝟";
        if (v < 0.33)
            return "󰕿";
        if (v < 0.66)
            return "󰖀";
        return "󰕾";
    }

    IpcHandler {
        target: "osdVolume"
        function handleChange(v: real) {
            root.setVolume(root.volume + v);
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: e => {
            if (e.angleDelta.y < 0) {
                root.setVolume(root.volume + 0.05);
            } else {
                root.setVolume(root.volume - 0.05);
            }
        }
    }

    Timer {
        id: timmer
        interval: 500
        running: false
        onTriggered: {
            text.text = root.volIcon(slider.value);
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
            value: root.volume
            onValueChanged: {
                text.text = Math.round(slider.value * 100) + "%";
                timmer.restart();
                root.setVolume(slider.value);
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
                    font.family: Appearance.font
                    text: Math.round(slider.value * 100) + "%"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
