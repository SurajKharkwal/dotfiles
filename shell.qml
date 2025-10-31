import QtQuick
import Quickshell

import qs.panels

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
