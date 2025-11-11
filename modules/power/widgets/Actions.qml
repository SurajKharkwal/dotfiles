import QtQuick
import qs.config
import Quickshell
import Quickshell.Io

Grid {
    id: root
    property int iconSize: 78
    property int iconRadius: 16
    property int pixelSize: 22
    property string currentProfile

    spacing: 16

    Process {
        id: getPowerUsage
        running: true
        command: ["powerprofilesctl", "get"]

        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text.trim();
                const mapper = {
                    performance: "High",
                    balanced: "Balance",
                    "power-saver": "Saver"
                };
                root.currentProfile = mapper[text] || "Balance";
            }
        }
    }

    columns: 3
    Rectangle {
        color: root.currentProfile === "High" ? Appearance.colors.primary : Appearance.colors.surfaceContainer
        radius: root.iconRadius
        implicitWidth: root.iconSize
        implicitHeight: implicitWidth

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["powerprofilesctl", "set", "performance"]);
                root.currentProfile = "High";
            }
        }

        Text {
            text: ""
            color: root.currentProfile === "High" ? Appearance.colors.onPrimary : Appearance.colors.onSurface
            font.pixelSize: root.pixelSize
            anchors {
                top: parent.top
                topMargin: root.iconSize / 2 - height
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            text: "High"
            color: root.currentProfile === "High" ? Appearance.colors.onPrimary : Appearance.colors.onSurface
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: root.iconSize / 2 - height
            }
        }
    }
    Rectangle {
        color: root.currentProfile === "Balance" ? Appearance.colors.primary : Appearance.colors.surfaceContainer
        radius: root.iconRadius
        implicitWidth: root.iconSize
        implicitHeight: implicitWidth

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["powerprofilesctl", "set", "balanced"]);
                root.currentProfile = "Balance";
            }
        }
        Text {
            text: "󰾅"
            color: root.currentProfile === "Balance" ? Appearance.colors.onPrimary : Appearance.colors.onSurface
            font.pixelSize: root.pixelSize
            anchors {
                top: parent.top
                topMargin: root.iconSize / 2 - height
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            text: "Balance"
            color: root.currentProfile === "Balance" ? Appearance.colors.onPrimary : Appearance.colors.onSurface
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: root.iconSize / 2 - height
            }
        }
    }
    Rectangle {
        color: root.currentProfile === "Saver" ? Appearance.colors.primary : Appearance.colors.surfaceContainer
        radius: root.iconRadius
        implicitWidth: root.iconSize
        implicitHeight: implicitWidth

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["powerprofilesctl", "set", "power-saver"]);
                root.currentProfile = "Saver";
            }
        }
        Text {
            text: ""
            color: root.currentProfile === "Saver" ? Appearance.colors.onPrimary : Appearance.colors.onSurface
            font.pixelSize: root.pixelSize
            anchors {
                top: parent.top
                topMargin: root.iconSize / 2 - height
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            text: "Saver"
            color: root.currentProfile === "Saver" ? Appearance.colors.onPrimary : Appearance.colors.onSurface
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: root.iconSize / 2 - height
            }
        }
    }
    Rectangle {
        color: Appearance.colors.surfaceContainer
        radius: root.iconRadius
        implicitWidth: root.iconSize
        implicitHeight: implicitWidth

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["systemctl", "suspend"]);
            }
        }
        Text {
            text: "󰤄"
            color: Appearance.colors.onSurface
            font.pixelSize: root.pixelSize
            anchors {
                top: parent.top
                topMargin: root.iconSize / 2 - height
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            text: "Sleep"
            color: Appearance.colors.onSurface
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: root.iconSize / 2 - height
            }
        }
    }
    Rectangle {
        color: Appearance.colors.surfaceContainer
        radius: root.iconRadius
        implicitWidth: root.iconSize
        implicitHeight: implicitWidth
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["systemctl", "reboot"]);
            }
        }
        Text {
            text: "󰜉"
            color: Appearance.colors.onSurface
            font.pixelSize: root.pixelSize
            anchors {
                top: parent.top
                topMargin: root.iconSize / 2 - height
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            text: "Reboot"
            color: Appearance.colors.onSurface
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: root.iconSize / 2 - height
            }
        }
    }
    Rectangle {
        color: Appearance.colors.surfaceContainer
        radius: root.iconRadius
        implicitWidth: root.iconSize
        implicitHeight: implicitWidth
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                Quickshell.execDetached(["systemctl", "poweroff"]);
            }
        }
        Text {
            text: ""
            color: Appearance.colors.error
            font.pixelSize: root.pixelSize
            anchors {
                top: parent.top
                topMargin: root.iconSize / 2 - height
                horizontalCenter: parent.horizontalCenter
            }
        }
        Text {
            text: "Poweroff"
            color: Appearance.colors.error
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: root.iconSize / 2 - height
            }
        }
    }
}
