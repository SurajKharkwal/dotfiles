pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property bool openOsd: false
    property PwNode sink: Pipewire.defaultAudioSink

    readonly property real volume: sink?.audio.volume ?? 0
    readonly property bool muted: sink?.audio.muted ?? false
    property int brightness: 0

    PwObjectTracker {
        objects: [root.sink]
    }

    Timer {
        id: osdTimer
        interval: 2000
        onTriggered: root.openOsd = false
    }

    function clamp(min, max, v) {
        return Math.max(min, Math.min(max, v));
    }

    function setVolume(v) {
        osdTimer.restart();
        if (!root.sink)
            return;
        root.sink.audio.muted = false;
        root.sink.audio.volume = clamp(0, 1, v);
    }

    function setBrightness(v) {
        Quickshell.execDetached(["sh", "-c", `brightnessctl -s set ${v}%`]);
    }


    IpcHandler {
        target: "osdBrightness"
        function handleChange(v) {
            osdTimer.restart();
            const val = clamp(0, 100, root.brightness + v);
            root.brightness = val;
            root.setBrightness(val);
        }
    }

    Process {
        running: true
        command: ["sh", "-c", "brightnessctl -m | awk -F, '{gsub(/%/, \"\", $4); print $4}'"]
        stdout: StdioCollector {
            onStreamFinished: root.brightness = parseInt(text.trim())
        }
    }
}
