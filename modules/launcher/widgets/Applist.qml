import QtQuick
import Quickshell.Widgets
import Quickshell
import qs.config
import qs.services

ClippingRectangle {
    id: root
    color: "transparent"
    property list<DesktopEntry> apps

    Connections {
        target: Launcher
        function onCurrAppIdxChanged() {
            listView.positionViewAtIndex(Launcher.currAppIdx, ListView.End);
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        leftMargin: 20
        rightMargin: 20
        model: root.apps
        currentIndex: Launcher.currAppIdx + 1
        highlightMoveDuration: 0

        delegate: Rectangle {
            color: {
                if (Launcher.displayApps[Launcher.currAppIdx].name === modelData.name)
                    return Appearance.colors.primary;
                else if (mouseArea.containsMouse)
                    return Appearance.colors.surfaceContainerHigh;
                return "transparent";
            }
            implicitHeight: 64
            implicitWidth: 560 //  parent.width not works idk why
            radius: 8
            MouseArea {
                id: mouseArea
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    modelData.execute();
                    Launcher.close();
                }
            }
            IconImage {
                id: iconImage
                implicitSize: 40
                anchors {
                    left: parent.left
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
                source: Launcher.iconFilter(modelData.icon)
            }
            Text {
                id: text
                text: modelData.name
                font.pointSize: 14
                font.family: Appearance.font
                color: {
                    if (Launcher.displayApps[Launcher.currAppIdx]) {
                        if (Launcher.displayApps[Launcher.currAppIdx].name === modelData.name) {
                            return Appearance.colors.onPrimary;
                        }
                    }
                    return Appearance.colors.onSurface;
                }
                anchors {
                    left: iconImage.right
                    top: parent.top
                    topMargin: 10
                    leftMargin: 20
                }
            }
            Text {
                id: commentText
                text: modelData.comment
                font.pointSize: 12
                font.weight: 300
                color: {
                    if (Launcher.displayApps[Launcher.currAppIdx]) {
                        if (Launcher.displayApps[Launcher.currAppIdx].name === modelData.name) {
                            return Appearance.colors.onPrimary;
                        }
                    }
                    return Appearance.colors.onSurface;
                }
                anchors {
                    left: iconImage.right
                    bottom: parent.bottom
                    bottomMargin: 10
                    leftMargin: 20
                }
            }
        }
    }
}
