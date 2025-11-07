pragma Singleton
import QtQuick

Singleton {
    id: sysStats

    property var cpuUsage: 0
    property var memoryUsage: 0
    property var diskUsage: 0
    property var temperature: 0

    function updateStats() {
        cpuUsage = Math.random() * 100;
        memoryUsage = Math.random() * 100;
        diskUsage = Math.random() * 100;
        temperature = Math.random() * 100;
    }
}
