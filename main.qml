import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

Window {
    //property int $numDevs:2
    property string chooseDisplayDev:"HDMI-1"
    property string chooseDisplayPosition:"--same-as "
    property string chooseDisplayDpi:""
    title: qsTr("kvxrandr")
    id: root
    visible: true
    width: 400
    height: $numDevs==1 ? 60:($numDevs+1)*60

    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    //AutoResize {
        //fixedAspectRatio: true
        //accordingToX: true
    //}
    Text {
        id: native_
        text: $Native_
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 8
        anchors.topMargin:  8

    }

    Text {
        id: display_
        visible: $numDevs==1 ? false:true
        text: $numDevs==1? qsTr(""):$Display0
        //text: $numDevs==1? qsTr(""):qsTr("HDMI-1")
        //text: qsTr("HDMI-1")
        anchors.left: nativeDpi.left
        anchors.top: nativeDpi.bottom
        anchors.topMargin:  20
    }

    CheckBox {
        id: displayCheckBox
        visible: $numDevs==1 ? false:true
        property color checkedColor: "#333"
        width: display_.height
        height: width
        anchors.left: display_.right
        anchors.verticalCenter: display_.verticalCenter

        //text: qsTr("CheckBox")
        indicator: Rectangle {
            x: displayCheckBox.leftPadding
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width; height: width
            antialiasing: true
            radius: 2
            border.width: 2
            border.color: displayCheckBox.checkedColor

            Rectangle {
                anchors.centerIn: parent
                width: parent.width*0.7; height: width
                antialiasing: true
                radius: parent.radius * 0.7
                color: displayCheckBox.checkedColor
                visible: displayCheckBox.checked
            }
        }
        onToggled:
        {
            root.chooseDisplayDev = (displayCheckBox.checkState==2)? display_.text : "HDMI-1"
            console.log(root.chooseDisplayDev)
        }

    }

    Text {
        id: nativeDpi
        anchors.left: native_.left
        anchors.top: native_.bottom
        anchors.topMargin:  10
        text: "分辨率"
    }

    Button {
        id: nativeButton
        text: qsTr("确定")
        height:25
        anchors.left: nativeCombobox.right
        anchors.top: nativeCombobox.top
        anchors.leftMargin: 8
        background: Rectangle {
            property real combRadius: 2;
            property string disColor: "#333";
            Layout.preferredWidth: parent.width * 0.4
            border.color: nativeButton.down ? "blue" : disColor;
            border.width: nativeButton.visualFocus ? 1 : 1
            color: nativeButton.down ? "#17a81a" : "white"
            radius: combRadius
        }
        onClicked: ChangeNativeDpi()
    }

    Button {
        id: exitButton
        text: qsTr("X")
        width:18
        height:18
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 8
        anchors.topMargin: 8
        background: Rectangle {
            property real combRadius: exitButton.width*0.5;
            property string disColor: "#333";
            Layout.preferredWidth: parent.width * 0.4
            border.color: exitButton.down ? "blue" : disColor;
            border.width: exitButton.visualFocus ? 1 : 1
            color: exitButton.down ? "#17a81a" : "white"
            radius: combRadius
        }
        onClicked: root.close()
    }

    ComboBox {
        id:nativeCombobox
        width: combWidth;
        height: combHeight
        anchors.verticalCenter: nativeDpi.verticalCenter
        anchors.left: nativeDpi.right
        anchors.leftMargin: 8
        signal currentDataChanged(var text);
        property real combHeight: 25;     //复选框高度
        property real combWidth: 140;     //复选框宽度
        property real beforeIndex: 0;

        model: nativeCbItems
        background: Rectangle {
            property real combRadius: 2;
            property string disColor: "#333";
            implicitWidth: parent.width;
            implicitHeight: 25;
            border.color: nativeCombobox.pressed ? "blue" : disColor;
            border.width: nativeCombobox.visualFocus ? 1 : 1
            radius: combRadius
        }

        ListModel {
            id: nativeCbItems
            Component.onCompleted: {
                for( var dpi=0; dpi<$nativeDpis.length; ++dpi)
                {
                    append({title: $nativeDpis[dpi]});
                }
            }
        }

        onCurrentIndexChanged: {
            if(nativeCombobox.model && parseFloat(currentIndex) !== parseFloat(beforeIndex)) {
                beforeIndex = currentIndex;
                displayText = nativeCbItems.get(currentIndex).title
                //currentDataChanged(displayText);
                console.debug(displayText)
                console.debug($nativeDpis.length)
            }
        }
    }

    Text {
        id: displayDpi
        visible: $numDevs==1 ? false:true
        anchors.left: display_.left
        anchors.top: display_.bottom
        anchors.topMargin:  10
        text: "分辨率"
    }

    signal displaySend();
    Button {
        id: displayButton
        visible: $numDevs==1 ? false:true
        text: qsTr("确定")
        height:25
        anchors.left: displayPos.right
        anchors.top: displayPos.top
        anchors.leftMargin: 8
        background: Rectangle {
            property real combRadius: 2;
            property string disColor: "#333";
            Layout.preferredWidth: parent.width * 0.4
            border.color: displayButton.down ? "blue" : disColor;
            border.width: displayButton.visualFocus ? 1 : 1
            color: displayButton.down ? "#17a81a" : "white"
            radius: combRadius
        }
        onClicked: displaySend()
    }

    ComboBox {
        id: displayCombobox
        visible: $numDevs==1 ? false:true
        width: combWidth;
        height: combHeight
        anchors.verticalCenter: displayDpi.verticalCenter
        anchors.left: displayDpi.right
        anchors.leftMargin: 8

        //signal currentDataChanged(var text);
        property real combHeight: 25     //复选框高度
        property real combWidth: 140     //复选框宽度
        property real beforeIndex: 0
        //property string displayText: ""

        model: displayCbItems
        background: Rectangle {
            property real combRadius: 2;
            property string disColor: "#333";
            implicitWidth: parent.width;
            implicitHeight: 25;
            border.color: displayCombobox.pressed ? "blue" : disColor;
            border.width: displayCombobox.visualFocus ? 1 : 1
            radius: combRadius
        }

        ListModel {
            id: displayCbItems
            Component.onCompleted: {
                if ($numDevs==1) {}
                else
                {
                    for( var dpi=0; dpi<$displayDpiList0.length; ++dpi)
                    {
                        append({title: $displayDpiList0[dpi]});
                    }
                }
            }
        }

        onCurrentIndexChanged: {
            if(displayCombobox.model && parseFloat(currentIndex) !== parseFloat(beforeIndex)) {
                beforeIndex = currentIndex;
                displayText = displayCbItems.get(currentIndex).title
                chooseDisplayDpi = displayText
                //displaySend()
                //currentDataChanged(displayText);
                console.debug(displayText)
            }
        }
    }


    ComboBox {
        id: displayPos
        visible: $numDevs==1 ? false:true
        width: combWidth;
        height: combHeight
        anchors.verticalCenter: displayCombobox.verticalCenter
        anchors.left: displayCombobox.right
        anchors.leftMargin: 8
        //signal currentDataChanged(var text);
        property real combHeight: 25;     //复选框高度
        property real combWidth: 80;     //复选框宽度
        property real beforeIndex: 0;

        background: Rectangle {
            property real combRadius: 2;
            property string disColor: "#333";
            implicitWidth: parent.width;
            implicitHeight: 25;
            border.color: displayPos.pressed ? "blue" : disColor;
            border.width: displayPos.visualFocus ? 1 : 1
            radius: combRadius
        }

        model: ListModel {
            id: displayPosCbItems
            //model: $Dpi.m_model
            ListElement { title: qsTr("复制")}
            ListElement { title: qsTr("左侧")}
            ListElement { title: qsTr("右侧")}
            ListElement { title: qsTr("上方")}
            ListElement { title: qsTr("下方")}
        }

        onCurrentIndexChanged: {
            if(displayPos.model && parseFloat(currentIndex) !== parseFloat(beforeIndex)) {
                beforeIndex = currentIndex;
                //displayText = displayPosCbItems.get(currentIndex).title
                //currentDataChanged(displayText);
                switch (displayPosCbItems.get(currentIndex).title) {
                    case qsTr("上方"): {
                        root.chooseDisplayPosition = "--above "
                        break
                    }
                    case qsTr("下方"): {
                        root.chooseDisplayPosition = "--below "
                        break
                    }
                    case qsTr("左侧"): {
                        root.chooseDisplayPosition = "--left-of "
                        break
                    }
                    case qsTr("右侧"): {
                        root.chooseDisplayPosition = "--right-of "
                        break
                    }
                    default: {
                        root.chooseDisplayPosition = "--same-as "
                        break
                    }
                }
                console.debug(root.chooseDisplayPosition)
            }
        }
    }

    Text {
        id: customX
        visible: $numDevs==1 ? false:true
        text: qsTr("自定义长度")
        anchors.left: native_.left
        anchors.top: displayDpi.bottom
        anchors.topMargin:  30
    }

    TextField{
        id: inputX
        visible: $numDevs==1 ? false:true
        objectName: "inputX"
        width: 60
        height:25
        //implicitWidth: 60;
        //implicitHeight: 25;
        anchors.verticalCenter: customX.verticalCenter
        anchors.left: customX.right
        anchors.leftMargin: 8
        property color checkedColor: "#333"
        placeholderText: qsTr("1368")
        antialiasing: true

        background: Rectangle {
            radius: 4
            color: inputX.enabled ? "transparent" : "#F4F6F6"
            border.color: inputX.enabled ? inputX.checkedColor : "#D5DBDB"
            border.width: 1
            opacity: inputX.enabled ? 1 : 0.7

            layer.enabled: inputX.hovered
            layer.effect: DropShadow {
                id: dropShadow
                transparentBorder: true
                color: inputX.checkedColor
                samples: 2 /*20*/
            }
        }
    }


    Text {
        id: customY
        visible: $numDevs==1 ? false:true
        text: qsTr("自定义宽度")
        anchors.left: inputX.right
        anchors.verticalCenter: inputX.verticalCenter
        anchors.leftMargin: 15
    }

    TextField{
        id: inputY
        visible: $numDevs==1 ? false:true
        width: 60
        height:25
        //implicitWidth: 60;
        //implicitHeight: 25;
        anchors.verticalCenter: customY.verticalCenter
        anchors.left: customY.right
        anchors.leftMargin: 8
        property color checkedColor: "#333"
        placeholderText: qsTr("768")
        antialiasing: true

        background: Rectangle {
            radius: 4
            color: inputY.enabled ? "transparent" : "#F4F6F6"
            border.color: inputY.enabled ? inputY.checkedColor : "#D5DBDB"
            border.width: 1
            opacity: inputY.enabled ? 1 : 0.7

            layer.enabled: inputY.hovered
            layer.effect: DropShadow {
                id: dropShadow
                transparentBorder: true
                color: inputY.checkedColor
                samples: 2 /*20*/
            }
        }
    }


    signal customSend();
    Button {
        visible: $numDevs==1 ? false:true
        property variant customDpi
        property variant customDpiX
        property variant customDpiY
        id: customButton
        objectName:"customButton"
        text: qsTr("确定")
        height:25
        anchors.left: inputY.right
        anchors.verticalCenter: inputY.verticalCenter
        anchors.leftMargin: 15
        background: Rectangle {
            property real combRadius: 2;
            property string disColor: "#333";
            border.color: customButton.down ? "blue" : disColor;
            border.width: customButton.visualFocus ? 1 : 1
            color: customButton.down ? "#17a81a" : "white"
            radius: combRadius
        }
        onClicked:{
            customDpiX = (inputX.text=="") ? inputX.placeholderText:inputX.text
            customDpiY = (inputY.text=="") ? inputY.placeholderText:inputY.text
            customDpi = [customDpiX, customDpiY]
            customSend()
        }
    }
    //Component.onCompleted: {     //建立连接
        //send.connect(onSend)     //信号与槽的连接
    //}
}
