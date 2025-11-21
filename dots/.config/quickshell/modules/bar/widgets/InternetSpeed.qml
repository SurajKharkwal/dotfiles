import QtQuick
import qs.config
import qs.services

Rectangle {
    id: root
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: 100
    implicitHeight: parent.height * 0.8
    radius: Appearance.tokens.common.radius.full
    property var network: Network.getSpeed()
    color: Appearance.colors.surfaceContainer

    Text {
        id: speedText
        text: root.network.speed ?? "0.0"
        color: Appearance.colors.onSurface
        font.family: Appearance.font
        font.pixelSize: Appearance.tokens.common.fontSize.md
        font.weight: Appearance.tokens.common.fontWeight.thin
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
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
            rightMargin: Appearance.tokens.common.spacing.lg
        }
        font.weight: Appearance.tokens.common.fontWeight.light
        width: implicitWidth
    }
}
