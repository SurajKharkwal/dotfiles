import QtQuick
import Quickshell
import qs.services
import qs.config

Rectangle {
    id: ws
    implicitWidth: Metrics.workspaceWidth
    implicitHeight: Metrics.workspaceHeight
    radius: implicitHeight / 2
    color: Appearance.colors.surfaceContainer

    MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
            console.log(wheel.angleDelta.y);
            if (wheel.angleDelta.y < 0)
                Workspace.activate(Math.max(1, Math.min(10, Workspace.focused + 1)));
            else
                Workspace.activate(Math.max(1, Math.min(10, Workspace.focused - 1)));
        // console.log(wheel.angleDelta.y);
        }
    }

    Row {
        anchors {
            fill: parent
            margins: Metrics.workspaceMargin / 2
        }
        Repeater {
            model: 10
            delegate: Rectangle {
                id: rect
                property int index: modelData + 1
                implicitWidth: Metrics.workspaceElementSize
                implicitHeight: implicitWidth
                radius: implicitHeight / 2
                color: "transparent"
                Text {
                    text: rect.index
                    anchors.centerIn: parent
                    color: Appearance.colors.onSurfaceVariant
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // console.log(modelData + 1);
                        Workspace.focused = Workspace.activate(modelData + 1);
                    }
                }
            }
        }
    }
    Item {
        anchors {
            fill: parent
            margins: Metrics.workspaceMargin / 2
        }
        Repeater {
            model: Workspace.groups
            delegate: Rectangle {
                id: rectHighliter
                implicitHeight: Metrics.workspaceElementSize
                implicitWidth: implicitHeight * modelData.length
                x: implicitHeight * (modelData[0] - 1)
                radius: implicitHeight / 2
                color: Appearance.colors.primaryContainer
                opacity: 0.3
                Behavior on anchors.leftMargin {
                    NumberAnimation {
                        duration: 100
                    }
                }
            }
        }
    }
    Rectangle {
        id: main
        implicitWidth: Metrics.workspaceElementSize
        implicitHeight: implicitWidth
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: implicitHeight * (Workspace.focused - 1) + Metrics.workspaceMargin / 2
        }
        radius: implicitHeight / 2
        color: Appearance.colors.primary
        Text {
            text: Workspace.focused
            anchors.centerIn: parent
            color: Appearance.colors.onPrimary
        }
        Behavior on anchors.leftMargin {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
