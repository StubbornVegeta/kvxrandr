#include "SetDisplayDpi.h"
#include <QDebug>
#include <QProcess>
#include <iostream>

SetDisplayDpi::SetDisplayDpi( QObject *obj, Params params)
    : m_CompentObject(obj), m_params(params)
{ }

void SetDisplayDpi::setDisplayDpi()
{
    //auto dpi = m_CompentObject->findChild<QObject *>("displayComboboxText") -> property("text").toString();
    //auto dpi = QQmlProperty::read(m_CompentObject->findChild<QObject *>("displayComboboxText"), "text").toString();
    QString dpi = QQmlProperty::read(m_CompentObject, "chooseDisplayDpi").toString();
    QString chooseDisplayDev = QQmlProperty::read(m_CompentObject, "chooseDisplayDev").toString();
    QString chooseDisplayPosition = QQmlProperty::read(m_CompentObject, "chooseDisplayPosition").toString();

    QString cmd = "xrandr --output " + chooseDisplayDev + " --mode " + dpi + " "+ chooseDisplayPosition +  m_params.native;
    //QString closeXrandr = "xrandr --output " + chooseDisplayDev + " --off;";
    //QString userModeName = "UserModeName=$(echo $(cvt " + dpi[0] + " " + dpi[1] + ") | awk '{print$13}');";
    //QString newMode = "xrandr --newmode $(echo $(cvt " + dpi[0] + " " + dpi[1] + ") | awk '{print$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24}');";
    //QString addMode = "xrandr --addmode "+ chooseDisplayDev +" $UserModeName;";
    //QString outPut = "xrandr --output "+ chooseDisplayDev + " --mode $UserModeName " + chooseDisplayPosition + m_params.native;
    QProcess process;
    process.start("/bin/sh", QStringList() << "-c" << cmd);
    process.waitForFinished();
    qDebug() << cmd;
}
