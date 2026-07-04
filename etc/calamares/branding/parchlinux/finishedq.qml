import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import org.kde.kirigami 2.7 as Kirigami
import "."

ResponsiveBase
{
    id: control

    title: qsTr("Finished")
    subtitle: qsTr("Parch Linux installation is complete")
    message: qsTr("<p>Installation logs are available as installation.log in the Live user's home and copied to /var/log/installation.log on the installed system.</p>")
    icon.source: "dialog-ok-apply"


    stackView.initialItem:  Item
    {

        Column
        {
            width: parent.width * 0.7
            anchors.centerIn: parent
            spacing: Kirigami.Units.largeSpacing * 3
            Label
            {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                text:  qsTr("%1 has been installed on your computer.<br/>
                You may now restart into your new system, or continue using the Live environment.").arg(Branding.string(Branding.ProductName))
            }


            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6

                Button {
                    text: qsTr("Close Installer")
                    icon.name: "application-exit"
                    onClicked: { ViewManager.quit(); }
                }

                Button {
                    text: qsTr("Restart Into Parch Linux")
                    icon.name: "system-reboot"
                    onClicked: { config.doRestart(true); }
                }
            }
        }
    }

    function onActivate()
    {
    }

    function onLeave()
    {
    }

}
