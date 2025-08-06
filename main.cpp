#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "profilemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    ProfileManager manager;
    engine.loadFromModule("thevpnov", "Main");
    engine.rootContext()->setContextProperty("profileManager", &manager);
    return app.exec();
}
