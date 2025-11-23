import QtQuick
import Quickshell
import qs.modules.corner
import qs.config
import qs.assets.icons
import Quickshell.Widgets
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

            Row {
                anchors.centerIn: parent
                spacing: Appearance.tokens.common.spacing.lg
                height: parent.height

                QuickactionLeft {
                    id: quickactionLeft
                    anchors.verticalCenter: parent.verticalCenter
                }
                CenterControl {
                    id: centerControl
                    anchors.verticalCenter: parent.verticalCenter
                }
                Battery {
                    id: battery
                    anchors.verticalCenter: parent.verticalCenter
                }
                QuickactionRight {
                    id: quickactionRight
                    anchors.verticalCenter: parent.verticalCenter
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

                InternetSpeed {
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
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
                WrapperMouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: Quickshell.execDetached(["systemctl", "poweroff"])
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
}
