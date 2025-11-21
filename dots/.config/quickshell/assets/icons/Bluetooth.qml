import QtQuick
import QtQuick.Shapes

Item {
    id: __qt_toplevel
    property int iconSize: 24
    property string fillColor: "#ffe3e3e3"
    property string strokeColor: "transparent"
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
                path: "M 440 -80 L 440 -384 L 256 -200 L 200 -256 L 424 -480 L 200 -704 L 256 -760 L 440 -576 L 440 -880 L 480 -880 L 708 -652 L 536 -480 L 708 -308 L 480 -80 L 440 -80 M 520 -576 L 596 -652 L 520 -726 L 520 -576 M 520 -234 L 596 -308 L 520 -384 L 520 -234 "
            }
        }
    }
}
