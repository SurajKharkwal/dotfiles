import QtQuick
import QtQuick.Shapes

Item {
    id: __qt_toplevel
    property int iconSize: 24
    property color strokeColor: "transparent"
    property color fillColor: "#ffe3e3e3"
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
            xScale: __qt_toplevel.width / 960
            yScale: __qt_toplevel.height / 960
        }
    ]
    Shape {
        id: _qt_node0
        opacity: __qt_toplevel.opacity
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: __qt_toplevel.strokeColor
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 320 -80 Q 303 -80 291.5 -91.5 Q 280 -103 280 -120 L 280 -760 Q 280 -777 291.5 -788.5 Q 303 -800 320 -800 L 400 -800 L 400 -880 L 560 -880 L 560 -800 L 640 -800 Q 657 -800 668.5 -788.5 Q 680 -777 680 -760 L 680 -120 Q 680 -103 668.5 -91.5 Q 657 -80 640 -80 L 320 -80 "
            }
        }
    }
}
