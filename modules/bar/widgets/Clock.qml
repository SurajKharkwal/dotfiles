import QtQuick
import Quickshell
import Quickshell.Io
import qs.services
import qs.config

Column {
    id: root
    Text {
        id: timeText
        text: Clock.timeText
        color: Appearance.colors.onBackground
        font.pixelSize: Metrics.clockTimeFontSize
        font.bold: true
    }
    Text {
        id: dateText
        text: Clock.dateText
        font.weight: 300
        font.pixelSize: Metrics.clockDateFontSize
        color: Appearance.colors.onBackground
    }
}
