import QtQuick
import qs.config

Column {
    anchors {
        fill: parent
        topMargin: Metrics.sidebarPadY
        bottomMargin: Metrics.sidebarPadY
    }
    spacing: 10
    Repeater {
        model: Metrics.controlOpts
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
                cursorShape: Qt.PointingHandCursor
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
