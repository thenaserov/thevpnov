// ConnectionManager.cpp
#include "ConnectionManager.h"
#include <QDebug>

ConnectionManager::ConnectionManager(QObject *parent)
    : QObject(parent) {}

void ConnectionManager::connectToServer(const QString &profile) {
    qDebug() << "Connecting to profile:" << profile;
    // TODO: start SSH or VPN connection logic here
    m_connected = true;
    emit connectedChanged();
}

void ConnectionManager::disconnect() {
    qDebug() << "Disconnecting...";
    // TODO: stop SSH or VPN connection here
    m_connected = false;
    emit connectedChanged();
}

bool ConnectionManager::isConnected() const {
    return m_connected;
}
