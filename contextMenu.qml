import QtQuick 2.15
import QtGraphicalEffects 1.15


Item {
    required property bool blockChecked

    signal unblockDeletion()
    signal blockDeletion()
    signal forceDelete()

    objectName: "contextMenu"
    width: children[0].width
    height: children[0].height

    Rectangle {
        width: children[0].width + 4
        height: children[0].height + 4
        color: "#202020"
        border.color: "#D0D0D0"
        border.width: 2

        Column {
            anchors.centerIn: parent

            Rectangle {
                property bool highLight: children[1].containsMouse

                width: children[0].width
                height: children[0].height
                color: highLight ? "#404040" : "#202020"

                Text {
                    leftPadding: 20
                    rightPadding: 20
                    topPadding: 8
                    bottomPadding: 8
                    color: parent.highLight ? "White" : "#D0D0D0"
                    font.family: "Ubuntu"
                    font.pixelSize: 20
                    text: blockChecked ? qsTr("Unblock deletion") : qsTr("Block deletion")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: blockChecked ? unblockDeletion() : blockDeletion()
                    hoverEnabled: true
                }
            }

            Rectangle {
                property bool highLight: children[1].containsMouse

                width: children[0].width
                height: children[0].height
                color: highLight ? "#404040" : "#202020"

                Text {
                    leftPadding: 20
                    rightPadding: 20
                    topPadding: 8
                    bottomPadding: 8
                    color: parent.highLight ? "White" : "#D0D0D0"
                    font.family: "Ubuntu"
                    font.pixelSize: 20
                    text: qsTr("Force delete")
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: forceDelete()
                    hoverEnabled: true
                }
            }

            Component.onCompleted: {
                if (children[0].width > children[1].width)
                    children[1].width = children[0].width
                else
                    children[0].width = children[1].width
            }
        }
    }

    DropShadow {
        anchors.fill: parent
        horizontalOffset: 8
        verticalOffset: 8
        radius: 16
        samples: 24
        color: "#80000000"
        source: parent.children[0]
    }
}
