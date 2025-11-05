pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: clockSingleton
    property string timeText: ""
    property string dateText: ""

    Process {
        id: dateProc
        command: ["date"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text;
                const [day, month, date, time] = text.trim().replace(/\s+/g, " ").split(" ");
                // console.log(text);
                clockSingleton.timeText = time.slice(0, 5);
                clockSingleton.dateText = `${day}, ${date} ${month} `;
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
