import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.services
import qs.icons

Rectangle {
    id: root
    implicitWidth: 40
    implicitHeight: 40
    radius: implicitWidth / 2
    color: Appearance.colors.surfaceContainerLow
    scale: 1

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }
    SequentialAnimation {
        id: animate
        NumberAnimation {
            id: dscScale
            target: root
            properties: "scale"
            from: 1
            to: 0.8
            duration: 50
        }
        NumberAnimation {
            id: incScale
            target: root
            properties: "scale"
            from: 0.8
            to: 1
            duration: 50
        }
    }

    MouseArea {
        id: mouseControl
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            root.color = Appearance.colors.surfaceContainerHigh;
            iconEle.iconColor = Appearance.colors.onSurface;
        }
        onExited: {
            root.color = Appearance.colors.surfaceContainerLow;
            iconEle.iconColor = Appearance.colors.onSurfaceVariant;
        }
        onClicked: {
            animate.running = true;
        }
    }

    WidgetsIcon {
        id: iconEle
        anchors.centerIn: parent
    }
}
