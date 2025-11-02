import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.services

Rectangle {
    id: root
    color: "transparent"

    Profile {
        implicitWidth: parent.implicitWidth
        implicitHeight: 48
        radius: 10
        color: Appearance.colors.surfaceContainer
        anchors.bottom: parent.bottom
    }

    Column {
        id: btnColumn
        spacing: 10
        anchors.top: parent.top
        anchors.topMargin: 32
        width: parent.implicitWidth

        Repeater {
            model: ["󰋜  Home", "󰲍  Wallpapers"]
            delegate: Rectangle {
                id: settingBtn
                property int btnIndex: index
                property string btnText: modelData
                property bool hovered: false

                implicitWidth: parent.width
                implicitHeight: 40
                radius: 8
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                color: Config.currSettingIndex == btnIndex ? Appearance.colors.primary : hovered ? Appearance.colors.primaryContainer : "transparent"

                Text {
                    id: btnLabel
                    text: settingBtn.btnText
                    anchors.centerIn: parent
                    font.pixelSize: 16
                    color: Config.currSettingIndex == settingBtn.btnIndex ? Appearance.colors.onPrimary : settingBtn.hovered ? Appearance.colors.onPrimaryContainer : Appearance.colors.onSurface

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Config.currSettingIndex = settingBtn.btnIndex
                    onEntered: settingBtn.hovered = true
                    onExited: settingBtn.hovered = false
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
