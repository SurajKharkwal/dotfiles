import QtQuick
import qs.config

Rectangle {
    id: root

    property int iconSize: Metrics.controlBtnSize
    property int offSet: Metrics.controlBtnOffset
    property int strokeSize: iconSize / 10
    property color surfaceColor: Appearance.colors.secondaryContainer

    implicitWidth: iconSize
    implicitHeight: iconSize
    radius: iconSize / 2
    color: root.surfaceColor

    Behavior on scale {
        NumberAnimation {
            duration: 120
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Metrics.openControlPanel = !Metrics.openControlPanel
        onPressed: root.scale = 0.9
        onReleased: root.scale = 1
        cursorShape: Qt.PointingHandCursor
    }
    Rectangle {
        id: firsRect
        width: root.iconSize / 2
        height: root.strokeSize
        radius: width / 2
        color: Appearance.colors.onSecondaryContainer
        rotation: Metrics.openControlPanel ? 45 : 0
        opacity: 0.6
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: Metrics.openControlPanel ? root.height / 2 - root.strokeSize / 2 : root.offSet
        }
    }

    Rectangle {
        id: secondRect
        width: root.iconSize / 2
        height: root.strokeSize
        radius: width / 2
        color: Appearance.colors.onSecondaryContainer
        opacity: Metrics.openControlPanel ? 0 : 0.6
        anchors {
            centerIn: parent
        }
    }

    Rectangle {
        id: thirdRect
        width: root.iconSize / 2
        height: root.strokeSize
        radius: width / 2
        color: Appearance.colors.onSecondaryContainer
        rotation: Metrics.openControlPanel ? -45 : 0
        opacity: 0.6
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: Metrics.openControlPanel ? root.height / 2 - root.strokeSize / 2 : root.offSet
        }
    }
}
