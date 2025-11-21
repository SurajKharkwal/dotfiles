import QtQuick
import Quickshell
import qs.modules.corner
import qs.config
import qs.assets.icons
import "./widgets"

Variants {
    model: Quickshell.screens
    delegate: PanelWindow {
        id: window
        property ShellScreen modelData
        // visible: modelData.name && Hyprland.focusedMonitor && modelData.name === Screen.name
        property int barHeight: 64
        property int roundCornerSize: 15
        anchors {
            top: true
            left: true
            right: true
        }
        exclusiveZone: barHeight - roundCornerSize
        implicitHeight: barHeight
        color: "transparent"
        Component.onCompleted: {
            console.log("PanelWindow completed", Screen.pixelDensity);
        }

        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
        }

        Rectangle {
            id: barBackground
            color: Appearance.colors.surface
            implicitHeight: window.implicitHeight - window.roundCornerSize
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                }
            }

            RoundCorner {
                corner: RoundCorner.CornerEnum.TopLeft
                anchors.left: parent.left
                implicitSize: window.roundCornerSize
            }

            RoundCorner {
                corner: RoundCorner.CornerEnum.TopLeft
                color: Appearance.colors.background
                implicitSize: window.roundCornerSize
                anchors {
                    left: parent.left
                    top: barBackground.bottom
                }
            }
            RoundCorner {
                corner: RoundCorner.CornerEnum.TopRight
                anchors.right: parent.right
                implicitSize: window.roundCornerSize
            }

            RoundCorner {
                corner: RoundCorner.CornerEnum.TopRight
                color: Appearance.colors.background
                implicitSize: window.roundCornerSize
                anchors {
                    right: parent.right
                    top: barBackground.bottom
                }
            }

            CenterControl {
                id: centerControl
                anchors.centerIn: parent
            }

            Battery {
                anchors {
                    left: centerControl.right
                    leftMargin: Appearance.tokens.common.spacing.xl
                    verticalCenter: parent.verticalCenter
                }
            }

            InternetSpeed {
                anchors {
                    right: centerControl.left
                    rightMargin: Appearance.tokens.common.spacing.sm
                    verticalCenter: parent.verticalCenter
                }
            }

            Row {
                height: parent.height
                rightPadding: Appearance.tokens.common.spacing.sm
                spacing: 10
                anchors {
                    right: parent.right
                    rightMargin: Appearance.tokens.common.spacing.md
                    verticalCenter: parent.verticalCenter
                }

                WifiStrong {
                    fillColor: Appearance.colors.onSurface
                    iconSize: Appearance.tokens.common.iconSize.md
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }

                Bluetooth {
                    fillColor: Appearance.colors.onSurface
                    iconSize: Appearance.tokens.common.iconSize.md
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }
                Power {
                    id: icon
                    fillColor: Appearance.colors.error
                    iconSize: Appearance.tokens.common.iconSize.lg
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
