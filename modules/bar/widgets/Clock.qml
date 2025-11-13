import QtQuick
import qs.config
import qs.services

Column {
    Text {
        text: Clock.time
        color: Appearance.colors.onSurface
        font.weight: 700
        font.family: Appearance.font
    }
    Text {
        text: Clock.date
        color: Appearance.colors.onSurface
        font.weight: 300
    }
}
