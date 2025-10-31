import QtQuick
import Quickshell
import qs.services
import qs.widgets

PanelWindow {
    id: root
    anchors.top: true
    implicitWidth: 800
    implicitHeight: 96
    exclusiveZone: 0
    color: "transparent"

    Rectangle {
        id: myRect
        anchors.top: parent.top
        anchors.topMargin: 32
        implicitWidth: root.implicitWidth
        implicitHeight: 64
        color: Appearance.colors.background
        // color: "transparent"
        radius: implicitWidth / 2
        layer.enabled: true

        Time {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 32
        }

        Workspaces {
            anchors.centerIn: parent
        }

        Battery {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 32 + 40 + 20
        }

        ToggleWidgets {
            anchors.right: parent.right
            anchors.rightMargin: 32
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
