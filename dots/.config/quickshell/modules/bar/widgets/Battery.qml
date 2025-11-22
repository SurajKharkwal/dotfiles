import QtQuick
import Quickshell.Services.UPower
import qs.config
import qs.assets.icons

Rectangle {
    id: root
    width: battery.width + text.width + Appearance.tokens.common.spacing.sm * 2.5
    height: parent.height * 0.8
    color: Appearance.colors.surfaceContainer
    radius: Appearance.tokens.common.radius.full

    property int iconSize: Appearance.tokens.common.iconSize.xl
    property int iconStrokeWidth: 2
    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state
    property bool isCharging: chargeState == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1

    Row {
        spacing: Appearance.tokens.common.spacing.sm
        anchors.fill: parent
        padding: Appearance.tokens.common.spacing.sm
        Text {
            id: text
            text: (root.percentage * 100).toFixed(0) + "%"
            font.pixelSize: Appearance.tokens.common.fontSize.md
            anchors.verticalCenter: parent.verticalCenter
            color: Appearance.colors.onSurface
        }

        BatteryIndicator {
            id: battery
            anchors.verticalCenter: parent.verticalCenter
            progress: root.percentage
            iconSize: root.iconSize - 2
            strokeWidth: root.iconStrokeWidth

            Battery {
                iconSize: Appearance.tokens.common.iconSize.md
                anchors.centerIn: parent
                fillColor: root.percentage < 0.25 ? Appearance.colors.error : Appearance.colors.onSurface
            }
        }
    }
}
