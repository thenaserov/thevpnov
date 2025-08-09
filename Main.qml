import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    title: "VPN Client"
    color: "#121212"

    property bool isConnected: false
    property string selectedProfile: ""

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Item {
            anchors.fill: parent

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Label {
                    text: selectedProfile === "" ? "No Profile Selected" : "Selected Profile:\n" + selectedProfile
                    font.pixelSize: 16
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                Button {
                    text: connectionManager.isConnected ? "Disconnect" : "Connect"

                    onClicked: {
                        if (connectionManager.isConnected) {
                            connectionManager.disconnectFromHost();
                        } else {
                            if (!selectedProfile || selectedProfile === "") {
                                console.log("No profile selected");
                                return;
                            }

                            var parts1 = selectedProfile.split("@");
                            if (parts1.length !== 2) {
                                console.log("Invalid profile format, expected username@host:port");
                                return;
                            }

                            var username = parts1[0];
                            var parts2 = parts1[1].split(":");
                            if (parts2.length !== 2) {
                                console.log("Invalid profile format, expected username@host:port");
                                return;
                            }

                            var host = parts2[0];
                            var port = parseInt(parts2[1]);
                            if (isNaN(port)) {
                                console.log("Invalid port number");
                                return;
                            }

                            // Prompt for password (in real app, use a proper password dialog)
                            var password = passwordField.text; // assuming you have a PasswordField

                            connectionManager.connectToHost(host, port, username, password);
                        }
                    }
                }


                // Optionally connect signals for feedback:
                Connections {
                    target: connectionManager
                    onConnected: console.log("Connected!")
                    onDisconnected: console.log("Disconnected!")
                    onErrorOccurred: console.log("Error: " + message)
                }



                Button {
                    text: "Open Profile Manager"
                    Layout.fillWidth: true
                    onClicked: {
                        stackView.push({
                            item: Qt.resolvedUrl("ProfileManager.qml"),
                            properties: {
                                onProfileSelected: function(profileName) {
                                    selectedProfile = profileName
                                    isConnected = false
                                    stackView.pop()
                                }
                            }
                        })
                    }
                }

            }
        }
    }

    // Listen for profile selection from ProfileManager
    Connections {
        target: stackView.currentItem
        onProfileSelected: function(profileName) {
            selectedProfile = profileName
            isConnected = false
            stackView.pop()
        }
    }
}
