import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

import "."

ResponsiveBase {
    id: control

    title: qsTr("Users")
    subtitle: qsTr("Set up your Parch Linux account")
    message: qsTr("Create your user, hostname, and password. You can adjust additional users later.")
    icon.source: "user-identity"

    readonly property color cardColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.92)
    readonly property color fieldIdle: "#FBFBFB"
    readonly property color fieldOk: "#F0FFF0"
    readonly property color fieldBad: "#EBCED1"

    stackView.initialItem: ScrollView {
        id: page
        focusPolicy: Qt.NoFocus
        clip: true
        contentWidth: availableWidth

        ColumnLayout {
            width: page.availableWidth
            spacing: Kirigami.Units.largeSpacing

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: identityCol.implicitHeight
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: identityCol
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Label { text: qsTr("Your Name"); font.weight: Font.DemiBold }
                    TextField {
                        id: fullNameField
                        Layout.fillWidth: true
                        enabled: config.isEditable("fullName")
                        placeholderText: qsTr("Your full name")
                        text: config.fullName
                        activeFocusOnTab: true
                        focusPolicy: Qt.StrongFocus
                        selectByMouse: true
                        Component.onCompleted: forceActiveFocus()
                        onTextChanged: config.setFullName(text)
                        palette.base: text.length ? fieldOk : fieldIdle
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: loginCol.implicitHeight
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: loginCol
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Label { text: qsTr("Username"); font.weight: Font.DemiBold }
                    TextField {
                        id: loginField
                        Layout.fillWidth: true
                        enabled: config.isEditable("loginName")
                        placeholderText: qsTr("Login name")
                        text: config.loginName
                        validator: RegularExpressionValidator { regularExpression: /[a-z_][a-z0-9_-]*[$]?$/ }
                        activeFocusOnTab: true
                        focusPolicy: Qt.StrongFocus
                        selectByMouse: true
                        onTextChanged: acceptableInput
                            ? ( text === "root"
                            ? forbiddenUserMessage.visible = true
                            : ( config.setLoginName(text), invalidUserMessage.visible = false, forbiddenUserMessage.visible = false ) )
                            : ( invalidUserMessage.visible = true )
                        palette.base: text.length ? (acceptableInput && text !== "root" ? fieldOk : fieldBad) : fieldIdle
                    }
                    Label {
                        Layout.fillWidth: true
                        text: qsTr("Use lowercase letters and numbers. You can add more users after install.")
                        font.pointSize: 8
                        color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.72)
                        wrapMode: Text.WordWrap
                    }
                }
            }

            Kirigami.InlineMessage {
                id: invalidUserMessage
                Layout.fillWidth: true
                visible: false
                type: Kirigami.MessageType.Error
                text: qsTr("Only lowercase letters, numbers, underscore and hyphen are allowed.")
            }

            Kirigami.InlineMessage {
                id: forbiddenUserMessage
                Layout.fillWidth: true
                visible: false
                type: Kirigami.MessageType.Error
                text: qsTr("root is not allowed as username.")
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: hostCol.implicitHeight
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: hostCol
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Label { text: qsTr("Device Name"); font.weight: Font.DemiBold }
                    TextField {
                        id: hostField
                        Layout.fillWidth: true
                        placeholderText: qsTr("Computer name")
                        text: config.hostName
                        validator: RegularExpressionValidator { regularExpression: /[a-zA-Z0-9][-a-zA-Z0-9_]+/ }
                        activeFocusOnTab: true
                        focusPolicy: Qt.StrongFocus
                        selectByMouse: true
                        onTextChanged: acceptableInput
                            ? ( text === "localhost"
                            ? forbiddenHostMessage.visible = true
                            : ( config.setHostName(text), invalidHostMessage.visible = false, forbiddenHostMessage.visible = false ) )
                            : ( invalidHostMessage.visible = true )
                        palette.base: text.length ? (acceptableInput && text !== "localhost" ? fieldOk : fieldBad) : fieldIdle
                    }
                }
            }

            Kirigami.InlineMessage {
                id: invalidHostMessage
                Layout.fillWidth: true
                visible: false
                type: Kirigami.MessageType.Error
                text: qsTr("Only letters, numbers, underscore and hyphen are allowed.")
            }

            Kirigami.InlineMessage {
                id: forbiddenHostMessage
                Layout.fillWidth: true
                visible: false
                type: Kirigami.MessageType.Error
                text: qsTr("localhost is not allowed as hostname.")
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: passCol.implicitHeight
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: passCol
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Label { text: qsTr("User Password"); font.weight: Font.DemiBold }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: Kirigami.Units.largeSpacing

                        TextField {
                            id: passField
                            Layout.fillWidth: true
                            placeholderText: qsTr("Password")
                            text: config.userPassword
                            activeFocusOnTab: true
                            focusPolicy: Qt.StrongFocus
                            selectByMouse: true
                            onTextChanged: config.setUserPassword(text)
                            echoMode: TextInput.Password
                            passwordMaskDelay: 300
                            inputMethodHints: Qt.ImhNoAutoUppercase
                            palette.base: text.length ? fieldOk : fieldIdle
                        }

                        TextField {
                            id: pass2Field
                            Layout.fillWidth: true
                            placeholderText: qsTr("Repeat password")
                            text: config.userPasswordSecondary
                            activeFocusOnTab: true
                            focusPolicy: Qt.StrongFocus
                            selectByMouse: true
                            onTextChanged: passField.text === pass2Field.text
                                ? ( config.setUserPasswordSecondary(text), passMismatch.visible = false, passValidity.visible = true )
                                : ( passMismatch.visible = true, passValidity.visible = false )
                            echoMode: TextInput.Password
                            passwordMaskDelay: 300
                            inputMethodHints: Qt.ImhNoAutoUppercase
                            palette.base: text.length ? (passField.text === pass2Field.text ? fieldOk : fieldBad) : fieldIdle
                        }
                    }

                    CheckBox {
                        visible: config.writeRootPassword
                        text: qsTr("Reuse user password as root password")
                        checked: config.reuseUserPasswordForRoot
                        onCheckedChanged: config.setReuseUserPasswordForRoot(checked)
                    }

                    CheckBox {
                        text: qsTr("Log in automatically without asking for the password")
                        checked: config.doAutoLogin
                        onCheckedChanged: config.setAutoLogin(checked)
                    }

                    CheckBox {
                        visible: config.permitWeakPasswords
                        text: qsTr("Validate password quality")
                        checked: config.requireStrongPasswords
                        onCheckedChanged: {
                            config.setRequireStrongPasswords(checked)
                            rootPassMismatch.visible = false
                        }
                    }
                }
            }

            Kirigami.InlineMessage {
                id: passMismatch
                Layout.fillWidth: true
                visible: false
                type: Kirigami.MessageType.Error
                text: config.userPasswordMessage
            }

            Kirigami.InlineMessage {
                id: passValidity
                Layout.fillWidth: true
                visible: false
                type: config.userPasswordValidity
                    ? ( config.requireStrongPasswords ? Kirigami.MessageType.Error : Kirigami.MessageType.Warning )
                    : Kirigami.MessageType.Positive
                text: config.userPasswordMessage
            }

            Rectangle {
                visible: config.writeRootPassword && !config.reuseUserPasswordForRoot
                Layout.fillWidth: true
                implicitHeight: rootCol.implicitHeight
                radius: 14
                color: cardColor
                border.width: 1
                border.color: Qt.rgba(Kirigami.Theme.textColor.r, Kirigami.Theme.textColor.g, Kirigami.Theme.textColor.b, 0.08)

                ColumnLayout {
                    id: rootCol
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Label { text: qsTr("Administrator Password"); font.weight: Font.DemiBold }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: Kirigami.Units.largeSpacing

                        TextField {
                            id: rootPassField
                            Layout.fillWidth: true
                            placeholderText: qsTr("Root password")
                            text: config.rootPassword
                            activeFocusOnTab: true
                            focusPolicy: Qt.StrongFocus
                            selectByMouse: true
                            onTextChanged: config.setRootPassword(text)
                            echoMode: TextInput.Password
                            passwordMaskDelay: 300
                            inputMethodHints: Qt.ImhNoAutoUppercase
                            palette.base: text.length ? fieldOk : fieldIdle
                        }

                        TextField {
                            id: rootPass2Field
                            Layout.fillWidth: true
                            placeholderText: qsTr("Repeat root password")
                            text: config.rootPasswordSecondary
                            activeFocusOnTab: true
                            focusPolicy: Qt.StrongFocus
                            selectByMouse: true
                            onTextChanged: rootPassField.text === rootPass2Field.text
                                ? ( config.setRootPasswordSecondary(text), rootPassMismatch.visible = false, rootPassValidity.visible = true )
                                : ( rootPassMismatch.visible = true, rootPassValidity.visible = false )
                            echoMode: TextInput.Password
                            passwordMaskDelay: 300
                            inputMethodHints: Qt.ImhNoAutoUppercase
                            palette.base: text.length ? (rootPassField.text === rootPass2Field.text ? fieldOk : fieldBad) : fieldIdle
                        }
                    }
                }
            }

            Kirigami.InlineMessage {
                id: rootPassMismatch
                Layout.fillWidth: true
                visible: false
                type: Kirigami.MessageType.Error
                text: config.rootPasswordMessage
            }

            Kirigami.InlineMessage {
                id: rootPassValidity
                Layout.fillWidth: true
                visible: false
                type: config.rootPasswordValidity
                    ? ( config.requireStrongPasswords ? Kirigami.MessageType.Error : Kirigami.MessageType.Warning )
                    : Kirigami.MessageType.Positive
                text: config.rootPasswordMessage
            }
        }
    }

    function onActivate() {}
    function onLeave() {}
}
