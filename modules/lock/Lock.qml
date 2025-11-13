import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "./widgets"

Scope {
    id: root
    property bool locked: false
    LockContext {
        id: lockContext
        onUnlocked: {
            root.locked = false;
        }
    }

    GlobalShortcut {
        appid: "qs"
        name: "lock"
        onPressed: {
            root.locked = true;
        }
    }

    WlSessionLock {
        id: lock
        locked: root.locked

        WlSessionLockSurface {
            color: "transparent"

            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
