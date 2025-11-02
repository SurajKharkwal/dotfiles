import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.services

ClippingRectangle {
    id: root
    anchors.fill: parent
    color: Appearance.colors.background
    property int containerWidth: 1000
    property int containerHeight: 500
    radius: 32
    border.width: 1
    border.color: Appearance.colors.outlineVariant
    Row {
        anchors.fill: parent
        Rectangle {
            id: sidebar
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"
            implicitWidth: root.containerWidth * 0.15
            implicitHeight: root.containerHeight
            Sidebar {
                implicitWidth: parent.implicitWidth * 0.8
                implicitHeight: parent.implicitHeight * 0.9
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle {
            id: notificaiton
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: sidebar.implicitWidth
            color: Appearance.colors.surfaceContainerLow
            implicitWidth: root.containerWidth * 0.4
            implicitHeight: root.containerHeight * 0.9
            radius: 16
        }
        Rectangle {
            anchors.right: parent.right
            color: "transparent"
            anchors.rightMargin: root.containerWidth * 0.02
            implicitWidth: root.containerWidth * 0.4
            implicitHeight: root.containerHeight * 0.9
            anchors.verticalCenter: parent.verticalCenter
            Rectangle {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: root.containerWidth * 0.3
                implicitHeight: root.containerHeight * 0.1
                radius: 16
                color: Appearance.colors.primaryContainer
            } // wifi and bluetooh
            Rectangle {
                anchors.bottom: parent.bottom
                implicitWidth: root.containerWidth * 0.4
                implicitHeight: root.containerHeight * 0.75
                color: Appearance.colors.surfaceContainerLow
                radius: 16
            } // wifi and bluetooh
        }
    }
}
