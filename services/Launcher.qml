pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    // TODO:  execute app that runs in terminals

    property bool openPanel: false
    property int currAppIdx: 0
    property list<string> discludeApps: ["Avahi Zeroconf Browser", "Avahi SSH Server Browser", "Avahi VNC Server Browser"]
    property list<DesktopEntry> allApps: Array.from(DesktopEntries.applications.values).filter(app => !discludeApps.includes(app.name)).sort((a, b) => a.name.toLowerCase().localeCompare(b.name.toLowerCase()))

    property list<DesktopEntry> displayApps: allApps

    function iconFilter(iconName) {
        if (!iconName || iconName.length == 0)
            return false;
        return Quickshell.iconPath(iconName, true);
    }

    function open() {
        currAppIdx = 0;
        openPanel = true;
        displayApps = allApps;
    }

    function close() {
        currAppIdx = 0;
        openPanel = false;
        displayApps = allApps;
    }

    function toggle() {
        openPanel ? close() : open();
    }

    function next() {
        currAppIdx = Math.min(currAppIdx + 1, displayApps.length - 1);
    }

    function prev() {
        currAppIdx = Math.max(currAppIdx - 1, 0);
    }

    function query(appName: string) {
        const queryStr = appName.toLowerCase();
        displayApps = allApps.filter(app => app.name.toLowerCase().includes(queryStr)).sort((a, b) => a.name.toLowerCase().localeCompare(b.name.toLowerCase()));
        currAppIdx = 0;
    }

    function executeCurrApp() {
        if (displayApps.length > 0)
            displayApps[currAppIdx].execute();
    }
}
