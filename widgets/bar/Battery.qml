import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.icons
import qs.services

Rectangle {
    id: root
    implicitWidth: 100
    implicitHeight: 40
    radius: implicitWidth / 2

    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state
    property bool isCharging: chargeState == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1
    property color onSurface: {
        if (!available)
            return Appearance.colors.onSurface;

        if (percentage < 0.25) {
            return Appearance.colors.Error;
        }
        return Appearance.colors.onSurface;
    }

    color: Appearance.colors.surfaceContainerLow
    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 4
        Text {
            text: root.percentage * 100 + "%"
            color: root.onSurface
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: {
                if (!root.available)
                    return "󰚥";
                if (root.isCharging)
                    return "";
                else {
                    if (root.isPluggedIn)
                        return "";
                    else
                        return "󰚦";
                }
                return "󰚦";
            }
            color: root.onSurface
            anchors.verticalCenter: parent.verticalCenter
        }
        BatteryIcon {
            anchors.verticalCenter: parent.verticalCenter
            percentage: root.percentage
            pathColor: root.percentage < 0.25 ? Appearance.colors.onErrorContainer : Appearance.colors.surfaceBright
            fillColor: root.percentage < 0.25 ? Appearance.colors.errorContainer : Appearance.colors.primary
        }
    }
}
