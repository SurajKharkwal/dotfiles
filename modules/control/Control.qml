import QtQuick
import Quickshell.Widgets
import qs.config
import qs.modules.control.widgets

ClippingRectangle {
    id: root
    anchors {
        fill: parent
    }
    color: Appearance.colors.background
    radius: 32

    ClippingRectangle {
        id: nav
        implicitWidth: Metrics.controlSidebarWidth
        implicitHeight: parent.height
        color: "transparent"
        anchors.left: parent.left
        Navbar {}
    }

    ClippingRectangle {
        color: Appearance.colors.surfaceContainerLowest
        implicitWidth: parent.width - Metrics.controlSidebarWidth
        implicitHeight: parent.height
        anchors.left: nav.right
        radius: 32

        Column {
            width: parent.width
            height: parent.height
            anchors {
                top: parent.top
                topMargin: -Metrics.controlPageIndex * Metrics.controlPanelHeight
            }
            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
            Home {}
            Wallpaper {}
            Stats {}
            IOdevice {}
        }
    }
}
