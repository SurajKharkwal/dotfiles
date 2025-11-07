import QtQuick
import qs.config

Item {
    id: root

    implicitWidth: parent.width
    implicitHeight: parent.height
    anchors.right: parent.right

    Row {
        anchors.fill: parent

        Cpu {}
        Ram {}
        Disk {}
    }
}
