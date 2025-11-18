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
                path: "M 160 -160 L 160 -535 L 88 -480 L 41 -543 L 480 -880 L 920 -544 L 872 -480 L 480 -780 L 240 -596 L 240 -240 L 400 -240 L 400 -160 L 160 -160 M 700 -65 Q 658 -36 607.5 -40.5 Q 557 -45 521 -81 Q 485 -117 480.5 -167.5 Q 476 -218 505 -260 Q 476 -302 480.5 -352.5 Q 485 -403 521 -439 Q 557 -475 607.5 -479.5 Q 658 -484 700 -455 Q 742 -484 792.5 -479.5 Q 843 -475 879 -439 Q 915 -403 919.5 -352.5 Q 924 -302 895 -260 Q 924 -218 919.5 -167.5 Q 915 -117 879 -81 Q 843 -45 792.5 -40.5 Q 742 -36 700 -65 M 700 -163 L 746 -131 Q 764 -118 785 -120 Q 806 -122 822 -138 Q 838 -154 840 -175 Q 842 -196 829 -214 L 797 -260 L 829 -306 Q 842 -324 840 -345 Q 838 -366 822 -382 Q 806 -398 785 -400 Q 764 -402 746 -389 L 700 -357 L 654 -389 Q 636 -402 615 -400 Q 594 -398 578 -382 Q 562 -366 560 -345 Q 558 -324 571 -306 L 603 -260 L 571 -214 Q 558 -196 560 -175 Q 562 -154 578 -138 Q 594 -122 615 -120 Q 636 -118 654 -131 L 700 -163 M 700 -210 Q 721 -210 735.5 -224.5 Q 750 -239 750 -260 Q 750 -281 735.5 -295.5 Q 721 -310 700 -310 Q 679 -310 664.5 -295.5 Q 650 -281 650 -260 Q 650 -239 664.5 -224.5 Q 679 -210 700 -210 "
            }
        }
    }
}
