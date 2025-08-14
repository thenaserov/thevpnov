#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "connectionmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    ConnectionManager connManager;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("connectionManager", &connManager);
    engine.load(QUrl::fromLocalFile("../../../../../Main.qml")); // Load directly from file system

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
