import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.osd
import qs.modules.launcher
import qs.modules.power

ShellRoot {
    LazyLoader {
        active: true
        component: Bar {}
    }
    LazyLoader {
        active: true
        component: Osd {}
    }

    LazyLoader {
        active: true
        component: Power {}
    }

    LazyLoader {
        active: true
        component: Launcher {}
    }
}
