#ifndef SETDISPLAYDPI_H
#define SETDISPLAYDPI_H
#include <QObject>
#include "GetXrandrParams.h"


class SetDisplayDpi : public QObject
{
    Q_OBJECT

public:
    explicit SetDisplayDpi(QObject *obj = nullptr, Params params={});
    QObject* m_CompentObject;
    Params m_params;

signals:

public slots:
    void setDisplayDpi();

};
#endif
