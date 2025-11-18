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
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 260 -160 Q 169 -160 104.5 -223 Q 40 -286 40 -377 Q 40 -455 87 -516 Q 134 -577 210 -594 Q 227 -666 295 -731 Q 363 -796 440 -796 Q 473 -796 496.5 -772.5 Q 520 -749 520 -716 L 520 -474 L 584 -536 L 640 -480 L 480 -320 L 320 -480 L 376 -536 L 440 -474 L 440 -716 Q 364 -702 322 -642.5 Q 280 -583 280 -520 L 260 -520 Q 202 -520 161 -479 Q 120 -438 120 -380 Q 120 -322 161 -281 Q 202 -240 260 -240 L 740 -240 Q 782 -240 811 -269 Q 840 -298 840 -340 Q 840 -382 811 -411 Q 782 -440 740 -440 L 680 -440 L 680 -520 Q 680 -568 658 -609.5 Q 636 -651 600 -680 L 600 -773 Q 674 -738 717 -669.5 Q 760 -601 760 -520 Q 829 -512 874.5 -460.5 Q 920 -409 920 -340 Q 920 -265 867.5 -212.5 Q 815 -160 740 -160 L 260 -160 "
            }
        }
    }
}
