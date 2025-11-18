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
                path: "M 346 -160 L 240 -160 Q 207 -160 183.5 -183.5 Q 160 -207 160 -240 L 160 -346 L 83 -424 Q 72 -436 66 -450.5 Q 60 -465 60 -480 Q 60 -495 66 -509.5 Q 72 -524 83 -536 L 160 -614 L 160 -720 Q 160 -753 183.5 -776.5 Q 207 -800 240 -800 L 346 -800 L 424 -877 Q 436 -888 450.5 -894 Q 465 -900 480 -900 Q 495 -900 509.5 -894 Q 524 -888 536 -877 L 614 -800 L 720 -800 Q 753 -800 776.5 -776.5 Q 800 -753 800 -720 L 800 -614 L 877 -536 Q 888 -524 894 -509.5 Q 900 -495 900 -480 Q 900 -465 894 -450.5 Q 888 -436 877 -424 L 800 -346 L 800 -240 Q 800 -207 776.5 -183.5 Q 753 -160 720 -160 L 614 -160 L 536 -83 Q 524 -72 509.5 -66 Q 495 -60 480 -60 Q 465 -60 450.5 -66 Q 436 -72 424 -83 L 346 -160 M 480 -280 Q 563 -280 621.5 -338.5 Q 680 -397 680 -480 Q 680 -563 621.5 -621.5 Q 563 -680 480 -680 Q 397 -680 338.5 -621.5 Q 280 -563 280 -480 Q 280 -397 338.5 -338.5 Q 397 -280 480 -280 M 380 -240 L 480 -140 L 580 -240 L 720 -240 L 720 -380 L 820 -480 L 720 -580 L 720 -720 L 580 -720 L 480 -820 L 380 -720 L 240 -720 L 240 -580 L 140 -480 L 240 -380 L 240 -240 L 380 -240 "
            }
        }
    }
}
