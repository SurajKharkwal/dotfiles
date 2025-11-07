import QtQuick
import Quickshell.Widgets
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel
import qs.config

GridView {
    id: root

    property string basePath: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    property string currWall

    // Size cells relative to the view size (no hardcoded pixels)
    cellWidth: width * 0.25
    cellHeight: height * 0.35
    cacheBuffer: 1000
    anchors {
        margins: 10
    }

    Process {
        id: get
        command: ["swww", "query"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const output = this.text.trim().split(" ");
                root.currWall = output[output.length - 1];
                console.log("Current wallpaper:", root.currWall);
            }
        }
    }

    FolderListModel {
        id: folderModel
        folder: Qt.resolvedUrl(root.basePath)
        nameFilters: ["*.jpg", "*.png", "*.jpeg"]
    }
    model: folderModel

    delegate: ClippingRectangle {
        id: fileDelegate
        required property string fileName
        radius: 16

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                Quickshell.execDetached(["sh", "-c", "~/.config/quickshell/scripts/set-wallpaper.sh --set " + root.basePath + "/" + fileDelegate.fileName]);
                root.currWall = root.basePath + "/" + fileDelegate.fileName;
                console.log("Current wallpaper:", root.currWall);
            }
        }

        implicitWidth: root.cellWidth
        implicitHeight: root.cellHeight
        color: root.currWall == root.basePath + "/" + fileDelegate.fileName ? Appearance.colors.surfaceContainerHighest : mouseArea.containsMouse ? Appearance.colors.surfaceContainerHigh : "transparent"          // no border

        // visual margins inside each cell
        property int itemMargin: Math.round(Math.min(width, height) * 0.06)

        // filename label
        Text {
            id: label
            text: fileDelegate.fileName
            color: Appearance.colors.onSurface
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            width: parent.width - (fileDelegate.itemMargin * 2)
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: fileDelegate.itemMargin
            }
        }

        // rounded thumbnail area with margins
        ClippingWrapperRectangle {
            id: wrapper
            // color: "transparent"
            radius: 16
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: label.top
                topMargin: fileDelegate.itemMargin
                leftMargin: fileDelegate.itemMargin
                rightMargin: fileDelegate.itemMargin
                bottomMargin: fileDelegate.itemMargin / 2
            }

            IconImage {
                asynchronous: true
                anchors.fill: parent
                source: Qt.resolvedUrl(root.basePath + "/" + fileDelegate.fileName)
            }
        }
    }
}
