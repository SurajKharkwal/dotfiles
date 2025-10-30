import QtQuick
import Quickshell
import qs.services

Rectangle {
    id: root
    implicitWidth: 260
    implicitHeight: 36
    radius: height / 2
    color: Appearance.colors.surfaceContainerLow

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        anchors.margins: 4
        Repeater {
            model: 10
            delegate: Rectangle {
                id: container
                property int elementSize: 24
                implicitWidth: elementSize
                implicitHeight: elementSize
                color: true ? "transparent" : Appearance.colors.surfaceContainerHigh
                radius: elementSize / 2
                Text {
                    anchors.centerIn: parent
                    text: index + 1
                    color: true ? Appearance.colors.onSurface : Appearance.colors.onSurfaceVariant
                }
            }
        }
    }
}
