import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
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
                path: "M 440 -240 Q 323 -240 241.5 -321.5 Q 160 -403 160 -520 L 160 -760 Q 160 -793 183.5 -816.5 Q 207 -840 240 -840 L 740 -840 Q 798 -840 839 -799 Q 880 -758 880 -700 Q 880 -642 839 -601 Q 798 -560 740 -560 L 720 -560 L 720 -520 Q 720 -403 638.5 -321.5 Q 557 -240 440 -240 M 240 -640 L 640 -640 L 640 -760 L 240 -760 L 240 -640 M 440 -320 Q 523 -320 581.5 -378.5 Q 640 -437 640 -520 L 640 -560 L 240 -560 L 240 -520 Q 240 -437 298.5 -378.5 Q 357 -320 440 -320 M 720 -640 L 740 -640 Q 765 -640 782.5 -657.5 Q 800 -675 800 -700 Q 800 -725 782.5 -742.5 Q 765 -760 740 -760 L 720 -760 L 720 -640 M 160 -120 L 160 -200 L 800 -200 L 800 -120 L 160 -120 "
            }
        }
    }
}
