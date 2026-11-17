import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

import "."

ResponsiveBase {
    id: control

    title: qsTr("Parch Settings")
    subtitle: qsTr("Fine-tune how Parch Linux is set up")
    message: qsTr("These options can also be changed after installation.")
    icon.source: "settings-configure"

    readonly property color cardColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.92)

    stackView.initialItem: ScrollView {
        id: page
        focusPolicy: Qt.NoFocus
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            width: page.availableWidth
            spacing: Kirigami.Units.largeSpacing

            // Migration Assistant Card
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: migrationCol.implicitHeight + (Kirigami.Units.largeSpacing * 2)
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: migrationCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Icon {
                            source: "document-import"
                            implicitWidth: 20
                            implicitHeight: 20
                        }
                        Label {
                            text: qsTr("Migration Assistant")
                            font.weight: Font.DemiBold
                        }
                        Item { Layout.fillWidth: true }
                        Switch {
                            checked: config.migrationEnabled
                            onToggled: config.migrationEnabled = checked
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        opacity: 0.8
                        text: qsTr("Windows and Linux installations already on this computer are detected automatically. "
                                   + "On the next pages you can pick a user account and choose which files (documents, downloads, "
                                   + "pictures, music and browser bookmarks) to import into your new home folder. "
                                   + "Turn this off to install Parch Linux without importing anything.")
                    }
                }
            }

            // Hardware clock (RTC) Card
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: rtcCol.implicitHeight + (Kirigami.Units.largeSpacing * 2)
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: rtcCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Icon {
                            source: "preferences-system-time"
                            implicitWidth: 20
                            implicitHeight: 20
                        }
                        Label {
                            text: qsTr("Hardware Clock")
                            font.weight: Font.DemiBold
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        opacity: 0.8
                        text: qsTr("Windows stores the hardware clock in local time, while Parch Linux uses UTC. "
                                   + "Automatic keeps both systems' clocks correct on dual-boot machines.")
                    }

                    RadioButton {
                        text: qsTr("Automatic")
                        checked: config.rtcMode === "auto"
                        onToggled: config.rtcMode = "auto"
                    }
                    RadioButton {
                        text: qsTr("Local time (Windows style)")
                        checked: config.rtcMode === "localtime"
                        onToggled: config.rtcMode = "localtime"
                    }
                    RadioButton {
                        text: qsTr("UTC")
                        checked: config.rtcMode === "utc"
                        onToggled: config.rtcMode = "utc"
                    }
                }
            }

            // HiDPI Card
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: hidpiCol.implicitHeight + (Kirigami.Units.largeSpacing * 2)
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: hidpiCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Icon {
                            source: "preferences-desktop-display"
                            implicitWidth: 20
                            implicitHeight: 20
                        }
                        Label {
                            text: qsTr("Display Scaling")
                            font.weight: Font.DemiBold
                        }
                        Item { Layout.fillWidth: true }
                        Switch {
                            checked: config.hidpiEnabled
                            onToggled: config.hidpiEnabled = checked
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        opacity: 0.8
                        text: qsTr("Detect high-resolution screens and pre-configure the display scale factor, "
                                   + "so the desktop is not too small after the first boot.")
                    }
                }
            }

            // Battery longevity Card
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: batteryCol.implicitHeight + (Kirigami.Units.largeSpacing * 2)
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: batteryCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Icon {
                            source: "battery"
                            implicitWidth: 20
                            implicitHeight: 20
                        }
                        Label {
                            text: qsTr("Battery Longevity Guard")
                            font.weight: Font.DemiBold
                        }
                        Item { Layout.fillWidth: true }
                        Switch {
                            checked: config.batteryGuardEnabled
                            onToggled: config.batteryGuardEnabled = checked
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        opacity: 0.8
                        text: qsTr("On supported laptops, stop charging the battery at a limit to extend its lifespan. "
                                   + "You can also change this later in the power settings.")
                    }

                    RowLayout {
                        visible: config.batteryGuardEnabled
                        Slider {
                            id: chargeLimitSlider
                            Layout.fillWidth: true
                            from: 50
                            to: 100
                            stepSize: 1
                            value: config.chargeLimit
                            onMoved: config.chargeLimit = value
                        }
                        Label {
                            text: qsTr("Charge limit: %1%").arg(config.chargeLimit)
                        }
                    }
                }
            }

            // zram Card
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: zramCol.implicitHeight + (Kirigami.Units.largeSpacing * 2)
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: zramCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    RowLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Icon {
                            source: "memory"
                            implicitWidth: 20
                            implicitHeight: 20
                        }
                        Label {
                            text: qsTr("Compressed RAM Swap (zram)")
                            font.weight: Font.DemiBold
                        }
                        Item { Layout.fillWidth: true }
                        Switch {
                            checked: config.zramEnabled
                            onToggled: config.zramEnabled = checked
                        }
                    }

                    Label {
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        opacity: 0.8
                        text: qsTr("When no swap partition or swap file is selected during partitioning, "
                                   + "set up compressed swap in RAM to keep the system responsive on low-memory machines.")
                    }
                }
            }
        }
    }

    function onActivate() {}
    function onLeave() {}
}
