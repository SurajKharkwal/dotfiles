import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.services
import qs.components

Rectangle {
    id: powerMenu
    width: parent.width
    height: parent.height
    radius: 12
    color: Appearance.colors.surfaceContainerHigh
    border.width: 1
    border.color: Appearance.colors.outlineVariant
    visible: true
    layer.enabled: true

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 6

        StyledPowerOptsBtn {
            text: "Power Off"
            icon: "󰐥"
            cmd: ["systemctl", "poweroff"]
        }

        StyledPowerOptsBtn {
            text: "Restart"
            icon: "󰜉"
            cmd: ["systemctl", "reboot"]
        }

        StyledPowerOptsBtn {
            text: "Suspend"
            icon: "󰤄"
            cmd: ["systemctl", "suspend"]
        }

        Rectangle {
            implicitWidth: parent.implicitWidth
            implicitHeight: 1
            color: Appearance.colors.outlineVariant
        }

        StyledPowerOptsBtn {
            text: "Logout"
            icon: "󰍃"
            cmd: ["hyprctl", "dispatch", "exit"]
        }
    }
}
