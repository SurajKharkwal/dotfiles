import QtQuick
import QtQuick.Shapes

Item {
    id: __qt_toplevel
    property int iconSize: 24
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
            xScale: __qt_toplevel.width / 960
            yScale: __qt_toplevel.height / 960
        }
    ]
    Shape {
        id: _qt_node0
        preferredRendererType: Shape.CurveRenderer
        opacity: __qt_toplevel.opacity
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: __qt_toplevel.strokeColor
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 680 -80 L 680 -200 L 560 -200 L 560 -280 L 680 -280 L 680 -400 L 760 -400 L 760 -280 L 880 -280 L 880 -200 L 760 -200 L 760 -80 L 680 -80 M 200 -200 L 200 -400 L 280 -400 L 280 -280 L 400 -280 L 400 -200 L 200 -200 M 200 -560 L 200 -760 L 400 -760 L 400 -680 L 280 -680 L 280 -560 L 200 -560 M 680 -560 L 680 -680 L 560 -680 L 560 -760 L 760 -760 L 760 -560 L 680 -560 "
            }
        }
    }
}
