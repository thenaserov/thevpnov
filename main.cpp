#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "profilemanager.h"
#include "connectionmanager.h" // Include your connection class

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ProfileManager profileManager;
    ConnectionManager connectionManager;

    // Set context properties BEFORE loading QML
    engine.rootContext()->setContextProperty("profileManager", &profileManager);
    engine.rootContext()->setContextProperty("connectionManager", &connectionManager);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("thevpnov", "Main");

    return app.exec();
}
