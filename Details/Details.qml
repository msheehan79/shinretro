import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12
import SortFilterProxyModel 0.2
import QtMultimedia 5.15
import "qrc:/qmlutils" as PegasusUtils
import "../Global"

FocusScope {
    id: testDetails

    readonly property string touch_colorBright: (dataConsoles[clearedShortname] !== undefined) ? dataConsoles[clearedShortname].color : dataConsoles["default"].color
    readonly property string touch_colorDimm: touch_colorBright.replace(/#/g, "#77");
    readonly property string touch_color: (accentColor === "bright") ? touch_colorBright : touch_colorDimm
    readonly property string alt_color2: (dataConsoles[clearedShortname] !== undefined) ? dataConsoles[clearedShortname].altColor2 : dataConsoles["default"].altColor2
    readonly property string alt_color: (dataConsoles[clearedShortname] !== undefined) ? dataConsoles[clearedShortname].altColor : dataConsoles["default"].altColor


    property var currentIndex
    property var currentGame

    // Transition Animation
    Behavior on focus {
        ParallelAnimation {
            PropertyAnimation {
                target: skew_color
                property: "anchors.leftMargin"
                from: parent.width * 0.725
                to: -parent.width * 0.1
                duration: 250
            }
        }
    }

    // Skewed background
    Rectangle {
        id: skew_color
        width: parent.width * 0.40
        height: parent.height
        antialiasing: true
        anchors {
            left: parent.left
            leftMargin: -parent.width * 0.1
        }
        color: touch_color
        Behavior on color {
            ColorAnimation { duration: 250; }
        }

        transform: Matrix4x4 {
            property real a: 12 * Math.PI / 180
            matrix: Qt.matrix4x4(
                1,      -Math.tan(a),       0,      0,
                0,      1,                  0,      0,
                0,      0,                  1,      0,
                0,      0,                  0,      1
            )
        }
    }

    // Completed Banner
    Rectangle {
        width: vpx(250)
        height: vpx(50)
        anchors {
            top: parent.top
            topMargin: vpx(25)
            right: parent.right
            rightMargin: vpx(50)
        }

        CompletedIcon {
            parentImageWidth: 800
            isGridView: false
        }

        visible: currentGame.completed == true
    }

    // Content
    Item {
        width: parent.width * 0.90
        anchors {
            top: parent.top
            bottom: parent.bottom
            topMargin: vpx(75)
            bottomMargin: vpx(30)
            horizontalCenter: parent.horizontalCenter
        }

        // Box Art
        RowLayout {
            anchors.fill: parent
            spacing: vpx(40)

            Column {
                Layout.preferredHeight: parent.height;
                Layout.preferredWidth: parent.width * 0.25;

                Item {
                    height: parent.height * 0.65
                    width: parent.width
                    Loader {
                        id: loader_boxart
                        anchors {
                            fill: parent
                        }
                        asynchronous: true
                        sourceComponent: DetailItemBoxFront {
                            game: currentGame
                        }
                        active: true
                        visible: status === Loader.Ready
                    }
                }
            }

            ColumnLayout {
                Layout.preferredWidth: parent.width * 0.5;
                Layout.alignment: Qt.AlignTop
                spacing: 2

                // TITLE
                Text {
                    id: title_text
                    Layout.alignment: Qt.AlignTop
                    Layout.preferredWidth: parent.width
                    Layout.fillHeight: false
                    text: currentGame.title
                    elide: Text.ElideRight
                    font {
                        family: robotoSlabRegular.name
                        pixelSize: vpx(40)
                    }
                    maximumLineCount: 2
                    wrapMode: Text.Wrap
                    color: text_color
                }

                Row {
                    id: details_row
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: vpx(5)
                    Layout.preferredWidth: parent.width
                    spacing: vpx(15)

                    // PLAYERS
                    Rectangle {
                        width: txt_players.contentWidth + vpx(20)
                        height: txt_players.contentHeight + vpx(10)
                        color: colorScheme[theme].secondary
                        border {
                            width: vpx(1)
                            color: colorScheme[theme].secondary
                        }

                        Text {
                            id: txt_players
                            property string convertPlayer: currentGame.players > 1 ? "1-" + currentGame.players + " " + dataText[lang].games_players : dataText[lang].games_player
                            anchors.centerIn: parent
                            text: convertPlayer
                            font {
                                family: global.fonts.sans
                                weight: Font.Black
                                pixelSize: vpx(12 * fontScalingFactor)
                            }
                            color: colorScheme[theme].text
                        }
                    }

                    // FAVORITE
                    Rectangle {
                        width: txt_favorited.contentWidth + vpx(20)
                        height: txt_favorited.contentHeight + vpx(10)
                        color: colorScheme[theme].favorite.replace(/#/g, "#33");

                        Text {
                            id: txt_favorited
                            anchors.centerIn: parent
                            text: dataText[lang].games_favorited
                            font {
                                family: global.fonts.sans
                                weight: Font.Black
                                pixelSize: vpx(12 * fontScalingFactor)
                            }
                            color: colorScheme[theme].favorite
                        }
                        visible: currentGame.favorite
                    }

                    // GENRE
                    Repeater {
                        model: currentGame.genre.split(" / ") || ""
                        delegate: Rectangle {
                            width: txt_genre.contentWidth + vpx(20)
                            height: txt_genre.contentHeight + vpx(10)
                            color: colorScheme[theme].secondary
                            border {
                                width: vpx(1)
                                color: colorScheme[theme].secondary
                            }

                            Text {
                                id: txt_genre
                                anchors.centerIn: parent
                                text: modelData
                                font {
                                    family: global.fonts.sans
                                    weight: Font.Medium
                                    pixelSize: vpx(12 * fontScalingFactor)
                                }
                                color: colorScheme[theme].text
                            }
                            visible: (modelData !== "")
                        }
                    }

                    // Arcade Port
                    Rectangle {
                        width: txt_arcadeport.contentWidth + vpx(20)
                        height: txt_arcadeport.contentHeight + vpx(10)
                        color: alt_color2
                        border {
                            width: vpx(1)
                            color: alt_color2
                        }

                        Text {
                            id: txt_arcadeport
                            anchors.centerIn: parent
                            text: dataText[lang].games_arcadeport
                            font {
                                family: global.fonts.sans
                                weight: Font.Medium
                                pixelSize: vpx(12)
                            }
                            color: lightOrDark(alt_color2) === "light" ? colorScheme[theme].textdark : colorScheme[theme].textlight
                        }
                        visible: (currentGame.extra.arcadeport !== undefined) && (currentGame.extra.arcadeport.toString() === 'True')
                    }

                    // RATING
                    RatingStars {
                        anchors {
                            verticalCenter: parent.verticalCenter
                        }
                        readonly property double rating: (currentGame.rating * 5).toFixed(1)
                    }
                }

                // DESCRIPTION
                Row {
                    id: description_row
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: vpx(5)
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: vpx(210)

                    PegasusUtils.AutoScroll {
                        height: parent.height
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: vpx(10)
                        Text {
                            width: parent.width
                            text: (currentGame.description || currentGame.summary) ? (currentGame.description || currentGame.summary) : dataText[lang].games_withoutDescription
                            font {
                                family: global.fonts.condensed
                                weight: Font.Light
                                pixelSize: vpx(14 * fontScalingFactor)
                            }
                            wrapMode: Text.WordWrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignLeft
                            color: text_color
                        }
                    }
                }

                // Buttons
                Row {
                    id: buttonsRow
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: vpx(35)
                    Layout.preferredWidth: parent.width
                    spacing: vpx(20)

                    Controls {
                        id: button_R

                        message: dataText[lang].global_back

                        text_color: colorScheme[theme].cancel
                        front_color: colorScheme[theme].cancel.replace(/#/g, "#26");
                        back_color: colorScheme[theme].cancel.replace(/#/g, "#26");
                        input_button: osdScheme[controlScheme].BTNR
                    }

                    Controls {
                        id: button_D

                        message: dataText[lang].games_play;

                        text_color: colorScheme[theme].sorters
                        front_color: colorScheme[theme].sorters.replace(/#/g, "#26");
                        back_color: colorScheme[theme].sorters.replace(/#/g, "#26");
                        input_button: osdScheme[controlScheme].BTND
                    }

                    Controls {
                        id: button_U

                        message: currentGame !== null && currentGame.completed ? dataText[lang].games_removeCompleted : dataText[lang].games_markCompleted

                        text_color: colorScheme[theme].filters
                        front_color: colorScheme[theme].filters.replace(/#/g, "#26");
                        back_color: colorScheme[theme].filters.replace(/#/g, "#26");
                        input_button: osdScheme[controlScheme].BTNU
                    }

                    Controls {
                        id: button_L

                        message: currentGame !== null && currentGame.favorite ? dataText[lang].games_removeFavorite : dataText[lang].games_addFavorite

                        text_color: colorScheme[theme].details
                        front_color: colorScheme[theme].details.replace(/#/g, "#26");
                        back_color: colorScheme[theme].details.replace(/#/g, "#26");
                        input_button: osdScheme[controlScheme].BTNL

                        visible: currentGame !== null
                    }
                }
            }

            // Overlay / Addt'l artwork
            Column {
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                topPadding: vpx(20)
                spacing: 0

                GridLayout {
                    id: addtl_details_grid
                    columns: 2
                    Layout.preferredWidth: vpx(20)

                    Text {
                        text: dataText[lang].details_released
                        font {
                            family: global.fonts.sans
                            weight: Font.Bold
                            pixelSize: vpx(16 * fontScalingFactor)
                        }
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        color: alt_color
                    }
                    Text {
                        text: currentGame.releaseYear || dataText[lang].games_na
                        font {
                            family: robotoSlabRegular.name
                            pixelSize: vpx(16 * fontScalingFactor)
                        }
                        Layout.preferredWidth: parent.width / 1.5
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        color: text_color
                    }
                    Text {
                        text: dataText[lang].details_developer
                        font {
                            family: global.fonts.sans
                            weight: Font.Bold
                            pixelSize: vpx(16 * fontScalingFactor)
                        }
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        color: alt_color
                    }
                    Text {
                        text: currentGame.developer
                        font {
                            family: global.fonts.sans
                            weight: Font.Medium
                            pixelSize: vpx(16 * fontScalingFactor)
                        }
                        Layout.preferredWidth: parent.width / 1.5
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        color: text_color
                    }
                    Text {
                        text: dataText[lang].details_publisher
                        font {
                            family: global.fonts.sans
                            weight: Font.Bold
                            pixelSize: vpx(16 * fontScalingFactor)
                        }
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        color: alt_color
                    }
                    Text {
                        text: currentGame.publisher
                        font {
                            family: global.fonts.sans
                            weight: Font.Medium
                            pixelSize: vpx(16 * fontScalingFactor)
                        }
                        Layout.preferredWidth: parent.width / 1.5
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignLeft
                        color: text_color
                    }
                }

                // Screenshot
                Loader {
                    id: loader_screenshot
                    height: parent.height * 0.4
                    anchors {
                        top: addtl_details_grid.bottom
                        topMargin: vpx(10)
                        left: parent.left
                        right: parent.right
                    }
                    asynchronous: true
                    sourceComponent: screenshot_image
                    active: true
                    visible: status === Loader.Ready
                }

                Component {
                    id: screenshot_image
                    Image {
                        id: img_screenshot
                        source: currentGame.assets.screenshot || gameData.assets.titlescreen || gameData.assets.background || ""
                        anchors {
                            fill: parent
                        }
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignTop
                        smooth: false
                        asynchronous: true
                        visible: currentGame.assets.screenshot || gameData.assets.titlescreen || gameData.assets.background
                    }
                }

                // Overlay
                Loader {
                    id: loader_overlay
                    width: parent.width * 0.75
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        top: loader_screenshot.bottom
                        topMargin: -vpx(55)
                    }
                    asynchronous: true
                    sourceComponent: overlay_image
                    active: true
                    visible: status === Loader.Ready
                }

                Component {
                    id: overlay_image
                    Image {
                        id: img_game_overlay
                        source: currentGame.assets.background
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignHCenter
                        verticalAlignment: Image.AlignVCenter
                        smooth: false
                        asynchronous: true
                        visible: currentGame.assets.background != ""
                    }
                }
            }

        }
    }

    Component.onCompleted: {
        currentGame = api.memory.get("currentGame") || currentGame
    }

    Keys.onPressed: {
        if (event.isAutoRepeat) {
            return;
        }

        if (api.keys.isAccept(event)) {
            event.accepted = true;
            playPlaySound();
            if (currentGame !== null && !currentGame.missing) {
                api.memory.set('currentGame', currentGame);
                currentGame.launch();
            }
        }

        if (api.keys.isFilters(event)) {
            event.accepted = true;
            if (currentGame !== null) {
                currentGame.completed = !currentGame.completed;
            }
            return;
        }

        if (api.keys.isCancel(event)) {
            event.accepted = true;
            playBackSound();
            currentMenuIndex = 3;
            return;
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true;
            if (currentGame !== null) {
                currentGame.favorite = !currentGame.favorite;
            }
            return;
        }
    }

}

