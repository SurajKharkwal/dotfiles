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
                path: "M 480 -400 Q 430 -400 395 -435 Q 360 -470 360 -520 L 360 -760 Q 360 -810 395 -845 Q 430 -880 480 -880 Q 530 -880 565 -845 Q 600 -810 600 -760 L 600 -520 Q 600 -470 565 -435 Q 530 -400 480 -400 M 440 -120 L 440 -243 Q 336 -257 268 -336 Q 200 -415 200 -520 L 280 -520 Q 280 -437 338.5 -378.5 Q 397 -320 480 -320 Q 563 -320 621.5 -378.5 Q 680 -437 680 -520 L 760 -520 Q 760 -415 692 -336 Q 624 -257 520 -243 L 520 -120 L 440 -120 M 480 -480 Q 497 -480 508.5 -491.5 Q 520 -503 520 -520 L 520 -760 Q 520 -777 508.5 -788.5 Q 497 -800 480 -800 Q 463 -800 451.5 -788.5 Q 440 -777 440 -760 L 440 -520 Q 440 -503 451.5 -491.5 Q 463 -480 480 -480 "
            }
        }
    }
}
