import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    required property var listModel

    objectName: "window"
    width: 800
    height: 600
    minimumWidth: 600
    minimumHeight: 300
    visible: true
    color: "#303030"
    title: qsTr("Cerebra")


    Item {
        anchors.fill: parent

        Loader {
            width: parent.width / 2
            height: parent.height * 2 / 3
            anchors.centerIn: parent

            Component.onCompleted: setSource("view.qml", {"listModel": listModel})
        }
    }
}
