import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami 2.7 as Kirigami

Item
{
    id: control
    UiTokens { id: ui }
    property alias model : _listView.model
    property alias delegate : _listView.delegate
    property alias contentHeight : _listView.contentHeight
    property alias currentIndex : _listView.currentIndex
    property alias currentItem : _listView.currentItem
    property alias listView : _listView

    property bool searchVisible: false
    property string searchPlaceholder: qsTr("Search...")
    property alias searchText: _searchField.text

    default property alias content : _content.data

    implicitHeight: _content.implicitHeight

    ColumnLayout
    {
        id: _content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        spacing: Kirigami.Units.largeSpacing

        TextField
        {
            id: _searchField
            visible: control.searchVisible
            Layout.fillWidth: true
            placeholderText: control.searchPlaceholder
            activeFocusOnTab: true
            focusPolicy: Qt.StrongFocus
            selectByMouse: true
        }

        ListView
        {
            id: _listView
            focus: true
            keyNavigationWraps: true
            Layout.minimumHeight: 0
            Layout.preferredHeight: contentHeight
            Layout.maximumHeight:  500
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            spacing: Kirigami.Units.smallSpacing
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            Rectangle
            {
                z: control.z - 1
                anchors.fill: parent
                color: ui.listIdleColor
                radius: ui.radiusMedium
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)
            }
        }
    }
}
