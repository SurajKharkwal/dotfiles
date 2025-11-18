import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire
import Quickshell.Io
import Quickshell.Widgets
import qs.services
import qs.config
import qs.assets.icons

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

    function handleVolumeIcon(v) {
        if (v == 0) {
            muteIcon.iconOpacity = 1;
        } else if (v < 0.5) {
            volumeDownIcon.iconOpacity = 1;
        } else {
            volumeUpIcon.iconOpacity = 1;
        }
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
            root.handleVolumeIcon(slider.value);
            label.opacity = 0;
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
                label.opacity = 1;
                volumeUpIcon.iconOpacity = 0;
                volumeDownIcon.iconOpacity = 0;
                muteIcon.iconOpacity = 0;
                label.text = Math.round(slider.value * 100) + "%";
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
                    id: label
                    color: Appearance.colors.primaryContainer
                    font.family: Appearance.font
                    text: Math.round(slider.value * 100) + "%"
                    anchors.centerIn: parent
                }

                VolumeUp {
                    id: volumeUpIcon
                    iconOpacity: 0
                    anchors.centerIn: parent
                    fillColor: Appearance.colors.primaryContainer
                }

                VolumeDown {
                    id: volumeDownIcon
                    iconOpacity: 0
                    anchors.centerIn: parent
                    fillColor: Appearance.colors.primaryContainer
                }

                Mute {
                    id: muteIcon
                    iconOpacity: 0
                    anchors.centerIn: parent
                    fillColor: Appearance.colors.primaryContainer
                }
            }
        }
    }
}
