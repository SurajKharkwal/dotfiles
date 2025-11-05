import QtQuick
import Quickshell.Widgets
import qs.config

ClippingRectangle {
    anchors {
        fill: parent
    }
    color: Appearance.colors.background
    radius: 32

    Rectangle {
        implicitWidth: Metrics.controlSidebarWidth
        implicitHeight: parent.height
        color: "transparent"
        anchors.left: parent.left

        Column {
            anchors {
                fill: parent
                topMargin: Metrics.sidebarPadY
                bottomMargin: Metrics.sidebarPadY
            }
            spacing: 10
            Repeater {
                model: [
                    {
                        label: "Home",
                        icon: "",
                        index: 0
                    },
                    {
                        label: "Wallpaper",
                        icon: "",
                        index: 1
                    },
                    {
                        label: "Stats",
                        icon: "󰾆",
                        index: 2
                    },
                    {
                        label: "Devices",
                        icon: "I/O",
                        index: 3
                    }
                ]

                delegate: Rectangle {
                    id: container
                    implicitHeight: 64
                    implicitWidth: parent.width
                    property string label: modelData.label
                    property string icon: modelData.icon
                    property int index: modelData.index
                    color: "transparent"

                    MouseArea {
                        id: mousearea
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            Metrics.controlPageIndex = container.index;
                        }
                    }

                    Column {
                        anchors.fill: parent

                        Rectangle {
                            id: iconBackground
                            implicitWidth: 40
                            implicitHeight: 32
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: Metrics.controlPageIndex == container.index ? Appearance.colors.primaryContainer : mousearea.containsMouse ? Appearance.colors.surfaceContainerHigh : Appearance.colors.surface
                            radius: implicitHeight / 2

                            Text {
                                id: icon
                                text: container.icon
                                color: Metrics.controlPageIndex == container.index ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface
                                anchors.centerIn: parent
                                font.pixelSize: 20
                            }
                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }

                        Text {
                            id: label
                            text: container.label
                            color: Appearance.colors.onSurface
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.weight: 300
                        }
                    }
                }
            }
        }
    }

    ClippingRectangle {
        color: Appearance.colors.surfaceContainerLowest
        implicitWidth: parent.width - Metrics.controlSidebarWidth
        implicitHeight: parent.height
        anchors.right: parent.right
        radius: 32
    }
}
