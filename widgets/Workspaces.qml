import QtQuick
import Quickshell
import qs.services

Rectangle {
    id: root
    property int xpad : 20
    implicitWidth: 270 + xpad 
    implicitHeight: 40
    radius: implicitWidth / 2
    property int elementSize : (implicitWidth-xpad)/10
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

                implicitWidth: root.elementSize
                implicitHeight: root.elementSize
                radius: root.elementSize / 2
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
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: Workspaces.groups
            property int duration: 2000

            delegate: Rectangle {
              anchors.verticalCenter: parent.verticalCenter
                id: groupHighlight
                x: firstIndex * (root.elementSize) + root.xpad/2
                implicitWidth: (ids.length * root.elementSize) + ((ids.length - 1))
                implicitHeight: root.elementSize
                radius: implicitWidth / 2
                opacity: 0.5
                color: Appearance.colors.primaryContainer

                property var ids: modelData
                property int firstIndex: ids[0] - 1
                property int lastIndex: ids[ids.length - 1] - 1


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
        implicitWidth: root.elementSize
        implicitHeight: root.elementSize
        anchors.verticalCenter: parent.verticalCenter
        radius: implicitWidth / 2
        x: (Workspaces.focused-1) * root.elementSize  + xpad/2
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
