import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    required property var model

    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Loader {
        id: loader
        anchors.fill: parent
        Component.onCompleted: setSource("view.qml", {"listModel": window.model})
    }
}
