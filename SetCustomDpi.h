#ifndef SETCUSTOMDPI_H
#define SETCUSTOMDPI_H
#include <QObject>
#include "GetXrandrParams.h"
#include <QQmlProperty>
//#include <QString>


class SetCustomDpi : public QObject
{
    Q_OBJECT

public:
    explicit SetCustomDpi(QObject *obj = nullptr, Params params={});
    QObject* m_CompentObject;
    Params m_params;

signals:

public slots:
    void setCustomDpi();

};
#endif
