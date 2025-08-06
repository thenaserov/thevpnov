import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Host row
        Row {
            spacing: 10

            Label {
                text: "Host:"
                font.pixelSize: 18
                color: "white"
                width: 80
            }

            TextField {
                id: hostField
                placeholderText: "e.g., 1.2.3.4"
                font.pixelSize: 18
                color: "white"
                width: 200
            }
        }

        // Username row
        Row {
            spacing: 10

            Label {
                text: "Username:"
                font.pixelSize: 18
                color: "white"
                width: 80
            }

            TextField {
                id: usernameField
                placeholderText: "e.g., root"
                font.pixelSize: 18
                color: "white"
                width: 200
            }
        }

        Row {
            spacing: 10

            Label {
                text: "Password:"
                font.pixelSize: 18
                color: "white"
                width: 80
            }

            TextField {
                id: passwordField
                placeholderText: "e.g., root"
                font.pixelSize: 18
                color: "white"
                width: 200
            }
        }

        // Save Button
        Button {
            text: "Save Profile"
            onClicked: {
                const success = profileManager.addProfile(hostField.text, usernameField.text, passwordField.text)
                if (success)
                    console.log("Profile saved!")
                else
                    console.log("Failed to save profile.")
            }
        }
    }
}
