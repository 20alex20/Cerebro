import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    required property var listModel

    objectName: "view"
    spacing: 24

    TextField {
        id: enterValue
        width: parent.width
        height: 64
        padding: 16
        focus: false
        font.pixelSize: 24
        font.family: "Ubuntu"
        color: "#E0E0E0"
        placeholderText: qsTr("Enter new value")

        background: Rectangle {
            width: parent.width
            height: parent.height
            color: enterValue.hovered || enterValue.focus ? "#404040" : "#202020"
            radius: 8
        }

        onAccepted: {
            if (text.length > 0) {
                listModel.push(text)
                text = ""
            }
        }
    }

    Item {
        width: parent.width
        height: parent.height - parent.spacing - parent.children[0].height

        Rectangle {
            anchors.fill: parent
            color: "#202020"
            radius: 8
        }

        Flow {
            id: listView
            anchors.fill: parent
            padding: 16
            spacing: 16

            Repeater {
                model: listModel

                Rectangle {
                    required property string body
                    required property bool blockDeletion
                    required property int index
                    property bool checked: false

                    id: record
                    width: children[0].width
                    height: 48
                    z: 1
                    border.width: 1
                    border.color: "#E0E0E0"
                    radius: 24
                    color: checked ? "#404040" : "#202020"

                    Row {
                        anchors.fill: parent
                        width: leftPadding + children[0].width + children[1].width
                        z: 2
                        leftPadding: 16

                        Text {
                            height: record.height
                            verticalAlignment: Text.AlignVCenter
                            text: record.body
                            font.pixelSize: 20
                            font.family: "Ubuntu"
                            color: "#E0E0E0"
                        }
                        Button {
                            id: deleteButton
                            height: record.height
                            width: record.height
                            background: Rectangle { color: "transparent" }

                            icon.source: "qrc:/icons/delete.svg"
                            icon.color: hovered ? "White" : "#E0E0E0"

                            onClicked: {
                                listModel.remove(record.index)
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            record.checked = !record.checked
                        }
                    }
                }
            }
        }
    }
}
