import io.calamares.ui 1.0

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami 2.7 as Kirigami

import "."

ResponsiveBase
{
    id: control

    title: stackView.currentItem.title
    subtitle: stackView.currentItem.subtitle
    message: stackView.currentItem.message
    icon.source: stackView.currentItem.icon

    property string currentRegion
    property string currentZone

    stackView.initialItem: ListViewTemplate
    {
        id: _regionListView

        property string title: qsTr("Region")
        property string subtitle: qsTr("Choose your region for language and time defaults")
        property string message:  qsTr("Then select your timezone to match local date and time.")
        property string icon : "preferences-desktop-locale"

        model: config.regionModel
        currentIndex : -1

        delegate: ListItemDelegate
        {
            id: _delegate
            label1.text:  model.name
            onClicked:
            {
                _regionListView.currentIndex = index
                control.currentRegion = model.name
                config.regionalZonesModel.region = control.currentRegion
                control.stackView.push(_zonesListComponent)
            }
        }

        Button
        {
            Layout.fillWidth: true
            text: qsTr("Timezones")
            icon.name: "preferences-system-time"
            onClicked: control.stackView.push(_zonesListComponent)
        }
    }

    Component
    {
        id: _zonesListComponent

        ListViewTemplate
        {
            id: _zonesListView
            property string title: qsTr("Timezone")
            property string subtitle: qsTr("Select the city or zone that matches your location")
            property string message: ""
            property string icon : "preferences-system-time"

            model: config.regionalZonesModel
            currentIndex : -1

            delegate: ListItemDelegate
            {
                id: _delegate
                label1.text: model.name
                onClicked:
                {
                    _zonesListView.currentIndex = index
                    control.currentZone = model.name

                    _zonesListView.listView.positionViewAtIndex(index, ListView.Center)

                    config.setCurrentLocation(control.currentRegion, control.currentZone)

                }
            }
        }
    }
}
