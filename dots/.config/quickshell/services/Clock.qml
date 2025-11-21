pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: clockSingleton
    property string time: "00:00"
    property string date: "Mon, 01 Apr"

    Process {
        id: dateProc
        command: ["date"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text;
                const [day, month, dateNum, timeStr] = text.trim().replace(/\s+/g, " ").split(" ");
                clockSingleton.time = timeStr.slice(0, 5);
                clockSingleton.date = `${day}, ${dateNum} ${month}`;
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
