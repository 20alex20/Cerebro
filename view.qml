import QtQuick 2.15
import QtQuick.Controls 2.15


Column {
    required property var listModel

    function closeContextMenu() {
        if (listView.smallCloseContextMenu !== null) {
            listView.smallCloseContextMenu()
            listView.smallCloseContextMenu = null
        }
    }

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
        color: "#D0D0D0"
        placeholderText: qsTr("Enter new value")

        background: Rectangle {
            width: enterValue.width
            height: enterValue.height
            color: enterValue.hovered || enterValue.focus ? "#404040" : "#202020"
            radius: 8
        }

        onPressed: closeContextMenu()
        onAccepted: {
            if (text.length > 0) {
                listModel.push(text)
                text = ""
            }
        }
    }

    Item {
        width: parent.width
        height: parent.height - 2 * 24 - 2 * 64

        Rectangle {
            anchors.fill: parent
            color: "#202020"
            radius: 8
        }

        ScrollView {
            property var contextMenu
            property var smallCloseContextMenu: null

            id: listView
            anchors.fill: parent
            wheelEnabled: true
            clip: true

            Flow {
                width: listView.availableWidth
                padding: 16
                spacing: 16

                Repeater {
                    model: listModel

                    Item {
                        required property int index
                        required property string body
                        required property bool checked
                        property bool blockChecked: false

                        id: record
                        z: 1
                        width: children[1].width
                        height: 48

                        Rectangle {
                            anchors.fill: parent
                            z: 1
                            border.width: 1
                            border.color: checked ? "White" : "#D0D0D0"
                            radius: 24
                            color: checked ? "#404040" : "#202020"
                        }

                        Row {
                            height: parent.height
                            width: leftPadding + children[0].width + children[1].width
                            z: 2
                            leftPadding: 16

                            Text {
                                height: parent.height
                                z: 0
                                verticalAlignment: Text.AlignVCenter
                                text: record.body
                                font.pixelSize: 20
                                font.family: "Ubuntu"
                                color: checked ? "White" : "#D0D0D0"
                            }
                            Button {
                                id: deleteButton
                                height: parent.height
                                width: parent.height
                                z: 1
                                background: Rectangle { color: "transparent" }
                                icon.source: "qrc:/icons/delete.svg"
                                icon.color: !record.blockChecked && hovered ? "White" : "#D0D0D0"

                                onPressed: closeContextMenu()
                                onClicked: {
                                    if (!record.blockChecked)
                                        listModel.remove(record.index)
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            z: 1
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            onPressed: closeContextMenu()
                            onClicked: {
                                if (mouse.button == Qt.RightButton) {
                                    if (listView.contextMenu.status !== Component.Ready)
                                        return;

                                    var contextMenu = listView.contextMenu.createObject(record, { "blockChecked": blockChecked })
                                    contextMenu.x = mouseX
                                    if (mouseX + contextMenu.width > listView.width - record.x)
                                        contextMenu.x -= contextMenu.width
                                    contextMenu.y = mouseY
                                    contextMenu.z = 2
                                    record.z = 2

                                    listView.smallCloseContextMenu = function () {
                                        record.z = 1
                                        contextMenu.destroy()
                                    }

                                    contextMenu.blockDeletion.connect(function() {
                                        closeContextMenu()
                                        if (record.checked)
                                            listModel.changeChecked(index);
                                        record.blockChecked = true
                                    })
                                    contextMenu.unblockDeletion.connect(function() {
                                        closeContextMenu()
                                        record.blockChecked = false
                                    })
                                    contextMenu.forceDelete.connect(function() {
                                        closeContextMenu()
                                        listModel.remove(record.index)
                                    })
                                }
                                else if (!record.blockChecked) {
                                    listModel.changeChecked(record.index);
                                }
                            }
                        }
                    }
                }
            }

            Component.onCompleted: {
                contextMenu = Qt.createComponent("contextMenu.qml");
            }
        }
    }

    Button {
        id: removeChecked
        width: parent.width
        height: 64

        contentItem: Text {
            anchors.fill: removeChecked
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 20
            font.family: "Ubuntu"
            color: removeChecked.pressed ? "White" : "#D0D0D0"
            text: qsTr("Remove checked")
        }
        background: Rectangle {
            width: removeChecked.width
            height: removeChecked.height
            color: removeChecked.hovered ? "#404040" : "#202020"
            radius: 8
        }

        onPressed: closeContextMenu()
        onClicked: listModel.removeChecked()
    }
}
