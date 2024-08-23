# metin

A social media app that will scale to the MOON!


# Project Architecture : TDD 
    ├─ core/                       
    │  ├─ api/                     defintion of API elements
    │  ├─ errors/                  definition of Errors and exceptions
    │  ├─ network/                 utils that goes with Network 
    │  ├─ usecases/                definition of useCases
    │  └─ common/                  definition of common Widgets , Algorithms ......
    │  └─ routes.dart              definition of route system and all application routes 
    │  
    ├─ Features                    the project is divided in a bunch of features 
    │  └─Auth_feature
    ├─   └─data/                       
    │       ├─ datasources/             origin of the data requested by the repository
    │       ├─ models/                  contain fromJson & toJson functions and inherit from an entity
    │       └─ repositories/             implementation of the repositories of DOMAIN FOLDER
    ├─  └─domain/                     
    │       ├─ entities/                all entities 
    │       ├─ repositories/            definition of repositories
    │       └─ usecases/                useCases implementation
    ├─  └─presentation/              All the UI staff goes here inside this folder 
    │       ├─ business_logic/          State Management Tool
    │       ├─ screens/                 Screens
    │       └─ widgets/                 custom widgets used in screens
    │
    ├─ injection_container.dart    dependency injection
    └─ main.dart

## REQUIREMENT :

Android Studio installed in your computer.

Flutter version : 2.10.3

# dependencies : 

 ## everything that goes with UI :
  font_awesome_flutter: ^10.1.0
  google_fonts: ^2.3.1
  flutter_svg: ^1.0.3
  country_code_picker: ^2.0.2
## Internationalization
  intl: ^0.17.0
  flutter_localizations:
    sdk: flutter
 ## State management Tool
  flutter_bloc: ^8.0.1

# How to Install 
after having  flutter installed in your computer run the following commands inside the project folder :

// to install project dependencies run : 
flutter pub get 

After choosing what type of device you will work with ( Virtual or physical device or Web) run : 
flutter run 

Et Voila 