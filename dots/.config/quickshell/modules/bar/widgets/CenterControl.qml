import QtQuick
import qs.config
import qs.services as Services

Rectangle {
    color: Appearance.colors.surfaceContainerHigh
    implicitWidth: time.width + ws.width
    implicitHeight: parent.height * 0.8
    radius: Appearance.tokens.common.radius.full
    anchors.centerIn: parent
    Text {
        id: time
        text: Services.Clock.time + " " + Services.Clock.date
        color: Appearance.colors.onSurface
        leftPadding: 10
        anchors {
            verticalCenter: parent.verticalCenter
        }
    }

    Workspace {
        id: ws
        color: Appearance.colors.surfaceContainerLow
        anchors {
            left: time.right
        }
    }
}
