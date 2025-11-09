pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool openPanel: false
    property bool onButton: false
    property string currentProfile: ""

    function onEnteredBtn() {
        timer.stop();
        root.openPanel = true;
        root.onButton = true;
    }
    function onExitedBtn() {
        root.onButton = false;
        timer.restart();
    }

    function open() {
        root.openPanel = true;
        timer.stop();
    }

    function close() {
        timer.restart();
    }

    Process {
        id: probe
        running: true
        command: ["powerprofilesctl", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                const map = {
                    performance: "Performance",
                    balanced: "Balanced",
                    "power-saver": "PowerSaver"
                };
                root.currentProfile = map[this.text.trim()];
            }
        }
    }
    Timer {
        id: timer
        interval: 300
        running: false
        onTriggered: {
            if (root.onButton)
                return;
            root.openPanel = false;
        }
    }
}
