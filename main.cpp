#include "model.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char ** argv) {
    QGuiApplication app(argc, argv);

    RecordModel model;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/window.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.setInitialProperties({{"listModel", QVariant::fromValue(&model)}});
    engine.load(url);

    return app.exec();
}
