pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string colorsPath: Quickshell.shellDir + "/colors/material-colors.json"
    readonly property var colors: JSON.parse(jsonFile.text())
    Component.onCompleted: {
        console.log(colorsPath);
        console.log("Component completed");
    }

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl(root.colorsPath)
        blockLoading: true
        watchChanges: true
        onFileChanged: this.reload()
    }
}
