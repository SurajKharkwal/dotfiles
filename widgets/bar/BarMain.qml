import QtQuick
import QtQuick.Controls
import Quickshell
import qs.icons
import qs.services

Rectangle {
    id: root
    color: Appearance.colors.background
    radius: implicitWidth / 2

    border.color: Appearance.colors.outlineVariant
    border.width: 1

    Ws {
        anchors.centerIn: parent
    }

    Time {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: Config.xPad
        }
    }

    Battery {
        anchors {
            verticalCenter: parent.verticalCenter
            right: btn.left
            rightMargin: Config.xPad / 2
        }
    }
    Rectangle {
        id: btn
        anchors.right: parent.right
        anchors.rightMargin: Config.xPad
        anchors.verticalCenter: parent.verticalCenter
        color: Appearance.colors.primaryContainer
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                animate.running = true;
                Config.showControlsPopUp = !Config.showControlsPopUp;
            }
        }

        implicitWidth: 36
        implicitHeight: 36
        radius: implicitWidth / 2

        WidgetsIcon {
            anchors.centerIn: parent
        }

        SequentialAnimation {
            id: animate
            NumberAnimation {
                target: btn
                properties: "scale"
                from: 1
                to: 0.7
                duration: 50
            }
            NumberAnimation {
                target: btn
                properties: "scale"
                from: 0.7
                to: 1
                duration: 50
            }
        }
    }
}
