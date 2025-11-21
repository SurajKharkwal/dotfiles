import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.config
import qs.services
import qs.assets.icons

ClippingRectangle {
    id: root
    width: 50
    height: parent.height * 0.8
    radius: width / 2

    function hideIcon() {
        brightnessEmpty.iconOpacity = 0;
        brightnessLow.iconOpacity = 0;
        brightnessHigh.iconOpacity = 0;
        brightnessFull.iconOpacity = 0;
    }

    function showIcon(v) {
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
            const step = 5;
            const dir = e.angleDelta.y < 0 ? 1 : -1;
            OsdManager.setBrightness(OsdManager.brightness + dir * step);
        }
    }

    Slider {
        id: slider
        anchors.fill: parent
        orientation: Qt.Vertical
        from: 0
        to: 100

        value: OsdManager.brightness

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
                text: Math.round(OsdManager.brightness * 100) + "%"
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
