import QtQuick
import QtQuick.Effects
import qs.config
import qs.assets.icons

Rectangle {
    id: root
    height: parent.height * 0.75

    width: height * 5 + paddingX
    color: Appearance.colors.surfaceContainer
    radius: 32
    property int paddingX: 5
    // renamed property: selectedIndex -> currPanel
    // negative value means "none selected"
    property int currPanel: -1
    property list<Component> icons: [
        Component {
            Home {
                fillColor: root.currPanel == 0 ? Appearance.colors.primary : Appearance.colors.onSurface
                iconOpacity: root.currPanel == 0 ? 1 : 0.5
            }
        },
        Component {
            Wallpaper {
                fillColor: root.currPanel == 1 ? Appearance.colors.primary : Appearance.colors.onSurface
                iconOpacity: root.currPanel == 1 ? 1 : 0.5
            }
        },
        Component {
            Headphone {
                fillColor: root.currPanel == 2 ? Appearance.colors.primary : Appearance.colors.onSurface
                iconOpacity: root.currPanel == 2 ? 1 : 0.5
            }
        },
        Component {
            NotificationSettings {
                fillColor: root.currPanel == 3 ? Appearance.colors.primary : Appearance.colors.onSurface
                iconOpacity: root.currPanel == 3 ? 1 : 0.5
            }
        },
        Component {
            Power {
                // Power icon uses error color, but still shows selected state via opacity
                fillColor: Appearance.colors.error
                iconOpacity: root.currPanel == 4 ? 1 : 0.5
            }
        }
    ]

    Rectangle {
        id: highlight
        // visible only when a valid panel is selected (currPanel >= 0)
        visible: root.currPanel >= 0
        width: parent.height - root.paddingX / 2
        height: width
        radius: width / 2
        color: root.currPanel == 4 ? Appearance.colors.onError : Appearance.colors.primaryContainer
        // place off-screen when none selected, otherwise position according to currPanel
        x: root.currPanel >= 0 ? (root.currPanel * parent.height + root.paddingX / 2 + root.paddingX / 4) : -width

        anchors {
            verticalCenter: parent.verticalCenter
        }
        Behavior on x {
            SpringAnimation {
                spring: 90
                damping: 10
            }
        }
    }
    RectangularShadow {
        anchors.fill: highlight
        offset.x: 5
        offset.y: 5
        radius: highlight.radius
        blur: 30
        spread: 5
        visible: root.currPanel >= 0
        color: Qt.darker(highlight.color, 1.6)
    }

    Row {
        width: parent.height * 5
        height: parent.height
        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: repeater
            model: root.icons
            delegate: Rectangle {
                width: parent.height
                height: parent.height
                color: "transparent"
                anchors {
                    verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: root.currPanel = index
                }
                Loader {
                    anchors.centerIn: parent
                    sourceComponent: modelData
                }
            }
        }
    }
}
