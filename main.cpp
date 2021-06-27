#include <QGuiApplication>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QQmlContext>
//#include <QQuickItem>
//#include <QCoreApplication>
//#include <QQmlApplicationEngine>
#include "GetXrandrParams.h"
#include "SetCustomDpi.h"
#include "SetDisplayDpi.h"
//#include <QDebug>
//#include <iostream>


int main(int argc, char** argv)
{
    QGuiApplication app(argc, argv);
    QQmlEngine engine;

    Params params = GetXrandrParams();
    engine.rootContext()->setContextProperty("$Native_", params.native);
    for (int i = 0; i<params.numDevs; i++)
    {
        engine.rootContext()->setContextProperty("$Display"+QString::number(i), params.devs[i]);
        engine.rootContext()->setContextProperty("$displayDpiList"+QString::number(i), params.displayDpiList[i]);
    }
    engine.rootContext()->setContextProperty("$numDevs", params.numDevs+1);
    engine.rootContext()->setContextProperty("$nativeDpis", params.nativeDpis);
    QQmlComponent compent(&engine, QUrl(QStringLiteral("qrc:/main.qml")));
    QObject* CompentObject = compent.create();

    SetCustomDpi customDpi(CompentObject, params);
    SetDisplayDpi displayDpi(CompentObject, params);

    if (params.numDevs > 0) {
        QObject::connect(CompentObject, SIGNAL(customSend()), &customDpi, SLOT(setCustomDpi()) );
        QObject::connect(CompentObject, SIGNAL(displaySend()), &displayDpi, SLOT(setDisplayDpi()) );
    }

    return app.exec();
}
