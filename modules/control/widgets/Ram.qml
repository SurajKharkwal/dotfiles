import QtQuick
import QtQuick.Shapes
import qs.config

Rectangle {
    id: root
    implicitWidth: parent.width / 3
    implicitHeight: parent.height
    border.width: 1
    color: "lightgray"

    property real progress: 0.7
    property int iconSize: parent.width / 4
    property int center: iconSize / 2
    property int strokeWidth: 2
    property int radius: iconSize / 2 - strokeWidth

    property int totalMemory: 1024
    property int usedMemory: totalMemory / 4
    property int freeMemory: totalMemory - usedMemory
    property int bufferMemory: totalMemory / 8
    property int cachedMemory: totalMemory / 16

    Shape {
        width: root.width - 10
        height: width
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: Appearance.colors.primaryContianer
            fillColor: "transparent"
            startX: 0
            startY: 0
            PathAngleArc {
                centerX: root.center
                centerY: root.center
                startAngle: -90 + 20
                sweepAngle: 360
                radiusX: root.radius
                radiusY: root.radius
            }
        }
    }
}
