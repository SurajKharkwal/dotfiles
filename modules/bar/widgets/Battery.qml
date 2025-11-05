import QtQuick
import Quickshell
import Quickshell.Services.UPower
import qs.config
import qs.services
import qs.icons

Rectangle {
    id: root
    implicitWidth: Metrics.batteryWidth
    implicitHeight: Metrics.batteryHeight
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
        anchors.centerIn: parent
        spacing: 4
        Text {
            text: (root.percentage * 100).toFixed(0) + "%"
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
        BatteryIndicator {
            anchors.verticalCenter: parent.verticalCenter
            progress: root.percentage
        }
    }
}
