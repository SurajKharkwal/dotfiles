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
        preferredRendererType: Shape.CurveRenderer
        opacity: __qt_toplevel.opacity
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: __qt_toplevel.strokeColor
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 280 -440 L 680 -440 L 680 -520 L 280 -520 L 280 -440 M 480 -80 Q 397 -80 324 -111.5 Q 251 -143 197 -197 Q 143 -251 111.5 -324 Q 80 -397 80 -480 Q 80 -563 111.5 -636 Q 143 -709 197 -763 Q 251 -817 324 -848.5 Q 397 -880 480 -880 Q 563 -880 636 -848.5 Q 709 -817 763 -763 Q 817 -709 848.5 -636 Q 880 -563 880 -480 Q 880 -397 848.5 -324 Q 817 -251 763 -197 Q 709 -143 636 -111.5 Q 563 -80 480 -80 M 480 -160 Q 614 -160 707 -253 Q 800 -346 800 -480 Q 800 -614 707 -707 Q 614 -800 480 -800 Q 346 -800 253 -707 Q 160 -614 160 -480 Q 160 -346 253 -253 Q 346 -160 480 -160 "
            }
        }
    }
}
