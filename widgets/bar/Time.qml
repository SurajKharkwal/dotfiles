import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Column {
    id: root
    Text {
        id: timeText
        text: Config.timeText
        color: Appearance.colors.onBackground
        font.pixelSize: 16
        font.bold: true
    }
    Text {
        id: dateText
        text: Config.dateText
        font.weight: 300
        color: Appearance.colors.onBackground
    }
}
