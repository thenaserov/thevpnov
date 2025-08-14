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

    Q_INVOKABLE bool connectToHost(const QString &host, int port,
                                   const QString &username, const QString &password);
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE bool isConnected() const;


signals:
    void connected();
    void disconnected();
    void errorOccurred(const QString &message);

private:
    ssh_session session;
    bool connectedFlag{false};
};

#endif // CONNECTIONMANAGER_H
