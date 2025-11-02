import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Column {
    id: root
    Text {
        id: timeText
        text: "12:00"
        color: Appearance.colors.onBackground
        font.pixelSize: 16
        font.bold: true
    }
    Text {
        id: dateText
        text: "Mon, 01 Jan"
        font.weight: 300
        color: Appearance.colors.onBackground
    }

    Process {
        id: dateProc
        command: ["date"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text;
                const [day, month, date, time] = text.trim().replace(/\s+/g, " ").split(" ");
                // console.log(text);
                timeText.text = time.slice(0, 5);
                dateText.text = `${day}, ${date} ${month} `;
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
