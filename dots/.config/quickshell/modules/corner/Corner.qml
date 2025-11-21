import QtQuick
import Quickshell

Variants {
    model: Quickshell.screens

    delegate: PanelWindow {
        implicitHeight: 15
        exclusiveZone: 0
        color: "transparent"
        anchors {
            bottom: true
            left: true
            right: true
        }

        RoundCorner {
            implicitSize: 15
            corner: RoundCorner.CornerEnum.BottomLeft
        }

        RoundCorner {
            implicitSize: 15
            corner: RoundCorner.CornerEnum.BottomRight
            anchors {
                right: parent.right
            }
        }
    }
}
