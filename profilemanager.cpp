#include "profilemanager.h"


ProfileManager::ProfileManager(QObject *parent)
    : QObject{parent}
{
    initializeDatabase();
}

ProfileManager::~ProfileManager()
{
    delete this;
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

QList<QVariantMap> ProfileManager::getProfiles()
{
    QList<QVariantMap> profiles;

    if (!db.isOpen()) {
        qWarning() << "Database is not open.";
        return profiles;
    }

    QSqlQuery query(db);
    if (!query.exec("SELECT id, host, username, password FROM profiles")) {
        qWarning() << "Failed to fetch profiles:" << query.lastError().text();
        return profiles;
    }

    while (query.next()) {
        QVariantMap profile;
        profile["id"] = query.value("id");
        profile["host"] = query.value("host");
        profile["username"] = query.value("username");
        profile["password"] = query.value("password");

        profiles.append(profile);
    }

    return profiles;
}


void ProfileManager::initializeDatabase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    QString dbPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

    QDir().mkpath(dbPath);
    db.setDatabaseName(dbPath + "/profiles.db");

    if (!db.open()) {
        qDebug() << "Failed to open database:" << db.lastError().text();
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
        qDebug() << "Database initialized at:" << db.databaseName();
    }
}

