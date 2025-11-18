import QtQuick
import QtQuick.Shapes

Item {
    id: __qt_toplevel

    property int iconSize: 24
    property color fillColor: "#ffe3e3e3"
    property color strokeColor: "transparent"
    property real iconOpacity: 1

    implicitHeight: iconSize
    implicitWidth: iconSize

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
        opacity: __qt_toplevel.iconOpacity
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: __qt_toplevel.strokeColor
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 360 -120 L 200 -120 Q 167 -120 143.5 -143.5 Q 120 -167 120 -200 L 120 -480 Q 120 -555 148.5 -620.5 Q 177 -686 225.5 -734.5 Q 274 -783 339.5 -811.5 Q 405 -840 480 -840 Q 555 -840 620.5 -811.5 Q 686 -783 734.5 -734.5 Q 783 -686 811.5 -620.5 Q 840 -555 840 -480 L 840 -200 Q 840 -167 816.5 -143.5 Q 793 -120 760 -120 L 600 -120 L 600 -440 L 760 -440 L 760 -480 Q 760 -597 678.5 -678.5 Q 597 -760 480 -760 Q 363 -760 281.5 -678.5 Q 200 -597 200 -480 L 200 -440 L 360 -440 L 360 -120 M 280 -360 L 200 -360 L 200 -200 L 280 -200 L 280 -360 M 680 -360 L 680 -200 L 760 -200 L 760 -360 L 680 -360 "
            }
        }
    }
}
