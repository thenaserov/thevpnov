// ConnectionManager.h
#pragma once

#include <QObject>

class ConnectionManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool connected READ isConnected NOTIFY connectedChanged)

public:
    explicit ConnectionManager(QObject *parent = nullptr);
    Q_INVOKABLE void connectToServer(const QString &profile);
    Q_INVOKABLE void disconnect();
    bool isConnected() const;

signals:
    void connectedChanged();

private:
    bool m_connected = false;
};
