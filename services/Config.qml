pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    // Bar Panel config
    property bool hadPendingReqToCloseBar: false
    property int barHiddenPixel: 2
    property int barPanelImplicitWidth: 800
    property int barPanelImplicitHeight: 100
    property int barImplicitHeight: 64
    property int barImplicitWidth: 800
    property int barTopMargin: 32
    property int xPad: 32

    // Controls
    property bool showControlsPopUp: false
    property int controlsRectWidth: 1000
    property int controlsRectHeight: 500
    property int controlsPopUpWidth: 1000
    property int controlsPopUpHeight: 500
    property bool relativeX: barImplicitWidth
    property bool showProfile: false
    property int currSettingIndex: 0
    property int settings: 2

    // Osd
    property int osdPanelWidth: 232
    property int osdPanelHeight: 300
    property int osdImplicitWidth: 200
    property int osdImplicitHeight: 300
    property int osdHoverLeftMargin: 230

    // Single Time instance
    property bool showPowerMenu: false
    property string timeText: "12: 00"
    property string dateText: "01, Sun Jan"

    // Power Menu
    property int powerMenuWidth: 150
    property int powerMenuHeight: 186
    Process {
        id: dateProc
        command: ["date"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const text = this.text;
                const [day, month, date, time] = text.trim().replace(/\s+/g, " ").split(" ");
                // console.log(text);
                root.timeText = time.slice(0, 5);
                root.dateText = `${day}, ${date} ${month} `;
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
    function exec(cmd: list<string>) {
        execCommand.exec(cmd);
    }
    Process {
        id: execCommand
    }
}
