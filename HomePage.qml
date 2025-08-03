import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    Column {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: "VPN Profiles"
            font.pixelSize: 22
            color: "white"
        }

        Button {
            text: "Add Profile"
            onClicked: {
                // Later: stack.push(ProfileEditor {})
            }
        }

        Button {
            text: "Connect"
            onClicked: {
                // Later: trigger SSH tunnel
            }
        }
    }
}
