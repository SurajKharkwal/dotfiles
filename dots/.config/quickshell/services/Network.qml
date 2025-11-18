pragma Singleton

import QtQuick
import Quickshell.Io
import Quickshell

Singleton {
    id: root

    property string interfaceName: ""
    property int previousBytes: 0
    property int downloadSpeed: 0

    function getSpeed() {
        const bytes = downloadSpeed;
        if (bytes <= 0)
            return {
                speed: "0.0",
                unit: "KB/s"
            };

        const k = 1024;
        const sizes = ["KB/s", "MB/s", "GB/s", "TB/s"];

        let value = bytes / k;
        let i = 0;

        while (value >= k && i < sizes.length - 1) {
            value /= k;
            i++;
        }

        return {
            speed: value.toFixed(1),
            unit: sizes[i]
        };
    }

    Process {
        id: getInterface
        running: true
        command: ["bash", "-c", "nmcli -t -f DEVICE,STATE,TYPE d | grep ':connected' | grep -v ':loopback' | cut -d: -f1"]
        stdout: StdioCollector {
            onStreamFinished: root.interfaceName = this.text.trim()
        }
    }

    Process {
        id: readBytes
        command: ["bash", "-c", `cat /proc/net/dev | grep "${root.interfaceName}" | awk '{print $2}'`]
        stdout: StdioCollector {
            onStreamFinished: {
                const current = parseInt(this.text);
                if (root.previousBytes > 0)
                    root.downloadSpeed = current - root.previousBytes;
                root.previousBytes = current;
            }
        }
    }

    Timer {
        interval: 1000
        running: root.interfaceName !== ""
        repeat: true
        onTriggered: readBytes.running = true
    }
}
