import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.services

ClippingRectangle {
    id: root
    property int size: 32
    implicitWidth: size
    implicitHeight: size
    property color iconColor: Appearance.colors.onSurfaceVariant
    color: "transparent"

    Item {
        anchors.centerIn: parent
        width: childrenRect.width
        height: childrenRect.height

        Grid {
            rows: 2
            columns: 2
            rowSpacing: 4
            columnSpacing: 4

            Rectangle {
                implicitWidth: root.size / 4
                implicitHeight: root.size / 4
                radius: 1
                color: root.iconColor
            }
            Rectangle {
                implicitWidth: root.size / 4
                implicitHeight: root.size / 4
                radius: 1
                rotation: 45
                color: root.iconColor
            }
            Rectangle {
                implicitWidth: root.size / 4
                implicitHeight: root.size / 4
                radius: 1
                color: root.iconColor
            }
            Rectangle {
                implicitWidth: root.size / 4
                implicitHeight: root.size / 4
                radius: 1
                color: root.iconColor
            }
        }
    }
}
