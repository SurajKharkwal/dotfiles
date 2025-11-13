import QtQuick
import Quickshell
import Quickshell.Io

Grid {
    id: root
    property int iconSize: 100
    property int iconRadius: 16
    property int pixelSize: 22
    property int currentProfile: 1

    spacing: 16

    Process {
        id: getPowerUsage
        running: true
        command: ["powerprofilesctl", "get"]

        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text.trim();
                const mapper = {
                    performance: 1,
                    balanced: 2,
                    "power-saver": 3
                };
                root.currentProfile = mapper[text] || 2;
            }
        }
    }

    Component {
        id: template
        Rectangle {}
    }
    columns: 3

    PowerButton {
        active: root.currentProfile == 1
        icon: ""
        text: "High"
        onHandleClick: {
            Quickshell.execDetached(["powerprofilesctl", "set", "performance"]);
            root.currentProfile = 1;
        }
    }
    PowerButton {
        active: root.currentProfile == 2
        icon: "󰾅"
        text: "Balanced"
        onHandleClick: {
            Quickshell.execDetached(["powerprofilesctl", "set", "balanced"]);
            root.currentProfile = 2;
        }
    }
    PowerButton {
        active: root.currentProfile == 3
        icon: "󱟤"
        text: "Saver"
        onHandleClick: {
            Quickshell.execDetached(["powerprofilesctl", "set", "power-saver"]);
            root.currentProfile = 3;
        }
    }

    PowerButton {
        icon: "󰤄"
        text: "Sleep"
        onHandleClick: {
            Quickshell.execDetached(["systemctl", "suspend"]);
        }
    }

    PowerButton {
        icon: "󰜉"
        text: "Reboot"
        onHandleClick: {
            Quickshell.execDetached(["systemctl", "reboot"]);
        }
    }

    PowerButton {
        icon: ""
        text: "Poweroff"
        highlight: true
        onHandleClick: {
            Quickshell.execDetached(["systemctl", "poweroff"]);
        }
    }
}
