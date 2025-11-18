import QtQuick
import Quickshell
import qs.config

Rectangle {
    id: root
    property bool active: false
    property list<string> cmd
    property int iconRadius: 16
    property int iconSize: 100
    property string text
    property string icon

    signal handleClick

    property bool highlight

    color: active ? Appearance.colors.primary : Appearance.colors.surfaceContainer
    radius: iconRadius
    implicitWidth: iconSize
    implicitHeight: implicitWidth

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.handleClick()
    }

    Text {
        text: root.icon
        color: root.highlight ? Appearance.colors.error : root.active ? Appearance.colors.onPrimary : Appearance.colors.onSurface
        font.family: Appearance.font
        font.pixelSize: 24
        anchors {
            top: parent.top
            topMargin: root.iconSize / 2 - height
            horizontalCenter: parent.horizontalCenter
        }
    }
    Text {
        text: root.text
        font.family: Appearance.font
        color: root.highlight ? Appearance.colors.error : root.active ? Appearance.colors.onPrimary : Appearance.colors.onSurface
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: root.iconSize / 2 - height
        }
    }
}
