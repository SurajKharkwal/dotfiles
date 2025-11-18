// Generated from SVG file assets/svg/volume-down.svg
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
                path: "M 360 -360 L 240 -360 Q 223 -360 211.5 -371.5 Q 200 -383 200 -400 L 200 -560 Q 200 -577 211.5 -588.5 Q 223 -600 240 -600 L 360 -600 L 492 -732 Q 511 -751 535.5 -740.5 Q 560 -730 560 -703 L 560 -257 Q 560 -230 535.5 -219.5 Q 511 -209 492 -228 L 360 -360 M 740 -480 Q 740 -438 721 -400.5 Q 702 -363 671 -339 Q 661 -333 650.5 -338.5 Q 640 -344 640 -356 L 640 -606 Q 640 -618 650.5 -623.5 Q 661 -629 671 -623 Q 702 -598 721 -560 Q 740 -522 740 -480 "
            }
        }
    }
}
