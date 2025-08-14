import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 400
    height: 350
    visible: true
    title: "VPN Client"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 12
        width: parent.width * 0.8

        Label {
            text: "VPN Connection"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        TextField { id: hostField; placeholderText: "Host"; Layout.fillWidth: true; text: "82.115.8.97" }
        TextField { id: portField; placeholderText: "Port"; inputMethodHints: Qt.ImhDigitsOnly; Layout.fillWidth: true; text: "22" }
        TextField { id: usernameField; placeholderText: "Username"; Layout.fillWidth: true; text: "thenaserov" }
        TextField { id: passwordField; placeholderText: "Password"; Layout.fillWidth: true; text: "33414162" }

        Button {
            id: connectButton
            text: connectionManager.isConnected ? "Disconnect" : "Connect"
            Layout.fillWidth: true

            onClicked: {
                if (connectionManager.isConnected) {
                    // Disconnect
                    connectionManager.disconnect()
                    statusLabel.text = "Disconnecting..."
                    statusLabel.color = "orange"
                } else {
                    // Validate input before connecting
                    if (!hostField.text.trim() || !portField.text.trim() ||
                        !usernameField.text.trim() || !passwordField.text.trim()) {
                        statusLabel.text = "Please fill in all fields"
                        statusLabel.color = "red"
                        return
                    }

                    statusLabel.text = "Connecting..."
                    statusLabel.color = "blue"

                    connectionManager.connectToHost(
                        hostField.text.trim(),
                        parseInt(portField.text.trim()),
                        usernameField.text.trim(),
                        passwordField.text.trim()
                    )
                }
            }
        }

        Label {
            id: statusLabel
            text: ""
            color: "black"
            Layout.alignment: Qt.AlignHCenter
        }

        // Listen for connection events
        Connections {
            target: connectionManager
            onConnected: {
                statusLabel.text = "Connected successfully"
                statusLabel.color = "green"
                connectButton.text = "Disconnect"
            }
            onDisconnected: {
                statusLabel.text = "Disconnected"
                statusLabel.color = "orange"
                connectButton.text = "Connect"
            }
            onErrorOccurred: {
                statusLabel.text = message
                statusLabel.color = "red"
                connectButton.text = "Connect"
            }
        }
}
}
