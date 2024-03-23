#include "model.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>


int main(int argc, char ** argv) {
    QGuiApplication app(argc, argv);

    RecordModel model;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.setInitialProperties({{"model", QVariant::fromValue(&model)}});
    engine.load(url);

    return app.exec();
}
