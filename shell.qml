import QtQuick
import Quickshell
import qs.modules.bar
import qs.modules.osd

ShellRoot {
    LazyLoader {
        active: true
        component: Bar {}
    }
    LazyLoader {
        active: true
        component: Osd {}
    }
}
