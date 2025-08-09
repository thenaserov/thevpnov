#include "connectionmanager.h"
#include <QDebug>

ConnectionManager::ConnectionManager(QObject *parent)
    : QObject(parent), session(nullptr), connectedFlag(false)
{
}

ConnectionManager::~ConnectionManager()
{
    disconnect();
}

bool ConnectionManager::connectToHost(const QString &host, int port, const QString &username, const QString &password)
{
    if (connectedFlag) {
        disconnect();
    }

    session = ssh_new();
    if (session == nullptr) {
        emit errorOccurred("Failed to allocate SSH session");
        return false;
    }

    ssh_options_set(session, SSH_OPTIONS_HOST, host.toUtf8().constData());
    ssh_options_set(session, SSH_OPTIONS_PORT, &port);
    ssh_options_set(session, SSH_OPTIONS_USER, username.toUtf8().constData());

    int rc = ssh_connect(session);
    if (rc != SSH_OK) {
        QString err = QString("Error connecting to %1: %2").arg(host, ssh_get_error(session));
        ssh_free(session);
        session = nullptr;
        emit errorOccurred(err);
        return false;
    }

    rc = ssh_userauth_password(session, nullptr, password.toUtf8().constData());
    if (rc != SSH_AUTH_SUCCESS) {
        QString err = QString("Authentication failed: %1").arg(ssh_get_error(session));
        ssh_disconnect(session);
        ssh_free(session);
        session = nullptr;
        emit errorOccurred(err);
        return false;
    }

    connectedFlag = true;
    emit connected();
    return true;
}

void ConnectionManager::disconnect()
{
    if (session) {
        ssh_disconnect(session);
        ssh_free(session);
        session = nullptr;
    }
    connectedFlag = false;
    emit disconnected();
}

bool ConnectionManager::isConnected() const
{
    return connectedFlag;
}
