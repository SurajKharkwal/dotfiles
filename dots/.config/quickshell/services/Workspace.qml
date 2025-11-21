pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root
    property var workspaces: Hyprland.workspaces
    property var groups: []     // [[1,2], [5,6], [8]]
    property var activeIds: []  // [1,2,5,6,8]
    property int focused: 1
    function activate(id: int) {
        const cmd = ["hyprctl", "dispatch", "workspace", id];
        Quickshell.execDetached(cmd);
    }
    function updateGroups() {
        // get all workspace ids with windows
        let actives = [];
        for (const w of workspaces.values) {
            if (w.toplevels.values.length > 0)
                actives.push(w.id);
            if (w.focused)
                focused = w.id;
        }
        actives.sort((a, b) => a - b);
        activeIds = actives;
        // group consecutive ids (e.g. [1,2,5,6,8] -> [[1,2],[5,6],[8]])
        let g = [];
        let current = [];
        for (let i = 0; i < actives.length; i++) {
            if (current.length === 0) {
                current.push(actives[i]);
            } else if (actives[i] === current[current.length - 1] + 1) {
                current.push(actives[i]);
            } else {
                g.push(current);
                current = [actives[i]];
            }
        }
        if (current.length > 0)
            g.push(current);
        groups = g;
    }
    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent): void {
            // only update when workspace or window event occurs
            if (event.name.startsWith("workspace") || event.name.startsWith("openwindow") || event.name.startsWith("closewindow")) {
                root.updateGroups();
                // console.log(root.groups);
            }
        }
    }
    Component.onCompleted: updateGroups()
}
