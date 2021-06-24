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

//class GetDpi : public QObject {
    //Q_OBJECT
    //Q_PROPERTY(QStringList model MEMBER m_model NOTIFY modelChanged)
    //QStringList m_model;
  //public slots:
    //void setModel(QString m) {
      //m_model = m.split("\n");
      //modelChanged();
    //}
  //signals:
    //void modelChanged();
//};

//QStringList GetXrandrDevs();
//QStringList GetXrandrDpis(QStringList& DevList);

Params GetXrandrParams();
#endif
