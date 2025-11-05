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
        font.pixelSize: 16
        font.bold: true
    }
    Text {
        id: dateText
        text: Clock.dateText
        font.weight: 300
        color: Appearance.colors.onBackground
    }
}
