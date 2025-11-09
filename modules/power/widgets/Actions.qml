import QtQuick
import QtQuick.Controls

Rectangle {
    id: root

    Text {
        id: parentLabel
        width: 40
        anchors {
            centerIn: parent
        }
        text: "Actions"
    }

    Column {
        id: btnCol

        anchors {
            left: parent.left
            right: parent.right
            top: parentLabel.bottom
            bottom: parent.bottom
        }
    }
}
