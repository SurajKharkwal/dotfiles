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
                path: "M 600 -640 L 480 -760 L 600 -880 L 720 -760 L 600 -640 M 800 -520 L 720 -600 L 800 -680 L 880 -600 L 800 -520 M 483 -80 Q 399 -80 325.5 -112 Q 252 -144 197.5 -198.5 Q 143 -253 111 -326.5 Q 79 -400 79 -484 Q 79 -630 172 -741.5 Q 265 -853 409 -880 Q 391 -781 420 -686.5 Q 449 -592 520 -521 Q 591 -450 685.5 -421 Q 780 -392 879 -410 Q 853 -266 741 -173 Q 629 -80 483 -80 M 483 -160 Q 571 -160 646 -204 Q 721 -248 764 -325 Q 678 -333 601 -368.5 Q 524 -404 463 -465 Q 402 -526 366 -603 Q 330 -680 323 -766 Q 246 -723 202.5 -647.5 Q 159 -572 159 -484 Q 159 -349 253.5 -254.5 Q 348 -160 483 -160 "
            }
        }
    }
}
