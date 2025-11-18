import QtQuick
import Quickshell.Services.UPower
import qs.config
import qs.assets.icons

Rectangle {
    id: root
    implicitWidth: 100
    implicitHeight: parent.height * 0.75
    radius: implicitWidth / 2

    property int iconSize: Appearance.metrics.bar.battery.iconSize
    property int iconStrokeWidth: Appearance.metrics.bar.battery.iconStrokeWidth
    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state
    property bool isCharging: chargeState == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1
    property color onSurface: {
        if (!available)
            return Appearance.colors.onSurface;

        if (percentage < 0.25) {
            return Appearance.colors.error;
        }
        return Appearance.colors.onSurface;
    }

    color: Appearance.colors.surfaceContainer

    Row {
        anchors.centerIn: parent
        spacing: 4
        Text {
            text: (root.percentage * 100).toFixed(0) + "%"
            color: root.onSurface
            font.family: Appearance.font
            font.pixelSize: Appearance.metrics.common.fontSize.medium
            anchors.verticalCenter: parent.verticalCenter
        }

        BatteryIndicator {
            anchors.verticalCenter: parent.verticalCenter
            progress: root.percentage
            iconSize: root.iconSize
            strokeWidth: root.iconStrokeWidth
        }
    }
}
