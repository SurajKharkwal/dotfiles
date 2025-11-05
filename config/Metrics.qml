pragma Singleton

import QtQuick
import Quickshell

// property
Singleton {
    property int barHeight: 64
    property int barWidth: 800
    property int barTopMargin: 36
    property int barXPadding: 36

    property int workspaceMargin: 10
    property int workspaceElementSize: 32
    property int workspaceHeight: workspaceElementSize + workspaceMargin
    property int workspaceWidth: workspaceElementSize * 10 + workspaceMargin

    property int batteryWidth: 100
    property int batteryHeight: 40
    property int batteryIconSize: 20

    property int controlBtnOffset: 12
    property int controlBtnSize: 40
    property bool openControlPanel: false
    property int controlPanelWidth: 1000
    property int controlPanelHeight: 500
    property int controlPanelTopOffset: 40
    property int controlSidebarWidth: 100
    property int controlPageIndex: 0

    property int sidebarPadY: 32

    property int osdPanelWidth: 220
    property int osdPanelHeight: 300
    property int osdPanelRightMargin: 20
    property int osdPanelXPad: 30
    property int osdSliderHeight: 200
    property int osdSliderWidth: 60
}
