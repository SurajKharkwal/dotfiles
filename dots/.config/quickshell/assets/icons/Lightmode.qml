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
            strokeColor: "transparent"
            fillColor: "#ffe3e3e3"
            fillRule: ShapePath.WindingFill
            pathHints: ShapePath.PathQuadratic | ShapePath.PathNonIntersecting | ShapePath.PathNonOverlappingControlPointTriangles
            PathSvg {
                path: "M 480 -360 Q 530 -360 565 -395 Q 600 -430 600 -480 Q 600 -530 565 -565 Q 530 -600 480 -600 Q 430 -600 395 -565 Q 360 -530 360 -480 Q 360 -430 395 -395 Q 430 -360 480 -360 M 480 -280 Q 397 -280 338.5 -338.5 Q 280 -397 280 -480 Q 280 -563 338.5 -621.5 Q 397 -680 480 -680 Q 563 -680 621.5 -621.5 Q 680 -563 680 -480 Q 680 -397 621.5 -338.5 Q 563 -280 480 -280 M 200 -440 L 40 -440 L 40 -520 L 200 -520 L 200 -440 M 920 -440 L 760 -440 L 760 -520 L 920 -520 L 920 -440 M 440 -760 L 440 -920 L 520 -920 L 520 -760 L 440 -760 M 440 -40 L 440 -200 L 520 -200 L 520 -40 L 440 -40 M 256 -650 L 155 -747 L 212 -806 L 308 -706 L 256 -650 M 748 -154 L 651 -255 L 704 -310 L 805 -213 L 748 -154 M 650 -704 L 747 -805 L 806 -748 L 706 -652 L 650 -704 M 154 -212 L 255 -309 L 310 -256 L 213 -155 L 154 -212 "
            }
        }
    }
}
