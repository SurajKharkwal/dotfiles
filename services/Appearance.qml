pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property int radius: 44
    property string homeDir: Quickshell.shellDir
    property string colorsPath: homeDir + "/colors/material-colors.json"
    readonly property var colors: JSON.parse(jsonFile.text())
    FileView {
        id: jsonFile
        path: Qt.resolvedUrl(root.colorsPath)
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }
}
