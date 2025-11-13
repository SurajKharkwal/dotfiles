import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Wayland
import "root:/config"

Rectangle {
    id: root
    required property LockContext context
    property string wallpaperPath: ""
    color: "transparent"
    opacity: 0
    Behavior on opacity {
        NumberAnimation {
            duration: 1000
        }
    }

    Process {
        id: getWallpaper
        running: true
        command: ["bash", "-c", "swww query | grep -oP 'image: \\K.*'"]
        stdout: StdioCollector {
            id: wallpaperCollector
            onStreamFinished: {
                root.wallpaperPath = wallpaperCollector.text.trim();
                console.log("Wallpaper path:", root.wallpaperPath);
                root.opacity = 1;
            }
        }
    }

    Image {
        asynchronous: true
        anchors.fill: parent
        source: Qt.resolvedUrl(root.wallpaperPath)
        fillMode: Image.PreserveAspectCrop
        visible: root.wallpaperPath !== ""
    }

    Button {
        text: "Its not working, let me out"
        anchors.centerIn: parent
        onClicked: root.context.unlocked()
    }
}
