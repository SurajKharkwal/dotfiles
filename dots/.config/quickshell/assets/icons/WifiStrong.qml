import QtQuick
import QtQuick.Shapes

Item {
    id: root

    property int iconSize: 24
    property real iconOpacity: 1
    property color fillColor: "#ffe3e3e3"
    property color strokeColor: "transparent"

    implicitWidth: iconSize
    implicitHeight: iconSize

    component AnimationsInfo: QtObject {
        property bool paused: false
        property int loops: 1
        signal restart
    }
    property AnimationsInfo animations: AnimationsInfo {}

    transform: [
        Translate {
            x: 0
            y: 960
        },
        Scale {
            xScale: root.width / 960
            yScale: root.height / 960
        }
    ]

    Shape {
        preferredRendererType: Shape.CurveRenderer
        opacity: root.opacity

        ShapePath {
            strokeColor: root.strokeColor
            fillColor: root.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles

            PathSvg {
                path: "M 480 -120 L 0 -600 Q 95 -697 219.5 -748.5 Q 344 -800 480 -800 Q 616 -800 740.5 -748.5 Q 865 -697 960 -600 L 480 -120"
            }
        }
    }
}
