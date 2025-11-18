// Generated from SVG file assets/svg/volume-off.svg
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
                path: "M 720 -424 L 644 -348 Q 633 -337 616 -337 Q 599 -337 588 -348 Q 577 -359 577 -376 Q 577 -393 588 -404 L 664 -480 L 588 -556 Q 577 -567 577 -584 Q 577 -601 588 -612 Q 599 -623 616 -623 Q 633 -623 644 -612 L 720 -536 L 796 -612 Q 807 -623 824 -623 Q 841 -623 852 -612 Q 863 -601 863 -584 Q 863 -567 852 -556 L 776 -480 L 852 -404 Q 863 -393 863 -376 Q 863 -359 852 -348 Q 841 -337 824 -337 Q 807 -337 796 -348 L 720 -424 M 280 -360 L 160 -360 Q 143 -360 131.5 -371.5 Q 120 -383 120 -400 L 120 -560 Q 120 -577 131.5 -588.5 Q 143 -600 160 -600 L 280 -600 L 412 -732 Q 431 -751 455.5 -740.5 Q 480 -730 480 -703 L 480 -257 Q 480 -230 455.5 -219.5 Q 431 -209 412 -228 L 280 -360 "
            }
        }
    }
}
