import QtQuick
import qs.config
import qs.services

Item {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: speedText.width + unitText.width
    implicitHeight: parent.height * 0.8
    property var network: Network.getSpeed()

    Text {
        id: speedText
        text: root.network.speed ?? "0.0"
        color: Appearance.colors.onSurface
        font.family: Appearance.font
        font.pixelSize: Appearance.tokens.common.fontSize.md
        font.weight: Appearance.tokens.common.fontWeight.thin
        anchors {
            verticalCenter: parent.verticalCenter
            right: unitText.left
            leftMargin: Appearance.tokens.common.spacing.xl
        }
    }
    Text {
        id: unitText
        text: root.network.unit ?? "KB/s"
        color: Appearance.colors.onSurface
        font.family: Appearance.font
        font.pixelSize: Appearance.tokens.common.fontSize.md
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        font.weight: Appearance.tokens.common.fontWeight.light
        width: implicitWidth
    }
}
