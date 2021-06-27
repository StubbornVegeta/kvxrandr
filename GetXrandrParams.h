#ifndef GETXRANDRPARAMS_H
#define GETXRANDRPARAMS_H
#include <QStringList>
#include <QObject>

struct Params {
    QStringList devs;
    QString native;
    QStringList nativeDpis;
    int numDevs;
    QList<QStringList> displayDpiList;
};

Params GetXrandrParams();
#endif
