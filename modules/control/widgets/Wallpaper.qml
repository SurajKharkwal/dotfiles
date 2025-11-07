import QtQuick
import Quickshell.Widgets

ClippingRectangle {
    id: root
    implicitWidth: parent.width
    implicitHeight: parent.height
    color: "transparent"

    Loader {
        id: l
        anchors.fill: parent
        active: true

        sourceComponent: WallpaperContent {
            anchors.fill: parent
        }
    }
}
