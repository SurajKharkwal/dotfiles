import QtQuick
import QtQuick.Shapes
import qs.config

Item {
    id: root
    property real progress: 0.3       // 0 → 1
    property real temperature: 52       // dynamic value

    width: parent.width / 3
    height: parent.height

    // ---- Center Temperature Text ----
    Column {
        anchors.centerIn: shape
        spacing: height * 0.01

        Text {
            text: root.temperature + "°C"
            color: Appearance.colors.onSurface
            font.pixelSize: shape.height * 0.18
        }
    }

    // ---- Bottom Label ----
    Row {
        anchors.horizontalCenter: shape.horizontalCenter
        anchors.bottom: shape.bottom
        anchors.bottomMargin: shape.height * 0.08
        spacing: shape.height * 0.02

        Text {
            text: "CPU"
            color: Appearance.colors.onSurface
            font.pixelSize: shape.height * 0.09
        }

        Text {
            text: "Usage"
            color: Appearance.colors.onSurfaceVariant
            font.pixelSize: shape.height * 0.09
            font.weight: 300
        }
    }

    // ---- Arc Shape (speedometer gap at bottom) ----
    Shape {
        id: shape
        width: parent.width * 0.7
        height: width
        anchors.centerIn: parent
        preferredRendererType: Shape.CurveRenderer

        // background arc
        ShapePath {
            id: basePath
            strokeColor: Appearance.colors.secondaryContainer
            strokeWidth: 2
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: shape.width / 2
                centerY: shape.height / 2
                startAngle: -225     // creates bottom opening
                sweepAngle: 270
                radiusX: (shape.width / 2) - (basePath.strokeWidth / 2)
                radiusY: (shape.height / 2) - (basePath.strokeWidth / 2)
            }
        }

        // progress arc
        ShapePath {
            id: progressPath
            strokeColor: Appearance.colors.secondary
            strokeWidth: 10
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: shape.width / 2
                centerY: shape.height / 2
                startAngle: -225
                sweepAngle: 270 * root.progress
                radiusX: (shape.width / 2) - (progressPath.strokeWidth / 2)
                radiusY: (shape.height / 2) - (progressPath.strokeWidth / 2)
            }
        }
    }

    Rectangle {
        id: percentLabel
        color: Appearance.colors.surfaceContainerLowest
        implicitWidth: shape.width * 0.2
        implicitHeight: implicitWidth
        radius: width / 2

        Text {
            anchors.centerIn: parent
            text: Math.round(root.progress * 100) + "%"
            color: Appearance.colors.onSurface
            font.weight: 200
        }
        // position at arc endpoint
        property real angleDeg: -225 + (270 * root.progress)
        property real angleRad: angleDeg * Math.PI / 180

        x: shape.x + shape.width / 2 + Math.cos(angleRad) * ((shape.width / 2) - (progressPath.strokeWidth / 2)) - width / 2

        y: shape.y + shape.height / 2 + Math.sin(angleRad) * ((shape.height / 2) - (progressPath.strokeWidth / 2)) - height / 2
    }
}
