import io.calamares.ui 1.0

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami 2.7 as Kirigami

ItemDelegate
{
    id: control
    UiTokens { id: ui }


    property alias label1 : _label1
    property alias label2 : _label2

    hoverEnabled: true
    focusPolicy: Qt.StrongFocus
    highlighted: isCurrentItem

    property bool isCurrentItem: ListView.isCurrentItem
    background: Rectangle
    {
        color: isCurrentItem ? Kirigami.Theme.highlightColor : (hovered ? ui.listHoverColor : ui.listIdleColor)
        opacity: isCurrentItem ? 1 : 0.95
        radius: ui.radiusSmall
        border.width: 1
        border.color: isCurrentItem ? Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.8) : Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)
    }

    implicitWidth: ListView.view.width
    implicitHeight: Math.max(48, _layout.implicitHeight + Kirigami.Units.largeSpacing *2)

    Keys.onReturnPressed: clicked()
    Keys.onEnterPressed: clicked()

    contentItem: RowLayout
    {
        id: _layout
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        Label
        {
            id: _label1
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Qt.AlignLeft
            color: isCurrentItem ? Kirigami.Theme.highlightedTextColor : Kirigami.Theme.textColor
        }

          Label
        {
            id: _label2
            visible: text.length
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.4
            horizontalAlignment: Qt.AlignRight
            color: isCurrentItem ? Kirigami.Theme.highlightedTextColor : Kirigami.Theme.textColor
            opacity: isCurrentItem ? 1 : 0.7
            font.weight: Font.Light
            wrapMode: Text.Wrap
        }

        Kirigami.Icon
        {
            source: "emblem-default"
            Layout.preferredWidth: 22
            Layout.preferredHeight: 22
            color: Kirigami.Theme.highlightedTextColor
            visible: isCurrentItem
        }
    }
}
