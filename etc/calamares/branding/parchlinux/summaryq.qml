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

    title: qsTr("Summary")
    subtitle: qsTr("Review your installation settings")
    message: qsTr("Check the actions below before the installer writes changes to disk.")
    icon.source: "view-list-details"


    stackView.initialItem: ListViewTemplate
    {
        currentIndex: -1
        model: config.summaryModel
        delegate: Control
        {
            id: _delegate

            width: ListView.view.width
            height: _template.implicitHeight + Kirigami.Units.largeSpacing
            background: Rectangle
            {
                anchors.fill: parent
                color: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.7)
                radius: 10
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)
            }

            RowLayout
            {
                id: _template
                anchors.fill: parent
                anchors.margins: Kirigami.Units.largeSpacing
                spacing: Kirigami.Units.largeSpacing

                Kirigami.Icon
                {
                    source: "help-about"
                    Layout.preferredWidth: 24
                    Layout.preferredHeight: 24
                    color: Kirigami.Theme.highlightColor
                    Layout.alignment: Qt.AlignTop
                }

                ColumnLayout
                {
                    Layout.fillWidth: true
                    spacing: Kirigami.Units.smallSpacing

                    Label
                    {
                        Layout.fillWidth: true
                        text: model.title
                        font.bold: true
                        wrapMode: Text.Wrap
                    }

                    Label
                    {
                        Layout.fillWidth: true
                        text: model.message
                        wrapMode: Text.Wrap
                        textFormat: Text.AutoText
                        opacity: 0.9
                    }
                }
            }
        }
    }

    function onActivate() {}
    function onLeave() {}
}
