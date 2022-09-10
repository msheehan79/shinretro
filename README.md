<img src="assets/logo_shinretro.png" width="55%" title="shinretro logo" />

# shinretro-custom

A modified version of the excellent Shinretro theme, with several performance fixes, new features and some personal preference-type updates (theme art, logos, favorite icon etc)

Key features/changes to the base theme (some of these will likely be incorporated into upstream as well, but noting here for reference and guidance:

**Personal preference changes**
 - Changed favorites icon to use the icon and design from the gameOS theme (https://github.com/PlayingKarrde/gameOS)
 - Changed the currently selected game border to use a color cycle animation to make it more clear. The color of the border can either be consistent across the color theme, or can change based on the particular collection (settings option)
 - Manufacturer logo shown on the Collections screen uses a different look + feel
 - Some different background art/logos or color theme choices for the various collections or base themes

**Usability/Performance Adjustments**
 - Page up/Page down can be configured via settings to either skip to next/previous collection when in the game grid view (default), or can instead be used to rapidly scroll up/down the games list for quicker navigation of large collections
 - The collections carousel now supports press & hold to quickly scroll through the list
 - Several updates to improve performance so no stutters or delays when scrolling through collections or games, or loading the theme etc
 - Will automatically render the game title, year and detail text as either dark or light color depending on the background color to ensure readability in all configurations

**New Features**
- Dedicated Last Played + Favorites collections can be enabled or disabled via Settings menu
- Collection Category support (requires custom metadata, detaileded below) - able to group collections into Categories - use the Filters key to toggle each category in the collections view
- Collection Sorting - Use the Select/Back button on the controller to toggle sorting game grid by Title/Last Played/Favorite/Genre or Rating.
- Custom Sorting (requires custom metadata, will be detailed below soon) - define a custom sort order for specific collections based on game metadata values
- Completed Game Ribbon (requires custom metadata, detaileded below) - Adds a "Completed" ribbon to games you've marked as complete in your game metadata
- Arcade Port tag (requires custom metadata, detailed below) - Adds an "Arcade Port" icon to the games detail view if you've marked the game as an arcade port in your game metadata

WIP - More to come as I think of it and will include details on the custom metadata needed for some of the above features.

----------------

Current Version: [0.138](CHANGELOG.md) [![GPLv3 license](https://img.shields.io/badge/license-GPLv3-blue.svg)](LICENSE)

A flexible and tweakable theme for [Pegasus Frontend](http://pegasus-frontend.org).
Forked from [Valentin MEZIN](https://github.com/valsou)'s theme [neoretrō](https://github.com/valsou/neoretro) v0.131 and [Luciano Oliveira](https://github.com/luciano-work)'s dark variant.

***

<details>
  <summary><b>Screenshots</b></summary>
  <img src="assets/screenshot/home_dark.png"  title="home"/>
  <img src="assets/screenshot/home_light.png" title="home"/>
  <img src="assets/screenshot/home_ozonedark.png"  title="home"/>
  <img src="assets/screenshot/collection_dark.png" title="collections" />
  <img src="assets/screenshot/collection_light.png" title="collections" />
  <img src="assets/screenshot/collection_ozonedark.png" title="collections" />
  <img src="assets/screenshot/games_dark.png" title="games" />
  <img src="assets/screenshot/games_light.png" title="games" />
  <img src="assets/screenshot/games_ozonedark.png" title="games" />
  <img src="assets/screenshot/settings_dark.png" title="settings" />
  <img src="assets/screenshot/settings_light.png" title="settings" />
  <img src="assets/screenshot/settings_ozonedark.png" title="settings" />
  <img src="assets/screenshot/arcade_port.png" title="arcade port flag" />
  <img src="assets/screenshot/completed.png" title="completed ribbon" />
  <img src="assets/screenshot/collectiontypes.png" title="collection types" />
</details>

***

<details>
  <summary><b>Videos</b></summary>
  
  Theme review by [Retro Gaming Replay](https://www.youtube.com/channel/UC_9gbkxeMk3usXvSzYzimMw)
  
  [![new Pegasus front end theme neo retro dark - it's a great game display for Android devices](https://img.youtube.com/vi/YbPcsC95Qc0/0.jpg)](http://www.youtube.com/watch?v=YbPcsC95Qc0)

  Custom Version of [RoeTaKa](https://www.youtube.com/channel/UCAbHcM41hzH9lku_3XqFYZg) with changed collection images
  
  [![AYN Odin Pro - Pegasus: Custom Shinretro](https://img.youtube.com/vi/sm5J7JoTYs8/0.jpg)](https://www.youtube.com/watch?v=sm5J7JoTYs8)
  
</details>
  
***

**Contributions are welcome**

You can code and found a bug in the theme you can fix or want to add a feature to the theme?
Or you can't code but want to add translations for your native language or you can provide some awsome artwork for the theme?

Simply have the courage and make a pull request :relaxed: 
You can find some guidances [here](HACKING.md).

## Features
- selectable color schemes
`dark` `light` `ozone dark`
- costumizable game view
- different onscreen control options
`Universal (Switch like)` `XBOX` `Playstation`
- different languages support
- toggleable video playback options

and more...
You can find explanations for the theme settings [here](SETTINGS.md).
  
## Metadata in use
- boxFront
- screenshot
- titlescreen (fallback for screenshot)
- wheel
- background
- video
- arcade port (custom metadata)

## Regarding videos on collection screen
> NOTE: Videos for the collection screen are not included in the theme. You can provide them by setting a default video for your collection in the Pegasus metadata of the collection. EXAMPLE:
> 
    collection: Sony Playstation 2
    shortname: ps2
    assets.video: media/videos/default.mp4

## Collection Categories
Group your collections into categories, for example by System, Series, Genre etc.
If you add a category field to your collection metadata files, the theme will allow you to switch between categories on the collection carousel screen by using the Filter button

To use this feature, add a new field 'x-collectiontype' to your collection metadata with the category you want to assign for that collection.

<img src="assets/screenshot/collectiontypes.png" title="collection types" />

## Arcade Port flag
If a game is tagged as an Arcade Port, the theme will add an Arcade Port tag to the details view, next to the Players and Genre tags.

To use this feature, add a new field 'x-arcadeport' to your game metadata with a value of 'True'.

<img src="assets/screenshot/arcade_port.png" title="arcade port flag" />

## Completed Ribbon
If you want to track which games you have finished, the theme can display a "Completed" ribbon on the grid view if a game has been marked as completed.

To use this feature, add a new field 'x-completed' to your game metadata with a value of 'True'.

<img src="assets/screenshot/completed.png" title="completed ribbon" />

## Work in progress
- [ ] clean the code...
- [ ] add more language options
- [ ] missing backgrounds/logos for collections and manufacturers 

## Considerations / ideas for the future
- [ ] provide some default collection videos
     - probalby need some original assets
- [ ] per collection fallback default background images
- [ ] filter by game genres
- [ ] add an attract mode

## Thanks to:
- [Valentin MEZIN](https://github.com/valsou) : Creator of the original neoretrō which this theme is based on
- [Luciano Oliveira](https://github.com/luciano-work) : Creator of the dark color scheme for neoretrō
- [HunkDeath](https://github.com/HunkDeath)  & [fansubmaniac](https://github.com/fansubmaniac) : french translations
- [RickEves](https://github.com/RickEves)  : portuguese translations
- [RoeTaKa](https://www.youtube.com/channel/UCAbHcM41hzH9lku_3XqFYZg)  : custom sfx & bgm music
