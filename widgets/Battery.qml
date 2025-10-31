import QtQuick
import Quickshell
import qs.icons

Rectangle {
    implicitWidth: 40
    implicitHeight: 40
    color: "transparent"
    Text {
        text: ""
        color: "white"
    }
    BatteryIcon {
        anchors.centerIn: parent
        iconColor: "white"
    }
}
