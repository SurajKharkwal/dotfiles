import QtQuick
import QtQuick.Controls
import qs.config
import qs.services
import Quickshell

TextField {
    id: searchInput

    placeholderText: "Type to search applications..."
    placeholderTextColor: Appearance.colors.onSurfaceVariant
    color: Appearance.colors.onSurface
    leftPadding: 72
    focus: true
    text: Launcher.openPanel ? "" : ""   // reset when toggle the panel
    Keys.onPressed: event => {
        if (event.modifiers & Qt.ControlModifier) {
            if (event.key === Qt.Key_N)
                Launcher.next();
            else if (event.key === Qt.Key_P)
                Launcher.prev();
        }

        if (event.key === Qt.Key_Up)
            Launcher.prev();

        if (event.key === Qt.Key_Down)
            Launcher.next();

        if (event.key === Qt.Key_Return) {
            Launcher.executeCurrApp();
            Launcher.close();
        }
        if (event.key === Qt.Key_Escape) {
            Launcher.close();
        }
    }

    onTextChanged: 
        Launcher.query(text);

    SearchIcon {
        id: searchIcon
        implicitWidth: 40
        implicitHeight: 40
        anchors {
            left: parent.left
            leftMargin: 32
            verticalCenter: parent.verticalCenter
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
