import QtQuick
import qs.config
import qs.services

Rectangle {
    id: root
    property int wsSize: parent.height * 0.8
    property int selectedIndex: 0
    implicitWidth: wsSize * 10 + 10
    implicitHeight: parent.height
    color: Appearance.colors.surfaceContainer
    radius: Appearance.tokens.common.radius.full
    anchors {
        left: parent.left
        leftMargin: Appearance.tokens.common.spacing.md
        verticalCenter: parent.verticalCenter
    }

    Row {
        id: workspaceGround
        width: parent.width
        height: parent.height
        Repeater {
            model: Workspace.groups
            width: parent.width
            height: parent.height
            anchors {
                verticalCenter: parent.verticalCenter
            }
            delegate: Rectangle {
                color: Appearance.colors.primaryContainer
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: (modelData[0] - 1) * root.wsSize + root.anchors.leftMargin / 2
                }
                implicitWidth: root.wsSize * modelData.length
                implicitHeight: root.wsSize
                radius: width / 2
            }
        }
    }

    Rectangle {
        id: focusedWorkspace
        color: Appearance.colors.primary
        x: workspaceRow.x + (Workspace.focused - 1) * root.wsSize
        anchors {
            verticalCenter: parent.verticalCenter
        }
        implicitWidth: root.wsSize
        implicitHeight: root.wsSize
        radius: Appearance.tokens.common.radius.full

        Behavior on x {
            SpringAnimation {
                spring: 100
                damping: 10
            }
        }
    }
    Row {
        id: workspaceRow
        anchors.centerIn: parent
        Repeater {
            model: 10
            delegate: Rectangle {
                color: "transparent"
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                implicitWidth: root.wsSize
                implicitHeight: root.wsSize
                radius: width / 2
                MouseArea {
                    anchors.fill: parent
                    onClicked: Workspace.activate(index + 1)
                }

                Text {
                    text: index + 1
                    color: index === (Workspace.focused - 1) ? Appearance.colors.onPrimary : Appearance.colors.onSurface
                    anchors.centerIn: parent
                    font.family: Appearance.font
                    opacity: index === (Workspace.focused - 1) ? 1 : Appearance.tokens.common.opacity.md
                }
            }
        }
    }
}
