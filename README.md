# CitiesSearch

## Building And Running The Project (Requirements)
* Swift 5.0+
* Xcode 11.5+
* iOS 11.0+

# Getting Started
- If this is your first time encountering swift/ios development, please follow [the instructions](https://developer.apple.com/support/xcode/) to setup Xcode and Swift on your Mac.


## Setup Configs
- Checkout master branch to run latest version
- Open the project by double clicking the `CitiesSearch.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app
```
// App Settings
APP_NAME = CitiesSearch
PRODUCT_BUNDLE_IDENTIFIER = abozaid.CitiesSearch

#targets:
* CitiesSearch
* CitiesSearchTests

```

# Build and or run application by doing:
* Select the build scheme which can be found right after the stop button on the top left of the IDE
* [Command(cmd)] + B - Build app
* [Command(cmd)] + R - Run app

## Architecture
This application uses the Model-View-ViewModel (refered to as MVVM) UI architecture,


## Structure

### SupportingFiles
- Group app shared fils, like app delegate, assets, Info.plist, ...etc

### Modules
- Include seperate modules, components, extensions, ...etc.

### Scenes
- Group of app scenes.

### Points to improve:
- Improve code coverage
- Use swiftlint

#### screen shots:

![Search (dark) scene](https://github.com/abuzeid-ibrahim/CitiesSearch/blob/master/Screenshots/search_result_dark.png?raw=true)
![Results (dark) scene](https://github.com/abuzeid-ibrahim/CitiesSearch/blob/master/Screenshots/search_dark.png?raw=true)
![Map (dark) scene](https://github.com/abuzeid-ibrahim/CitiesSearch/blob/master/Screenshots/map_dark.png?raw=true)

![Search scene](https://github.com/abuzeid-ibrahim/CitiesSearch/blob/master/Screenshots/search.png?raw=true)
![Map scene](https://github.com/abuzeid-ibrahim/CitiesSearch/blob/master/Screenshots/map.png?raw=true)
![Results scene](https://github.com/abuzeid-ibrahim/CitiesSearch/blob/master/Screenshots/search_result.png?raw=true)
