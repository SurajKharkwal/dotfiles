pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    property bool openOsd: false

    function restart() {
        root.openOsd = true;
        timer.restart();
    }

    function stop() {
        root.openOsd = true;
        timer.stop();
    }

    Timer {
        id: timer
        interval: 2000
        running: false
        onTriggered: {
            root.openOsd = false;
        }
    }
}
