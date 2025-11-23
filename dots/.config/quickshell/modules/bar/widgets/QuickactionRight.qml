import QtQuick
import qs.config
import qs.assets.icons

Row {
    id: root
    property int iconSize: parent.height * 0.8
    width: iconSize * 3 + spacing * 2
    spacing: 2
    Rectangle {
        id: screenshot
        width: root.iconSize
        height: root.iconSize
        color: Appearance.colors.surfaceContainer
        topLeftRadius: Appearance.tokens.common.radius.full
        bottomLeftRadius: Appearance.tokens.common.radius.full
        topRightRadius: Appearance.tokens.common.radius.xs
        bottomRightRadius: Appearance.tokens.common.radius.xs
        Dnd {
            id: darkmodeIcon
            fillColor: Appearance.colors.onSurface
            iconSize: Appearance.tokens.common.iconSize.md
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: mode
        width: root.iconSize
        height: root.iconSize
        color: Appearance.colors.surfaceContainer
        topLeftRadius: Appearance.tokens.common.radius.xs
        bottomLeftRadius: Appearance.tokens.common.radius.xs
        topRightRadius: Appearance.tokens.common.radius.xs
        bottomRightRadius: Appearance.tokens.common.radius.xs

        Nightlight {
            id: screenshotIcon
            iconSize: Appearance.tokens.common.iconSize.md
            fillColor: Appearance.colors.onSurface
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: mic
        width: root.iconSize
        height: root.iconSize
        color: Appearance.colors.surfaceContainer
        topLeftRadius: Appearance.tokens.common.radius.xs
        bottomLeftRadius: Appearance.tokens.common.radius.xs
        topRightRadius: Appearance.tokens.common.radius.full
        bottomRightRadius: Appearance.tokens.common.radius.full

        Awake {
            id: micIcon
            iconSize: Appearance.tokens.common.iconSize.md
            fillColor: Appearance.colors.onSurface
            anchors.centerIn: parent
        }
    }
}
