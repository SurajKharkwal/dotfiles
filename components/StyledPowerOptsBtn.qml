import QtQuick
import QtQuick.Controls
import Quickshell
import qs.services

Rectangle {
    id: root
    width: parent.width
    height: 36
    radius: 8
    property bool hovered: false
    property string text
    property string icon
    property list<string> cmd
    color: hovered ? Appearance.colors.surfaceContainerHighest : "transparent"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: Config.exec(root.cmd)
        onEntered: parent.hovered = true
        onExited: parent.hovered = false
    }

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 10
        Label {
            text: root.icon
            font.family: "Nerd Font"
            color: Appearance.colors.onSurface
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
        }
        Label {
            text: root.text
            color: Appearance.colors.onSurface
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
        }
    }
}
