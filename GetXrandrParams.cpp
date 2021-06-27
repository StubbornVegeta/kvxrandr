#include "GetXrandrParams.h"
#include <QProcess>


Params GetXrandrParams()
{
    QProcess process;

    //本机设备
    process.start("/bin/sh", QStringList() << "-c" << "xrandr | grep ' primary ' | awk '{ print$1 }'");
    process.waitForFinished();
    QByteArray Native = process.readAllStandardOutput();
    QString StrNative = Native;
    StrNative = StrNative.split('\n')[0];           // 本机设备名

    //所有已连接设备
    process.start("/bin/sh", QStringList() << "-c" << "xrandr | grep ' connected ' | awk '{ print$1 }'");
    process.waitForFinished();
    QByteArray Dev = process.readAllStandardOutput();
    QString StrDev = Dev;
    QStringList DevList = StrDev.split('\n');        // 已连接的设备
    int NumDev = DevList.length()-1;                 // 已连接设备数

    process.start("/bin/sh", QStringList() << "-c" << "xrandr | grep '[0-9]x[0-9]' | awk '{ print$1 }'");
    process.waitForFinished();
    QByteArray DpiArray = process.readAllStandardOutput();
    QString StrDpi = DpiArray;
    QStringList DpiList = StrDpi.split('\n');       // 本机和扩展屏所支持的所有dpi, 但list中包括了设备名
    QList<int> DevIndex;                            // 设备名在DpiList中的索引
    int NativeIndex = 0;                            // 本机设备名在DpiList中的位置

    for (int i = 0; i<NumDev; i++){
        if (DpiList[i] == StrNative)
        {
            NativeIndex = i;
        }
        DevIndex.append(DpiList.indexOf(DevList[i]));
    }
    DevIndex.append(DpiList.length());

    // 获取本机设备分辨率
    QStringList NativeDpiList;
    for (int i = NativeIndex+1; i<DevIndex[NativeIndex+1]-1; i++)
    {
        NativeDpiList.append(DpiList[i]);
    }

    // 如果连接了两个扩展屏
    DevList.removeAt(NativeIndex);
    DevIndex.removeAt(NativeIndex);
    NumDev--;

    // 获取扩展屏设备分辨率
    QList<QStringList> DisplayDpiList;
    for (int i = 0; i<DevIndex.length()-1; i++)
    {
        QStringList tmp;
        if (DevIndex[i] < NativeIndex)
        {
            if (DevIndex[i+1] < NativeIndex)
            {
                for (int j = DevIndex[i]+1; j < DevIndex[i+1]-1; j++)
                {
                    tmp.append(DpiList[j]);
                }
                DisplayDpiList.append(tmp);
            }
            else
            {
                for (int j = DevIndex[i]+1; j < NativeIndex-1; j++)
                {
                    tmp.append(DpiList[j]);
                }
                DisplayDpiList.append(tmp);
            }
        }
        else
        {
            for (int j = DevIndex[i]+1; j < DevIndex[i+1]-1; j++)
            {
                tmp.append(DpiList[j]);
            }
            DisplayDpiList.append(tmp);
        }
    }

    Params params = {DevList, StrNative, NativeDpiList, NumDev, DisplayDpiList};
    return params;
}
