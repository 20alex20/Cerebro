import QtQuick 2.0

Column {
    property var model

    id: view

    ListView {
        width: view.width;
        height: 250
        model: view.model
        delegate: Text {
            required property string body
            required property bool blockDeletion

            text: body + ", " + blockDeletion.toString()

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    blockDeletion = false
                }
            }
        }
    }
}
