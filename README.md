# BDS App

## Getting Started

Introduction about project

### Environment
Project run on Staging and Production environment
- Staging: branch dev
- Production: branch prod

### How to run project
- Step 1: Get packages, gen file
```sh
$ flutter packages pub run build_runner build --delete-conflicting-outputs
```
- Step 2: Build app icon
flutter pub run flutter_launcher_icons:main

### Requirements
Android:
- Please update the latest gradle version and gradle plugin. Current, project used gradle 7.4.1 and plugin 7.2.0

### Setup
- Fix bug notification fcm show white image on android:
https://github.com/flutter/flutter/issues/17941

## Features:

### Feature
* State management with Cubit and Bloc
* Authentication
* Notification with firebase messaging, firebase analytics
* Validation
* Mock Restful API with Dio
* Logging

### Current Screens
* SplashScreen
* Register
* Login
* Home

Some screenshots: 


### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter_bloc_boilerplate/
|- android
|- build
|- ios
|- lib
```

Here is the folder structure we have been using in this project

```
lib/
|- bloc_global/
|- configs/
|- data/
|------- api_service/
|------- enums/
|------- models/
|------- repository/
|- presentation/
|------- screens/
|------- shared_widgets/
|- utils/
|- app_container.dart
|- app.dart
|- main.dart
```

## Conclusion

