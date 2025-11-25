import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.launcher
import qs.modules.corner
import qs.modules.osd

ShellRoot {
    LazyLoader {
        active: true
        component: Bar {}
    }

    LazyLoader {
        active: true
        component: Launcher {}
    }

    LazyLoader {
        active: true
        component: Corner {}
    }

    LazyLoader {
        active: true
        component: Osd {}
    }
}
