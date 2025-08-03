#ifndef PROFILEMANAGER_H
#define PROFILEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QVariant>

class ProfileManager : public QObject {
    Q_OBJECT

public:
    explicit ProfileManager(QObject *parent = nullptr);
    ~ProfileManager();

    Q_INVOKABLE bool addProfile(const QString &host, const QString &username, const QString &password);
    Q_INVOKABLE QVariantList getProfiles();

signals:
    void profilesUpdated();  // Notify QML to refresh UI

private:
    void initializeDatabase();
    QSqlDatabase *db = nullptr;

};

#endif // PROFILEMANAGER_H
