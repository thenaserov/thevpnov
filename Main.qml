import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "SSH VPN Client"
    color: "#121212"

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: HomePage {}
    }
}
