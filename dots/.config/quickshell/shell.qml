import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.launcher
import qs.modules.corner

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
}
