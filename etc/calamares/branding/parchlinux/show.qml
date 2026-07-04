

import QtQuick
import calamares.slideshow 1.0
import io.calamares.ui 1.0  // Calamares internals: Branding

Presentation
{
    id: presentation

    Timer {
        interval: 30000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    function onActivate() { }
    function onLeave() { }

    Rectangle {
        id: mybackground
        anchors.fill: parent
        color: Branding.styleString(Branding.SidebarBackground)
        z: -1
    }

    ImageSlide {
        src: "slide01.png"
    }

    ImageSlide {
        src: "slide02.png"
    }

    ImageSlide {
        src: "slide03.png"
    }

    ImageSlide {
        src: "slide04.png"
    }

    ImageSlide {
        src: "slide05.png"
    }

    ImageSlide {
        src: "slide06.png"
    }

    ImageSlide {
        src: "slide07.png"
    }

    ImageSlide {
        src: "slide08.png"
    }

    ImageSlide {
        src: "slide09.png"
    }

    ImageSlide {
        src: "slide10.png"
    }


}
