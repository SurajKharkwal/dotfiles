import QtQuick

Rectangle {
    color: "transparent"
    width: parent.width
    height: parent.height

    AnimatedImage {
        id: gif
        source: "/home/flyinghawk/.config/quickshell/assets/gif/anime-dance.gif"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        smooth: true

        width: parent.width
        height: parent.height
    }
}
