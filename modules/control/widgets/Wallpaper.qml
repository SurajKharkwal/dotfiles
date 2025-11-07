import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
import qs.config

Item {
    id: root
    implicitWidth: parent.width
    implicitHeight: parent.height
    anchors.right: parent.right
    property list<string> wallpapers: []
    GridView {

        FolderListModel {
            id: folderModel
            folder: Qt.resolvedUrl(Quickshell.env("HOME") + "/Pictures/Wallpapers")
            nameFilters: ["*.jpg", "*.png", "*.jpeg"]
            onCountChanged: () => console.log("FolderModel count changed", folderModel.count)
        }

        model: folderModel
        delegate: Rectangle {
            id: fileDelegate
            required property string fileName
            width: 400
            height: 300
            Text {
                text: fileDelegate.fileName
            }
        }
    }
}
