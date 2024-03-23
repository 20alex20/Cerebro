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

                Item {
                    required property string body
                    required property bool checked
                    required property int index

                    id: record
                    z: 0
                    width: children[1].width
                    height: 48

                    Rectangle {
                        anchors.fill: parent
                        border.width: 1
                        border.color: "#E0E0E0"
                        radius: 24
                        color: checked ? "#404040" : "#202020"
                    }

                    Row {
                        height: parent.height
                        width: leftPadding + children[0].width + children[1].width
                        z: 1
                        leftPadding: 16

                        Text {
                            height: parent.height
                            verticalAlignment: Text.AlignVCenter
                            text: record.body
                            font.pixelSize: 20
                            font.family: "Ubuntu"
                            color: "#E0E0E0"
                        }
                        Button {
                            id: deleteButton
                            height: parent.height
                            width: parent.height
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
                            listModel.changeChecked(record.index)
                        }
                    }
                }
            }
        }
    }
}
