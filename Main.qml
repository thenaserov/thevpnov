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
    property string selectedProfile: "No profile selected"

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Item {
            anchors.fill: parent

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Label {
                    text: "Selected Profile:\n" + selectedProfile
                    font.pixelSize: 16
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                Button {
                    text: isConnected ? "Disconnect" : "Connect"
                    Layout.fillWidth: true
                    onClicked: {
                        isConnected = !isConnected
                        console.log(isConnected ? "Connected" : "Disconnected")
                    }
                }

                Button {
                    text: "Open Profile Manager"
                    Layout.fillWidth: true
                    onClicked: {
                        stackView.push("ProfileManager.qml")
                    }
                }
            }
        }
    }
}
