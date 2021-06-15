# Landmark Remark - iOS

## Synopsis

The Landmark Remark app is a iOS app developed by Jackie Wang.

Features include:
- As a user, I can see my current location on a map by tapping bottom-right  `locate me button`.
- As a user, I can save a short note at my current location. The entry is tapping the button above the `locate me button`.
- As a user, I can see notes that me and other users saved for locations on the map.
- Locate current location
- Save current location with description
- See saved landmarks in the map, including mine and other users'

Known issues include:
- The description in annotation view can not be fully displayed if it is fairly long. The solution is to customize an annotation view.

Assumptions include:
- User does not need to log in/ register to use the app. When saving locations, users need to input their name for storage.
- Saved landmarks are displayed on the map as annotations.
- Information including username and description can be seen once users tap on the annotation.
- The project uses Realm local database rather than a backend solution like Firebase.

Features not include:
- As a user, I have the ability to search for a note based on contained text or username.
I implemented the project during the long weekend, one day for foundations and locating users, one day for save landmark UI layout and setting up local Realm database. Due to the time limitation, this user story is not included. The approach I would have taken is following:
1. Add a search bar in the mapView.
2. Transit to SearchController on tapping the search bar.
3. SearchController includes two elements, a search bar for inputting and a table view for showing the result.
4. While inputting, filter the landmarks stored and display the result in the table view.

## Getting Started

### Cloning the Repository

To clone the repo from Github:
``` 
https://github.com/jke661s/landmark.git
```
#### Installing Dependencies

I use [Swift Package Manager (SPM)](https://swift.org/package-manager/) for dependency management.

SPM is integrated into Xcode so all SPM dependencies are automatically installed for you when you first build the project.


## iOS App Architecture

The iOS app conforms to MVVM architecture and structures its source code.

### `View/ ViewController`

Contains UI and Presentation logic, organised according to the Model-View-View-Model (MVVM) architecture. Since  `UIKit` provides no simple way to perform data binding I have had to create a `Bindable` class to MVVM architecture.

### `ViewModel`

A `ViewModel` acts as a state machine for its corresponding `View/ ViewController` object and is responsible for providing presentation logic such as:

- information grouping
- data formatting
- UI assets based on the current view state

Moving presentation logic from the `ViewController` to the `ViewModel ` allows us to unit-test the presentation logic without triggering any side-effects from `UIKit`. This is because a `UIViewController`is tightly coupled with its `UIView`, which means we cannot unit test a `UIViewController` without instantiating its `UIView` and this causes all sorts of headaches when unit testing. `ViewModel` holds a weak `RoutingSource` for routing. `RoutingSource` is used to decouple the `ViewController`.

### `Model`

`Model`s are Swift structs which contains data the app needs. 

### `AppRouter`

An `AppRouter` is responsible for transitioning one screen to another. It registers `Navigator`s and exposes routing functions to the `ViewModel`. Upon being invoked by the `ViewModel`, from the url provided, it gets the proper `Navigator` and performs the view transition to the next screen.

### `LocationService`
`LocationService` is responsible for fetching users' current locations.

## Unit Tests

Due to the time limitation, I partially unit test the project, including `MainViewModel` and `LocationService`.
