import QtQuick
import qs.config
import qs.assets.icons

Row {
    id: root
    width: mic.width + mode.width + screenshot.width + screenshot.width
    property int iconSize: parent.height * 0.8
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

        Screenshot {
            id: screenshotIcon
            iconSize: Appearance.tokens.common.iconSize.md
            fillColor: Appearance.colors.onSurface
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

        Darkmode {
            id: darkmodeIcon
            fillColor: Appearance.colors.onSurface
            iconSize: Appearance.tokens.common.iconSize.md
            anchors.centerIn: parent
            visible: Appearance.tokens.theme.mode === "light"
        }

        Lightmode {
            id: lightmodeIcon
            fillColor: Appearance.colors.onSurface
            iconSize: Appearance.tokens.common.iconSize.md
            anchors.centerIn: parent
            visible: Appearance.tokens.theme.mode === "dark"
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

        Mic {
            id: micIcon
            iconSize: Appearance.tokens.common.iconSize.md
            fillColor: Appearance.colors.onSurface
            anchors.centerIn: parent
        }
        // MicOff {
        //     id: micOffIcon
        //     opacity: Appearance.tokens.common.opacity.lg
        //     fillColor: Appearance.colors.onSurface
        //     anchors.centerIn: parent
        // }
    }
}
