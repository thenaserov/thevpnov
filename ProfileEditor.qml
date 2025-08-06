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

        //

        // Below the form, add the ListView to show saved profiles
        ListView {
            id: profileListView
            width: parent.width
            height: 150
            model: ListModel {}

            delegate: Rectangle {
                width: parent.width
                height: 30
                color: index % 2 === 0 ? "#333" : "#222"

                Row {
                    anchors.fill: parent
                    spacing: 20

                    Text { text: model.host; color: "white" }
                    Text { text: model.username; color: "lightgray" }
                    Text { text: model.password; color: "lightgray" }

                    Button {
                        text: "Delete"
                        onClicked: {
                            profileManager.deleteProfile(model.id)
                            profileListView.model.remove(index)
                        }
                    }
                }
            }
        }

        // Load profiles button
        Button {
            text: "Load Profiles"
            onClicked: {
                const profiles = profileManager.getProfiles()
                profileListView.model.clear()
                for (let i = 0; i < profiles.length; ++i) {
                    profileListView.model.append({
                        "id": profiles[i].id,  // Pass id for delete operation
                        "host": profiles[i].host,
                        "username": profiles[i].username,
                        "password": profiles[i].password
                    })
                }
            }
        }
    }
}
