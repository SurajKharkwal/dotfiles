pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel

Singleton {
    id: root

    property string path1: "/usr/share/applications"
    property string path2: Quickshell.env("HOME") + "/.local/share/applications"
    property list<AppItem> apps

    component AppItem: QtObject {
        property string name
        property string icon
        property string exec
        property string comment

        function launch() {
            const cleanedExec = exec.replace(/%[UuFf]/g, "").trim();
            Quickshell.execDetached(cleanedExec);
        }
    }

    FolderListModel {
        id: folder1
        folder: root.path1
        nameFilters: ["*.desktop"]
        showDirs: false
        onCountChanged: get.running = true
    }

    FolderListModel {
        id: folder2
        folder: root.path2
        nameFilters: ["*.desktop"]
        showDirs: false
        onCountChanged: get.running = true
    }

    Process {
        id: get
        command: ["sh", "-c", "~/.config/quickshell/scripts/get-apps.sh"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const files = this.text.split("\n");
                for (const file of files) {
                    const [name, icon, exec, comment] = file.split("#");
                    const app = appItemComponent.createObject(root, {
                        name: name,
                        icon: icon,
                        exec: exec,
                        comment: comment
                    });
                    root.apps.push(app);
                }
                console.log("Apps loaded successfully", root.apps.length);
            }
        }
    }

    Component {
        id: appItemComponent
        AppItem {}
    }
}
