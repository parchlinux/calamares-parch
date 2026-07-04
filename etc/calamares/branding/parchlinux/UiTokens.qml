import QtQuick
import org.kde.kirigami 2.7 as Kirigami

QtObject {
    readonly property int radiusSmall: 8
    readonly property int radiusMedium: 14
    readonly property int radiusLarge: 20
    readonly property int gapSmall: Kirigami.Units.smallSpacing
    readonly property int gapMedium: Kirigami.Units.largeSpacing
    readonly property int gapLarge: Kirigami.Units.largeSpacing * 2
    readonly property int titlePointSize: 25
    readonly property int subtitlePointSize: 13
    readonly property int bodyPointSize: 10
    readonly property color cardColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.92)
    readonly property color listIdleColor: Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.55)
    readonly property color listHoverColor: Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.2)
}
