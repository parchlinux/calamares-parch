

import QtQuick

Item {
    id: imageslide

    visible: false

    anchors.fill: parent

    property bool isSlide: true;

    property string notes;

    property string src;

    Image {
        id: image
        source: src
        anchors.centerIn: parent
    }
}
