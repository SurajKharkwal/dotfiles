import QtQuick
import Quickshell
import qs.services

Rectangle {
    id: root
    implicitWidth: 264
    implicitHeight: 40
    radius: height / 2
    color: Appearance.colors.surfaceContainerLow
    antialiasing: true
    MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
            console.log(wheel.angleDelta.y);
            if (wheel.angleDelta.y > 0)
                Workspaces.activate(Math.max(1, Math.min(10, Workspaces.focused + 1)));
            else
                Workspaces.activate(Math.max(1, Math.min(10, Workspaces.focused - 1)));
            // console.log(wheel.angleDelta.y);
        }
    }

    Row {
        id: workspaceRow
        anchors.centerIn: parent

        Repeater {
            model: 10
            delegate: Rectangle {
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Workspaces.activate(index + 1);
                        console.log(index + 1);
                    }
                }

                property int elementSize: 24
                implicitWidth: elementSize
                implicitHeight: elementSize
                radius: implicitWidth / 2
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: index + 1
                    color: Appearance.colors.onSurface
                }
            }
        }
    }

    Item {
        id: workspaceRowHighlighter
        anchors.fill: workspaceRow

        Repeater {
            model: Workspaces.groups
            property int duration: 2000

            delegate: Rectangle {
                id: groupHighlight
                property int elementSize: 24
                implicitWidth: elementSize

                implicitHeight: elementSize
                radius: implicitWidth / 2
                color: Appearance.colors.primaryContainer
                opacity: 0.4

                property var ids: modelData
                property int firstIndex: ids[0] - 1
                property int lastIndex: ids[ids.length - 1] - 1

                x: firstIndex * (elementSize)
                width: (ids.length * elementSize) + ((ids.length - 1))

                Behavior on x {
                    NumberAnimation {
                        duration: 1000
                    }
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 1000
                    }
                }
            }
        }
    }

    Rectangle {
        id: focusedRect
        implicitWidth: 24
        implicitHeight: 24
        anchors.verticalCenter: parent.verticalCenter
        radius: implicitWidth / 2
        x: Workspaces.focused * 24 - 12 // 264 -240 = 24 and 12 each side
        color: Appearance.colors.primary
        Behavior on x {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutQuad
            }
        }

        Text {
            anchors.centerIn: parent
            text: Workspaces.focused
            color: Appearance.colors.onPrimary
        }
    }
}
