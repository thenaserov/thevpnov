#include "profilemanager.h"


ProfileManager::ProfileManager(QObject *parent)
    : QObject{parent}
{
    initializeDatabase();
}

ProfileManager::~ProfileManager()
{
    delete this;
    delete db;
}

bool ProfileManager::addProfile(const QString &host, const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("INSERT INTO profiles (host, username, password) VALUES (?, ?, ?)");
    query.addBindValue(host);
    query.addBindValue(username);
    query.addBindValue(password);

    if (!query.exec()) {
        qWarning() << "Failed to insert profile:" << query.lastError();
        return false;
    }

    return true;
}

QVariantList ProfileManager::getProfiles()
{
    QVariantList profileList;
    QSqlQuery query("SELECT id, host, username, password FROM profiles");

    while (query.next()) {
        QVariantMap profile;
        profile["id"] = query.value("id");
        profile["host"] = query.value("host");
        profile["username"] = query.value("username");
        profile["password"] = query.value("password");
        profileList.append(profile);
    }

    return profileList;
}

void ProfileManager::initializeDatabase()
{
    db = new QSqlDatabase();
    db->addDatabase("QSQLITE");
    db->setDatabaseName("profiles.db");

    if (!db->open()) {
        qDebug() << "Failed to open database:" << db->lastError().text();
        return;
    }

    QSqlQuery query;
    QString createTable = R"(
        CREATE TABLE IF NOT EXISTS profiles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            host TEXT NOT NULL,
            username TEXT NOT NULL,
            password TEXT NOT NULL
        )
    )";

    if (!query.exec(createTable)) {
        qDebug() << "Failed to create table:" << query.lastError().text();
    } else {
        qDebug() << "Database initialized and table ready.";
    }
}
