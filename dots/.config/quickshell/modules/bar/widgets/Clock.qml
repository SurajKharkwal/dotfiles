import QtQuick
import qs.config
import qs.services

Column {
    Text {
        text: Clock.time
        color: Appearance.colors.onSurface
        font.bold: true
        font.pixelSize: Appearance.metrics.common.fontSize.medium
        font.family: Appearance.font
    }
    Text {
        text: Clock.date
        color: Appearance.colors.onSurface
        font.weight: Appearance.metrics.common.fontWeight.small
        font.family: Appearance.font
    }
}
