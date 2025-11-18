// Generated from SVG file assets/svg/volume-up.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
    id: __qt_toplevel

    property int iconSize: 24
    property color fillColor: "#ffe3e3e3"
    property color strokeColor: "transparent"
    property real iconOpacity: 1

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
                path: "M 760 -481 Q 760 -564 716 -632.5 Q 672 -701 598 -735 Q 583 -742 576 -756.5 Q 569 -771 574 -786 Q 580 -802 595.5 -809 Q 611 -816 627 -809 Q 724 -766 782 -677.5 Q 840 -589 840 -481 Q 840 -373 782 -284.5 Q 724 -196 627 -153 Q 611 -146 595.5 -153 Q 580 -160 574 -176 Q 569 -191 576 -205.5 Q 583 -220 598 -227 Q 672 -261 716 -329.5 Q 760 -398 760 -481 M 280 -360 L 160 -360 Q 143 -360 131.5 -371.5 Q 120 -383 120 -400 L 120 -560 Q 120 -577 131.5 -588.5 Q 143 -600 160 -600 L 280 -600 L 412 -732 Q 431 -751 455.5 -740.5 Q 480 -730 480 -703 L 480 -257 Q 480 -230 455.5 -219.5 Q 431 -209 412 -228 L 280 -360 M 660 -480 Q 660 -438 641 -400.5 Q 622 -363 591 -339 Q 581 -333 570.5 -338.5 Q 560 -344 560 -356 L 560 -606 Q 560 -618 570.5 -623.5 Q 581 -629 591 -623 Q 622 -598 641 -560 Q 660 -522 660 -480 "
            }
        }
    }
}
