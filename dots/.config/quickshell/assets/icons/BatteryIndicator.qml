import QtQuick
import QtQuick.Shapes
import qs.config

Item {
    id: root

    property real progress: 0.7
    property int iconSize: 24
    property int center: iconSize / 2
    property int strokeWidth: 2
    property int radius: iconSize / 2 - strokeWidth

    width: iconSize
    height: iconSize
    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            strokeColor: root.progress > 0.2 ? Appearance.colors.surfaceContainerHigh : Appearance.colors.errorContainer
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            PathAngleArc {
                centerX: root.center
                centerY: root.center
                startAngle: -90 + 20
                sweepAngle: 360
                radiusX: root.radius
                radiusY: root.radius
            }
        }
        ShapePath {
            strokeColor: root.progress > 0.2 ? Appearance.colors.onSurface : Appearance.colors.onErrorContainer
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            PathAngleArc {
                centerX: root.center
                centerY: root.center
                startAngle: -90 + 20
                sweepAngle: 360 * root.progress
                radiusX: root.radius
                radiusY: root.radius
            }
        }
    }
}
