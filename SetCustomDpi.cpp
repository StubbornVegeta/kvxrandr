#include "SetCustomDpi.h"
#include <QDebug>
#include <QProcess>
#include <iostream>

SetCustomDpi::SetCustomDpi( QObject *obj, Params params)
    : m_CompentObject(obj), m_params(params)
{ }

void SetCustomDpi::setCustomDpi()
{
    auto dpi = m_CompentObject->findChild<QObject *>("customButton") -> property("customDpi").toStringList();
    QString chooseDisplayDev = QQmlProperty::read(m_CompentObject, "chooseDisplayDev").toString();
    QString chooseDisplayPosition = QQmlProperty::read(m_CompentObject, "chooseDisplayPosition").toString();

    /*
    UserMode=$(cvt $1 $2)
    UserModeName=$(echo $UserMode | awk '{print$13}')
    xrandr --newmode $(echo $UserMode | awk '{print$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24}')
    xrandr --addmode $Display $UserModeName
    xrandr --output $Display --mode $UserModeName --same-as $Native
    */

    QString closeXrandr = "xrandr --output " + chooseDisplayDev + " --off;";
    QString userModeName = "UserModeName=$(echo $(cvt " + dpi[0] + " " + dpi[1] + ") | awk '{print$13}');";
    QString newMode = "xrandr --newmode $(echo $(cvt " + dpi[0] + " " + dpi[1] + ") | awk '{print$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24}');";
    QString addMode = "xrandr --addmode "+ chooseDisplayDev +" $UserModeName;";
    QString outPut = "xrandr --output "+ chooseDisplayDev + " --mode $UserModeName " + chooseDisplayPosition + m_params.native;
    QProcess process;
    process.start("/bin/sh", QStringList() << "-c" << userModeName+newMode+addMode+outPut);
    process.waitForFinished();
    //QByteArray Ret = process.readAllStandardOutput();
    //QString StrRet = Ret;
    //qDebug() << Ret;
}
