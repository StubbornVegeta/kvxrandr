#include "SetDisplayDpi.h"
#include <QQmlProperty>
#include <QProcess>

SetDisplayDpi::SetDisplayDpi( QObject *obj, Params params)
    : m_CompentObject(obj), m_params(params)
{ }

void SetDisplayDpi::setDisplayDpi()
{
    QString dpi = QQmlProperty::read(m_CompentObject, "chooseDisplayDpi").toString();
    QString chooseDisplayDev = QQmlProperty::read(m_CompentObject, "chooseDisplayDev").toString();
    QString chooseDisplayPosition = QQmlProperty::read(m_CompentObject, "chooseDisplayPosition").toString();

    QString cmd = "xrandr --output " + chooseDisplayDev + " --mode " + dpi + " "+ chooseDisplayPosition +  m_params.native;
    QProcess process;
    process.start("/bin/sh", QStringList() << "-c" << cmd);
    process.waitForFinished();
}
