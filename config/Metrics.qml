pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

// property
Singleton {
    property HyprlandMonitor screen: Hyprland.focusedMonitor
    property int barHeight: Math.min(screen.height * 0.058, 100)
    property int barWidth: Math.min(screen.width * 0.45, 1200)
    property int barTopMargin: screen.width * 0.02
    property int barXPadding: 36

    // clock
    property int clockTimeFontSize: barHeight * 0.3
    property int clockDateFontSize: barHeight * 0.2

    property int workspaceMargin: 10
    property int workspaceElementSize: barHeight * 0.45
    property int workspaceHeight: workspaceElementSize + workspaceMargin
    property int workspaceWidth: workspaceElementSize * 10 + workspaceMargin

    property int batteryWidth: barWidth * 0.12
    property int batteryHeight: barHeight * 0.6
    property int batteryIconSize: 20

    property int controlBtnOffset: 12
    property int controlBtnSize: barHeight * 0.55
    property bool openControlPanel: false
    property int controlPanelWidth: Math.min(screen.width * 0.6, 1400)
    property int controlPanelHeight: Math.min(screen.height * 0.4, 600)
    property int controlPanelTopOffset: 40
    property int controlSidebarWidth: screen.width * 0.05
    property int controlPageIndex: 0
    property list<var> controlOpts: [
        {
            label: "Home",
            icon: "",
            index: 0
        },
        {
            label: "Wallpaper",
            icon: "",
            index: 1
        },
        {
            label: "Stats",
            icon: "󰾆",
            index: 2
        },
        {
            label: "Devices",
            icon: "i|o",
            index: 3
        }
    ]

    property int sidebarPadY: 32

    property int osdPanelWidth: 220
    property int osdPanelHeight: 300
    property int osdPanelRightMargin: 20
    property int osdPanelXPad: 30
    property int osdSliderHeight: 200
    property int osdSliderWidth: 60

    property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/Wallpapers"
}
