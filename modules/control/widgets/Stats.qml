import QtQuick
import qs.config

Item {
    id: root

    implicitWidth: parent.width
    implicitHeight: parent.height
    anchors.right: parent.right

    Row {
        anchors.fill: parent

        Ram {}
        Rectangle {
            implicitWidth: parent.width / 3
            implicitHeight: parent.height
            border.width: 1
        }
        Rectangle {
            implicitWidth: parent.width / 3
            implicitHeight: parent.height
            border.width: 1
        }
    }
}
