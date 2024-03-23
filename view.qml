import QtQuick 2.0

Column {
    property var listModel

    id: view

    ListView {
        width: view.width;
        height: 250
        model: listModel
        delegate: Text {
            required property string body
            required property bool blockDeletion

            text: body + ", " + blockDeletion.toString()

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    listModel.changeBlockDeletion(0)
                    listModel.remove(1)
                    listModel.push("mmm")
                }
            }
        }

        Component.onCompleted: {
            listModel.push("first")
            listModel.push("second")
            listModel.push("third")
        }
    }
}
