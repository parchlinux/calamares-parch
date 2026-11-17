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

    title: config.failed ? qsTr("Installation Failed") : qsTr("Finished")
    subtitle: config.failed ? qsTr("An error occurred during installation") : qsTr("Parch Linux installation is complete")
    message: config.failed ? (config.failureMessage.length ? config.failureMessage : qsTr("The installer encountered an issue and could not finish.")) : qsTr("<p>Installation logs are available as installation.log in the Live user's home and copied to /var/log/installation.log on the installed system.</p>")
    icon.source: config.failed ? "dialog-error" : "dialog-ok-apply"

    property string logSavedPath: ""

    stackView.initialItem: Item
    {
        ColumnLayout
        {
            width: Math.min(parent.width * 0.85, 650)
            anchors.centerIn: parent
            spacing: Kirigami.Units.largeSpacing

            // Success View
            ColumnLayout
            {
                visible: !config.failed
                Layout.fillWidth: true
                spacing: Kirigami.Units.largeSpacing * 2

                Label
                {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    text: qsTr("%1 has been installed on your computer.<br/>You may now restart into your new system, or continue using the Live environment.").arg(Branding.string(Branding.ProductName))
                }

                RowLayout
                {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: Kirigami.Units.largeSpacing

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

            // Failure View
            ColumnLayout
            {
                visible: config.failed
                Layout.fillWidth: true
                spacing: Kirigami.Units.largeSpacing

                Kirigami.InlineMessage
                {
                    Layout.fillWidth: true
                    visible: true
                    type: Kirigami.MessageType.Error
                    text: config.failureMessage.length ? config.failureMessage : qsTr("The installation process encountered an error and could not complete.")
                }

                ScrollView
                {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 140
                    visible: config.failureDetails.length > 0
                    clip: true

                    TextArea
                    {
                        readOnly: true
                        text: config.failureDetails
                        font.family: "monospace"
                        font.pointSize: 9
                        wrapMode: Text.Wrap
                        background: Rectangle {
                            color: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.8)
                            border.width: 1
                            border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.15)
                            radius: 6
                        }
                    }
                }

                Label
                {
                    visible: control.logSavedPath.length > 0
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    color: Kirigami.Theme.positiveTextColor
                    font.weight: Font.DemiBold
                    text: qsTr("Report saved to %1 and copied to clipboard!").arg(control.logSavedPath)
                }

                RowLayout
                {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: Kirigami.Units.largeSpacing

                    Button {
                        text: control.logSavedPath.length ? qsTr("Log Saved!") : qsTr("Save Log to Desktop")
                        icon.name: "document-save"
                        enabled: !control.logSavedPath.length
                        onClicked: {
                            control.logSavedPath = config.saveLogToDesktop()
                        }
                    }

                    Button {
                        text: qsTr("Community Support")
                        icon.name: "help-browser"
                        onClicked: {
                            Qt.openUrlExternally("https://forum.parchlinux.com")
                        }
                    }

                    Button {
                        text: qsTr("Close Installer")
                        icon.name: "application-exit"
                        onClicked: { ViewManager.quit(); }
                    }
                }
            }
        }
    }

    function onActivate() {}
    function onLeave() {}
}
