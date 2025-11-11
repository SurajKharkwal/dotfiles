pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: appearance
    property string theme: "light"
    property string font: "Arial"
    property int fontSize: 12
    property string colorsPath: Quickshell.shellDir + "/colors/material-colors.json"
    readonly property var colors: JSON.parse(jsonFile.text())

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl(appearance.colorsPath)
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }
}
