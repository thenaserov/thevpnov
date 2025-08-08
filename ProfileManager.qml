import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: profileEditorPage
    signal profileSelected(string profileName)

    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 20

        Button {
            text: "Back"
            onClicked: profileEditorPage.StackView.view.pop()
        }

        Column {
            spacing: 20

            // Host row
            Row {
                spacing: 10
                Label { text: "Host:"; color: "white"; font.pixelSize: 18; width: 80 }
                TextField { id: hostField; width: 200; placeholderText: "e.g., 1.2.3.4" }
            }

            // Port row
            Row {
                spacing: 10
                Label { text: "Port:"; color: "white"; font.pixelSize: 18; width: 80 }
                TextField {
                    id: portField; width: 200; placeholderText: "22"
                    inputMethodHints: Qt.ImhDigitsOnly
                    text: "22"
                }
            }

            // Username row
            Row {
                spacing: 10
                Label { text: "Username:"; color: "white"; font.pixelSize: 18; width: 80 }
                TextField { id: usernameField; width: 200; placeholderText: "e.g., root" }
            }

            // Password row
            Row {
                spacing: 10
                Label { text: "Password:"; color: "white"; font.pixelSize: 18; width: 80 }
                TextField { id: passwordField; width: 200; placeholderText: "e.g., password" }
            }

            // Save profile
            Button {
                text: "Save Profile"
                onClicked: {
                    const success = profileManager.addProfile(
                        hostField.text,
                        parseInt(portField.text),
                        usernameField.text,
                        passwordField.text
                    )
                    if (success) {
                        console.log("Profile saved!")
                    } else {
                        console.log("Failed to save profile.")
                    }
                }
            }

            ListView {
                id: profileListView
                width: parent.width
                height: 220
                clip: true
                model: ListModel {}

                delegate: Rectangle {
                    width: parent.width
                    height: 48
                    color: index % 2 === 0 ? "#2c2c2c" : "#1e1e1e"
                    radius: 6
                    border.color: "#444"

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 6
                        spacing: 2

                        Text {
                            text: model.host
                            color: "white"
                            font.pixelSize: 14
                            elide: Text.ElideRight
                            Layout.preferredWidth: 70
                            Layout.minimumWidth: 50
                            Layout.maximumWidth: 120
                        }

                        Text {
                            text: model.port
                            color: "white"
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignRight
                            Layout.preferredWidth: 40
                            Layout.minimumWidth: 30
                            Layout.maximumWidth: 50
                        }

                        Text {
                            text: model.username
                            color: "#cccccc"
                            font.pixelSize: 14
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                            Layout.minimumWidth: 60
                        }

                        Button {
                            text: "Select"
                            Layout.preferredWidth: 60
                            Layout.minimumWidth: 50
                            Layout.maximumWidth: 70
                            onClicked: {
                                profileEditorPage.profileSelected(model.host + ":" + model.port)
                            }
                        }

                        Button {
                            text: "✕"
                            Layout.preferredWidth: 30
                            Layout.maximumWidth: 40
                            onClicked: {
                                profileManager.deleteProfile(model.id)
                                profileListView.model.remove(index)
                            }
                        }
                    }
                }
            }


            Button {
                text: "Load Profiles"
                onClicked: {
                    const profiles = profileManager.getProfiles()
                    profileListView.model.clear()
                    for (let i = 0; i < profiles.length; ++i) {
                        profileListView.model.append({
                            "id": profiles[i].id,
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
