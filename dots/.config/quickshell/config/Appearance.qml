pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string theme: "light"
    property string font: myfont.name
    property int fontSize: 12
    property string colorsPath: Quickshell.shellDir + "/colors/material-colors.json"
    property string metricsPath: Quickshell.shellDir + "/config/Metrics.json"
    readonly property var colors: JSON.parse(jsonFile.text())
    readonly property var metrics: JSON.parse(metricsFile.text())

    FileView {
        id: metricsFile
        path: root.metricsPath
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl(root.colorsPath)
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }
    FontLoader {
        id: myfont
        source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/fonts/Quicksand.ttf")
        // source: "Jet BrainMono"
    }
}
