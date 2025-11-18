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
        opacity: __qt_toplevel.iconOpacity
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: _qt_shapePath_0
            strokeColor: __qt_toplevel.strokeColor
            fillColor: __qt_toplevel.fillColor
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 260 -160 Q 169 -160 104.5 -223 Q 40 -286 40 -377 Q 40 -455 87 -516 Q 134 -577 210 -594 Q 235 -686 310 -743 Q 385 -800 480 -800 Q 597 -800 678.5 -718.5 Q 760 -637 760 -520 Q 829 -512 874.5 -460.5 Q 920 -409 920 -340 Q 920 -265 867.5 -212.5 Q 815 -160 740 -160 L 520 -160 Q 487 -160 463.5 -183.5 Q 440 -207 440 -240 L 440 -446 L 376 -384 L 320 -440 L 480 -600 L 640 -440 L 584 -384 L 520 -446 L 520 -240 L 740 -240 Q 782 -240 811 -269 Q 840 -298 840 -340 Q 840 -382 811 -411 Q 782 -440 740 -440 L 680 -440 L 680 -520 Q 680 -603 621.5 -661.5 Q 563 -720 480 -720 Q 397 -720 338.5 -661.5 Q 280 -603 280 -520 L 260 -520 Q 202 -520 161 -479 Q 120 -438 120 -380 Q 120 -322 161 -281 Q 202 -240 260 -240 L 360 -240 L 360 -160 L 260 -160 "
            }
        }
    }
}
