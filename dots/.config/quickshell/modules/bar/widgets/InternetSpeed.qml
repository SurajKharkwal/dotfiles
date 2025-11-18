import QtQuick
import qs.config
import qs.assets.icons
import qs.services

Rectangle {
    implicitHeight: parent.height * 0.75
    implicitWidth: 100
    radius: 32
    color: Appearance.colors.surfaceContainer

    Row {
        anchors.centerIn: parent
        spacing: 8

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0
            property var network: Network.getSpeed()
            Text {
                text: parent.network.speed ?? "0.0"
                anchors.horizontalCenter: parent.horizontalCenter
                color: Appearance.colors.onSurface
                font.family: Appearance.font
                width: implicitWidth
                font.pixelSize: Appearance.metrics.common.fontSize.small
            }
            Text {
                text: parent.network.unit ?? "KB/s"
                color: Appearance.colors.onSurface
                font.family: Appearance.font
                font.pixelSize: 12
                width: implicitWidth
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Download {
            iconOpacity: 0.7
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
