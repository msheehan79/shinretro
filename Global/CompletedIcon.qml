import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
    id: completedtag
    property var game
    property double parentImageWidth
    property bool isGridView

    visible: {
        if ((game !== undefined) && (game.completed !== undefined) && (game.completed == true)) {
            return true;
        } else if ((game !== undefined) && (game.extra.completed !== undefined) && (game.extra.completed.toString() === 'True')) {
            return true;
        } else {
            return false;
        }
    }
    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }
    width: parent.width
    height: isGridView ? parent.height / 5 : parent.height

    Image {
        id: completedbg
        anchors.centerIn: parent
        source: "../assets/ribbon.svg"
        fillMode: Image.PreserveAspectFit
        width: completedTxt.width * 1.75
        height: completedTxt.height * 1.75
    }

    Text {
        id: completedTxt
        anchors {
            centerIn: completedbg
            verticalCenterOffset: -vpx(completedbg.height * 0.075)
        }
        text: dataText[lang].games_completed
        font {
            family: montserratMedium.name
            weight: Font.Bold
            pixelSize: vpx(parentImageWidth * 0.025)
        }
        color: colorScheme[theme].textlight
        z: 15
    }

    ColorOverlay {
        anchors.fill: completedbg
        source: completedbg
        cached: true
        color: colorScheme[theme].completed
        z: 10
    }

}