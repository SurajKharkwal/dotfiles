import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.services

Rectangle {
    id: root
    color: "transparent"

    Profile {
        implicitWidth: parent.implicitWidth
        implicitHeight: 48
        radius: 10
        anchors.bottom: parent.bottom
    }

    Column {
        spacing: 10
        anchors.top: parent.top
        anchors.topMargin: 32
        width: parent.implicitWidth

        Button {
            implicitWidth: parent.width
            implicitHeight: 40

            text: " Home"

            contentItem: Text {
                text: parent.text
                color: true ? Appearance.colors.onPrimary : Appearance.colors.onSurface
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            background: Rectangle {
                implicitWidth: parent.implicitWidth
                implicitHeight: parent.implicitHeight
                color: true ? Appearance.colors.primary : "transparent"
                radius: 8
            }
        }

        Button {
            implicitWidth: parent.width
            implicitHeight: 40
            text: "󰲍  Wallpapers"

            contentItem: Text {
                text: parent.text
                color: Appearance.colors.onSurface
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            background: Rectangle {
                implicitWidth: parent.implicitWidth
                implicitHeight: parent.implicitHeight
                color: false ? Appearance.colors.primary : "transparent"
                radius: 8
            }
        }
    }
}
