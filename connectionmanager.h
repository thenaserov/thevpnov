#ifndef CONNECTIONMANAGER_H
#define CONNECTIONMANAGER_H

#include <QObject>
#include <libssh/libssh.h>

class ConnectionManager : public QObject
{
    Q_OBJECT
public:
    explicit ConnectionManager(QObject *parent = nullptr);
    ~ConnectionManager();

    bool connectToHost(const QString &host, int port, const QString &username, const QString &password);
    void disconnect();

    bool isConnected() const;

signals:
    void connected();
    void disconnected();
    void errorOccurred(const QString &message);

private:
    ssh_session session;
    bool connectedFlag;
};

#endif // CONNECTIONMANAGER_H
