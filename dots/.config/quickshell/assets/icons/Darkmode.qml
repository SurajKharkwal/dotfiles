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
                path: "M 480 -120 Q 330 -120 225 -225 Q 120 -330 120 -480 Q 120 -630 225 -735 Q 330 -840 480 -840 Q 494 -840 507.5 -839 Q 521 -838 534 -836 Q 493 -807 468.5 -760.5 Q 444 -714 444 -660 Q 444 -570 507 -507 Q 570 -444 660 -444 Q 715 -444 761 -468.5 Q 807 -493 836 -534 Q 838 -521 839 -507.5 Q 840 -494 840 -480 Q 840 -330 735 -225 Q 630 -120 480 -120 M 480 -200 Q 568 -200 638 -248.5 Q 708 -297 740 -375 Q 720 -370 700 -367 Q 680 -364 660 -364 Q 537 -364 450.5 -450.5 Q 364 -537 364 -660 Q 364 -680 367 -700 Q 370 -720 375 -740 Q 297 -708 248.5 -638 Q 200 -568 200 -480 Q 200 -364 282 -282 Q 364 -200 480 -200 "
            }
        }
    }
}
