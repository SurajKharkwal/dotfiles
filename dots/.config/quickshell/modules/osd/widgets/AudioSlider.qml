import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.config
import qs.services
import qs.assets.icons
import Quickshell.Io

ClippingRectangle {
    id: root
    width: 50
    height: parent.height * 0.8
    radius: width / 2

    IpcHandler {
        target: "osdVolume"
        function handleChange(v) {
            OsdManager.setVolume(OsdManager.volume + v);
        }
    }

    function hideIcon() {
        muteIcon.iconOpacity = 0;
        volumeDownIcon.iconOpacity = 0;
        volumeUpIcon.iconOpacity = 0;
    }

    function showIcon(v) {
        if (v === 0)
            muteIcon.iconOpacity = 1;
        else if (v < 0.5)
            volumeDownIcon.iconOpacity = 1;
        else
            volumeUpIcon.iconOpacity = 1;
    }

    Timer {
        id: fadeTimer
        interval: 500
        onTriggered: {
            root.showIcon(slider.value);
            label.opacity = 0;
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: e => {
            const step = 0.05;
            const dir = e.angleDelta.y < 0 ? 1 : -1;
            OsdManager.setVolume(OsdManager.volume + dir * step);
        }
    }

    Slider {
        id: slider
        anchors.fill: parent
        orientation: Qt.Vertical

        value: OsdManager.volume

        onValueChanged: {
            label.opacity = 1;
            root.hideIcon();
            label.text = Math.round(slider.value * 100) + "%";
            fadeTimer.restart();
            OsdManager.setVolume(slider.value);
        }

        background: Rectangle {
            anchors.fill: parent
            color: Appearance.colors.primaryContainer

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
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
            y: (root.height - height) * slider.visualPosition
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: label
                color: Appearance.colors.primaryContainer
                font.family: Appearance.font
                text: Math.round(OsdManager.volume * 100) + "%"
                anchors.centerIn: parent
            }

            VolumeUp {
                id: volumeUpIcon
                iconOpacity: 0
                iconSize: Appearance.tokens.iconSize.sm
                anchors.centerIn: parent
                fillColor: Appearance.colors.primaryContainer
            }

            VolumeDown {
                id: volumeDownIcon
                iconOpacity: 0
                iconSize: Appearance.tokens.iconSize.sm
                anchors.centerIn: parent
                fillColor: Appearance.colors.primaryContainer
            }

            Mute {
                id: muteIcon
                iconOpacity: 0
                iconSize: Appearance.tokens.iconSize.sm
                anchors.centerIn: parent
                fillColor: Appearance.colors.primaryContainer
            }
        }
    }
}
