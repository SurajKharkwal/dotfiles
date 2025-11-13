import QtQuick
import qs.config

Item {
    id: root
    width: 5 * 50
    height: parent.height
    property int selectedIndex: 2
    property list<string> icons: ["", "󱨇", "󰉏", "", "󰋎"]

    Rectangle {
        id: highlight
        width: 50
        height: 4
        color: Appearance.colors.primary
        x: selectedIndex * width
        Behavior on x {
            SpringAnimation {
                spring: 90
                damping: 10
            }
        }
    }

    Row {
        width: 5 * 50
        height: parent.height

        Repeater {
            id: repeater
            model: root.icons
            delegate: Rectangle {
                property int iconSize: 50
                property int selected: root.selectedIndex === index
                width: iconSize
                height: iconSize
                color: "transparent"
                opacity: selected ? 1 : 0.4
                anchors {
                    verticalCenter: parent.verticalCenter
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 400
                    }
                }

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: root.selectedIndex = index
                }
                Text {
                    text: modelData
                    font.pixelSize: 26
                    font.family: Appearance.font
                    color: selected ? Appearance.colors.primary : Appearance.colors.onSurface
                    anchors.centerIn: parent
                }
            }
        }
    }
}
