import QtQuick
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
                path: "M 370 -80 L 354 -208 Q 341 -213 329.5 -220 Q 318 -227 307 -235 L 188 -185 L 78 -375 L 181 -453 Q 180 -460 180 -466.5 L 180 -493.5 Q 180 -500 181 -507 L 78 -585 L 188 -775 L 307 -725 Q 318 -733 330 -740 Q 342 -747 354 -752 L 370 -880 L 590 -880 L 606 -752 Q 619 -747 630.5 -740 Q 642 -733 653 -725 L 772 -775 L 882 -585 L 779 -507 Q 780 -500 780 -493.5 L 780 -466.5 Q 780 -460 778 -453 L 881 -375 L 771 -185 L 653 -235 Q 642 -227 630 -220 Q 618 -213 606 -208 L 590 -80 L 370 -80 M 440 -160 L 519 -160 L 533 -266 Q 564 -274 590.5 -289.5 Q 617 -305 639 -327 L 738 -286 L 777 -354 L 691 -419 Q 696 -433 698 -448.5 Q 700 -464 700 -480 Q 700 -496 698 -511.5 Q 696 -527 691 -541 L 777 -606 L 738 -674 L 639 -632 Q 617 -655 590.5 -670.5 Q 564 -686 533 -694 L 520 -800 L 441 -800 L 427 -694 Q 396 -686 369.5 -670.5 Q 343 -655 321 -633 L 222 -674 L 183 -606 L 269 -542 Q 264 -527 262 -512 Q 260 -497 260 -480 Q 260 -464 262 -449 Q 264 -434 269 -419 L 183 -354 L 222 -286 L 321 -328 Q 343 -305 369.5 -289.5 Q 396 -274 427 -266 L 440 -160 M 482 -340 Q 540 -340 581 -381 Q 622 -422 622 -480 Q 622 -538 581 -579 Q 540 -620 482 -620 Q 423 -620 382.5 -579 Q 342 -538 342 -480 Q 342 -422 382.5 -381 Q 423 -340 482 -340 "
            }
        }
    }
}
