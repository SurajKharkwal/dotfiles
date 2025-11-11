import QtQuick
import Quickshell.Widgets
import QtQuick.Shapes
import qs.config

ClippingRectangle {
    id: root

    property int iconSize: 24
    property int strokeWidth: 2
    property int radius: iconSize / 2 - strokeWidth
    property real center: iconSize / 2

    width: iconSize
    height: iconSize
    color: "transparent"

    Shape {
        anchors.centerIn: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: Appearance.colors.onSurface
            strokeWidth: root.strokeWidth
            fillColor: "transparent"

            PathAngleArc {
                centerX: root.center
                centerY: root.center
                startAngle: 0
                sweepAngle: 360
                radiusX: root.radius
                radiusY: root.radius
            }
        }
    }

    Rectangle {
        id: tail
        width: 8
        height: 2
        color: Appearance.colors.onSurface
        antialiasing: true
        rotation: 45
        transformOrigin: Item.Center

        property real offset: root.radius + 3

        x: root.center + offset * Math.cos(45 * Math.PI / 180) - width / 2
        y: root.center + offset * Math.sin(45 * Math.PI / 180) - height / 2
    }
}
