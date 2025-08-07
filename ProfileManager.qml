import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: profileEditorPage

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 20

        Button {
            text: "Back"
            onClicked: {
                // Pop this page off the StackView
                profileEditorPage.StackView.view.pop()
            }
        }

        // Your profile editor UI here (list of profiles, add/edit/delete)
        // ...
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

                //Port Row
                Row {
                    spacing: 10

                    Label {
                        text: "Port:"
                        font.pixelSize: 18
                        color: "white"
                        width: 80
                    }

                    TextField {
                        id: portField
                        placeholderText: "22"
                        font.pixelSize: 18
                        color: "white"
                        width: 200
                        inputMethodHints: Qt.ImhDigitsOnly
                        text: "22"
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
                        const success = profileManager.addProfile(hostField.text, parseInt(portField.text), usernameField.text, passwordField.text)
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
                            Text { text: model.port; color: "white" }
                            Text { text: model.username; color: "lightgray" }
                            Text { text: model.password; color: "lightgray" }

                            Button {
                                text: "X"
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
                                "port": profiles[i].port,
                                "username": profiles[i].username,
                                "password": profiles[i].password
                            })
                        }
                    }
                }
            }
        }
    }
}

