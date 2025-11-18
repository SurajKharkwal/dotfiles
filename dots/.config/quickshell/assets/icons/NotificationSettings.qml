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
                path: "M 480 -80 Q 447 -80 423.5 -103.5 Q 400 -127 400 -160 L 560 -160 Q 560 -127 536.5 -103.5 Q 513 -80 480 -80 M 160 -200 L 160 -280 L 240 -280 L 240 -560 Q 240 -644 290.5 -709 Q 341 -774 422 -793 Q 412 -771 406.5 -747 Q 401 -723 399 -698 Q 364 -677 342 -641 Q 320 -605 320 -560 L 320 -280 L 640 -280 L 640 -402 Q 660 -399 680 -399 Q 700 -399 720 -402 L 720 -280 L 800 -280 L 800 -200 L 160 -200 M 640 -480 L 628 -540 Q 616 -545 605.5 -550.5 Q 595 -556 584 -564 L 526 -546 L 486 -614 L 532 -654 Q 530 -667 530 -680 Q 530 -693 532 -706 L 486 -746 L 526 -814 L 584 -796 Q 595 -804 605.5 -809.5 Q 616 -815 628 -820 L 640 -880 L 720 -880 L 732 -820 Q 744 -815 754.5 -809.5 Q 765 -804 776 -796 L 834 -814 L 874 -746 L 828 -706 Q 830 -693 830 -680 Q 830 -667 828 -654 L 874 -614 L 834 -546 L 776 -564 Q 765 -556 754.5 -550.5 Q 744 -545 732 -540 L 720 -480 L 640 -480 M 680 -600 Q 713 -600 736.5 -623.5 Q 760 -647 760 -680 Q 760 -713 736.5 -736.5 Q 713 -760 680 -760 Q 647 -760 623.5 -736.5 Q 600 -713 600 -680 Q 600 -647 623.5 -623.5 Q 647 -600 680 -600 "
            }
        }
    }
}
