import QtQuick
import Quickshell.Widgets
import Quickshell.Io
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import qs.services
import qs.config

Item {
    id: root
    required property LockContext context
    property string wallpaperPath: ""

    Process {
        id: getWallpaper
        running: true
        command: ["bash", "-c", "swww query | grep -oP 'image: \\K.*'"]
        stdout: StdioCollector {
            id: wc
            onStreamFinished: root.wallpaperPath = wc.text.trim()
        }
    }

    Item {
        id: bg
        anchors.fill: parent
        visible: wallpaperPath !== ""

        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            blur: 1
            blurMax: 64
            autoPaddingEnabled: false
        }

        Image {
            anchors.fill: parent
            source: Qt.resolvedUrl(root.wallpaperPath)
            fillMode: Image.PreserveAspectCrop
        }
    }

    Button {
        text: "Its not working, let me out"
        anchors.centerIn: parent
        onClicked: root.context.unlocked()
    }

    ClippingRectangle {
        id: panel
        width: 500
        height: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent

        radius: width / 2
        color: Appearance.colors.surfaceContainer

        RowLayout {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 48

            ColumnLayout {
                Layout.fillHeight: true
                spacing: 4

                Text {
                    text: Clock.time
                    color: Appearance.colors.onSurface
                    font.pixelSize: 32
                    font.weight: 700
                    font.family: Appearance.font
                }

                Text {
                    text: Clock.date
                    color: Appearance.colors.onSurface
                    font.pixelSize: 20
                    font.weight: 300
                }
            }

            Rectangle {
                width: 1
                Layout.fillHeight: true
                color: Appearance.colors.outlineVariant
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 12

                Text {
                    text: "FlyingHawk"
                    color: Appearance.colors.onSurface
                    font.pixelSize: 16
                    font.weight: 400
                }

                RowLayout {
                    Layout.preferredWidth: 260
                    Layout.preferredHeight: 40
                    spacing: 8

                    Rectangle {
                        id: iconBox
                        width: 32
                        height: 32
                        radius: 16
                        color: Appearance.colors.surfaceVariant

                        Text {
                            text: ""
                            anchors.centerIn: parent
                            color: Appearance.colors.onSurface
                        }
                    }

                    TextField {
                        Layout.fillWidth: true
                        placeholderText: "Password"
                        color: Appearance.colors.onSurface

                        background: Rectangle {
                            radius: 16
                            color: Appearance.colors.surfaceVariant
                        }
                    }
                }
            }
        }
    }
}
