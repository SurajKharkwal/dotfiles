pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root
    property bool showOsd: false
    property bool onSliders: false

    function stop() {
        timer.stop();
    }
    function restart() {
        root.showOsd = true;
        timer.restart();
    }

    Timer {
        id: timer
        interval: 2000
        onTriggered: {
            // console.log(root.onSliders);
            if (root.onSliders)
                return;
            root.showOsd = false;
        }
    }
}
