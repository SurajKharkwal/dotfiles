import QtQuick
import QtQuick.Shapes

Item {
    id: __qt_toplevel

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
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 200 -120 Q 167 -120 143.5 -143.5 Q 120 -167 120 -200 L 120 -440 L 200 -440 L 200 -200 L 440 -200 L 440 -120 L 200 -120 M 520 -120 L 520 -200 L 760 -200 L 760 -440 L 840 -440 L 840 -200 Q 840 -167 816.5 -143.5 Q 793 -120 760 -120 L 520 -120 M 240 -280 L 360 -440 L 450 -320 L 570 -480 L 720 -280 L 240 -280 M 120 -520 L 120 -760 Q 120 -793 143.5 -816.5 Q 167 -840 200 -840 L 440 -840 L 440 -760 L 200 -760 L 200 -520 L 120 -520 M 760 -520 L 760 -760 L 520 -760 L 520 -840 L 760 -840 Q 793 -840 816.5 -816.5 Q 840 -793 840 -760 L 840 -520 L 760 -520 M 620 -560 Q 594 -560 577 -577 Q 560 -594 560 -620 Q 560 -646 577 -663 Q 594 -680 620 -680 Q 646 -680 663 -663 Q 680 -646 680 -620 Q 680 -594 663 -577 Q 646 -560 620 -560 "
            }
        }
    }
}
