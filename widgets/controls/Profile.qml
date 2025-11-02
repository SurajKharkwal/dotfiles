import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.services

Rectangle {
    id: profile
    property int iconSize: 32
    color: "transparent"
    property bool showProfileItems: false

    QtObject {
        property int w: Screen.width
        property int h: Screen.height
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            profile.color = Appearance.colors.surfaceContainer;
        }
        onExited: {
            profile.color = "transparent";
        }
        onClicked: Config.showPowerMenu = !Config.showPowerMenu
    }

    Row {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 6

        ClippingRectangle {
            width: profile.iconSize
            height: profile.iconSize
            radius: width / 2

            IconImage {
                anchors.centerIn: parent
                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/face.jpeg")
                implicitSize: profile.iconSize
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            width: profile.width - profile.iconSize - 20

            Text {
                text: Quickshell.env("USER")
                color: Appearance.colors.onSurface
                font.pixelSize: 12
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                width: parent.width
            }

            Text {
                text: "Arch Linux"
                color: Appearance.colors.onSurfaceVariant
                font.pixelSize: 10
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                width: parent.width
            }
        }
    }
}
