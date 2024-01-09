## Table of Contents
1. [General Info](#general-info)
2. [Screenshots](#screenshots)
3. [Features](#features)
4. [Clean_Architecture](#clean-architecture)
5. [Design Resources](#design-resources)
6. [Folder Structure](#folder-structure)
7. [Test Cases](#test-cases)
8. [Installation Instructions](#installation-instructions)
9. [TODO](#todo)
10. [Technologies](#technologies)
11. [Security](#security)
12. [Performance](#performance)
13. [GIFs](#gifs)

### General Info
***
# Hotel Template
This template project is designed to delve into a comprehensive array of features, encompassing hotel listings, room details, popular destinations, and trip options. 
It features an intuitive search functionality and a user-friendly room selection interface. Additionally, a sleek UI is incorporated to facilitate the viewing and editing 
of user profiles. The project also boasts a settings page with essential options, including the ability to customize the app theme (Light/Dark) based on individual preferences.
Furthermore, fundamental validation processes have been implemented for both signup and login functionalities to enhance security. The project includes various modules to cater 
to diverse functionalities, contributing to a seamless user experience.

  1. Login
  2. Signup
  3. Dashboard
  4. Explore
  5. Trips
  6. Hotels
  7. User Profile
  8. Search
  9. Settings

### Screenshots
***

 | `Light Mode`                      |
 | OnBoarding Page                   | Intro Page                     | Login Page                       | Signup Page                       |
 | -----------                       | -----------------              | -------------                    | -------------                     |
 | ![](/screenshots/onboarding.png)  | ![](/screenshots/intro.png)    | ![](/screenshots/login.png)      | ![](/screenshots/signup.png)      |
 | Explore Page                      | Trips Page                     | Profile Page                     | Settings Page                     |
 | -----------                       | -----------------              | -------------                    | -------------                     |
 | ![](/screenshots/explore.png)     | ![](/screenshots/trips.png)    | ![](/screenshots/profile.png)    | ![](/screenshots/settings.png)    | 
 
 | `Dark Mode`                       |
 | OnBoarding Page                   | Intro Page                     | Login Page                       | Signup Page                       |
 | -----------                       | -----------------              | -------------                    | -------------                     |
 | ![](/screenshots/onboarding.png)  | ![](/screenshots/into_drk.png) | ![](/screenshots/login_drk.png)  | ![](/screenshots/signup_drk.png)  |
 | Explore Page                      | Trips Page                     | Profile Page                     | Settings Page                     |
 | -----------                       | -----------------              | -------------                    | -------------                     |
 | ![](/screenshots/explore_drk.png) | ![](/screenshots/trips_drk.png)| ![](/screenshots/profile_drk.png)| ![](/screenshots/settings_drk.png)|



### Project Features
***

  This project is build to Showcase following things implemented in this project.

  1. Transition animations.
  2. Unit test cases/Integration test cases.
  3. Feature first folder structure.
  4. Localisation friendly.
  5. Multiple Themes.(Light/Dark Mode).



### Clean Architecture
***

   ![](/screenshots/clean_arch.jpg)

  There are two main points to understand about the architecture: it splits the project into different layers and conforms to the Dependency rule.

  The number of layers used can vary slightly from one project to another, but by utilizing them, we promote the principle of 'separation of concerns.' If you're a new developer and have never heard of it before, it's simply a fancy way of saying, 'Hey! I'm a layer, and I'm concerned about a single aspect of the system only'. If a layer is responsible for displaying the UI, it won't handle database operations. Conversely, if a layer is responsible for data persistence, it won't have any knowledge of UI components

  And what about the Dependency rule? Let's put it in simple terms. First, you need to understand that the layers discussed above are not stacked on top of each other; instead, they resemble the layers of an 'onion.' There is a central layer surrounded by outer layers. The Dependency rule states that classes within a layer can only access classes from their own layer or the outer layers, but never from the inner layers

  Usually, when working with this architecture, you'll come across some additional terminology such as Entities, Interface Adapters, Use Cases, DTOs, and other terms. These terms are simply names given to components that also fulfill 'single responsibilities' within the project

### Clean Architecture and how it's applied in this project

  The figure bellow represents the variation applied in this project:

   ![](/screenshots/clean_arch_2.png)

  In this case, we're only using three layers: Presentation, Domain and Data.

#### The presentation layer (UI)
  This is the layer where the Flutter framework resides. Here, you'll find classes that are part of the framework, such as Widgets, BuildContexts, and libraries that consume the framework, including state management libraries.

  Typically, the classes in this layer are responsible for:

  Managing the application's state.
  Handling UI aspects of an app, such as managing page navigation, displaying data, implementing internationalization, and ensuring proper UI updates.

#### The domain layer
  This layer represents the core domain of the problem we are addressing, encompassing the business rules. Hence, it should be an independent Dart module without dependencies on external layers. It includes:

  Plain entity classes (like Character entity)
  Use-case classes that encapsulate the specific business logic for a given use case (like GetAllCharacters, SignInUser, and others...)
  Abstractions for data access, normally repository or services interfaces
  A use-case has no knowledge of the data source, whether it comes from a memory cache, local storage, or the internet. All these implementation details have been abstracted out through the use of Repository Interfaces. From the use-case's perspective, all that matters is that it receives the required data.

#### The data layer
  This layer serves as a boundary between our application and the external world. Its primary responsibility is to load data from external sources, such as the internet or databases, and convert it to a format that aligns with our Domain expectations. It plays a vital role in supplying data to the use cases and performs the following tasks:

  Data retrieval: It makes network and/or database calls, retrieving data from the appropriate data sources.
  Repository implementations: It includes the implementations of the repositories defined in the domain layer, providing concrete functionality for accessing and manipulating data.
  Data coordination: It coordinates the flow of data between multiple sources. For example, it can fetch data from the network, store it locally, and then return it to the use case.
  Data (de)serialization: It handles the conversion of data to and from JSON format, transforming it into Data Transfer Objects (DTOs) for standardized representation.
  Caching management: It can incorporate caching mechanisms, optimizing performance by storing frequently accessed data for quicker retrieval.


### Design Resources
***

  The UI designs of this template is inspired from following design resources.
  
  1. (https://uizard.io/templates/mobile-app-templates/flight-ticket-mobile-app/)
  2. (https://uizard.io/templates/mobile-app-templates/event-booking-mobile-app/)

### Folder Structure
***

```
├── app
│   ├── ui
│   │   ├── appTheme.dart
│   │   └── color_helper.dart
│   └── validators
│       ├── login_validator.dart
│       └── signup_validator.dart
├── generated
│   ├── intl
│   │   ├── messages_all.dart
│   │   └── messages_en_US.dart
│   └── l10n.dart
├── l10n
│   └── intl_en_US.arb
├── main.dart
└── modules
    ├── _common
    │   ├── entity
    │   │   └── slider_entity.dart
    │   └── widget
    │       └── rating_bar_widget.dart
    │       
    ├── authentication
    │   ├── domain
    │   │   └── entities
    │   │       └── signup_entity.dart
    │   └── preseentation
    │       ├── pages
    │       │   ├── login_page.dart
    ├── dashboard
    │   └── presentation
    │       └── pages
    │           └── dashboard_page.dart
    ├── explore
    │   └── presentation
    │       ├── pages
    │       │   └── explore_page.dart
    │       └── widget
    │           └── popular_destination_row_widget.dart
    ├── hotel
    │   ├── domain
    │   │   └── entities
    │   │       └── hotel_entity.dart
    │   └── presentation
    │       ├── pages
    │       │   ├── hotel_details_page.dart
    │       └── widget
    │           ├── calendar_popup_widget.dart
    ├── myTrips
    │   └── presentation
    │       ├── pages
    │       │   ├── favorite_trips_page.dart
    ├── onBoadring
    │   └── presentation
    │       └── pages
    │           ├── introduction_screen.dart
    ├── password_recovery
    │   └── presentation
    │       └── pages
    │           ├── change_password_page.dart
    ├── profile
    │   └── presentation
    │       ├── pages
    │       │   ├── edit_profile_page.dart
    │       └── widgets
    ├── search
    │   ├── domain
    │   │   └── entities
    │   │       └── filter_entity.dart
    │   └── presentation
    │       ├── pages
    │       │   └── search_page.dart
    │       └── widgets
    │           └── slider_widget.dart
    └── settings
        ├── domain
        │   └── entities
        │       └── setting_entity.dart
        └── presentation
            └── pages
                └── settings_page.dart
```

### Test Cases
***

  Basic Unit/Integration Test cases are implemented in this app to showcase how testcases helps to improve the quality & speed of the development.
  
  #### Steps to run the testcases

  1. Connect simulator or connect real device.
  2. Select the desired test case from the dropdown shown in reference below.
     ![](/screenshots/select_testcase.png)
  3. Click on the "Run" button.
  4. After completing the test successfully you will see the output like shown in reference below.
     ![](/screenshots/test_result.png)

  #### Note: You can find the test cases files by following the below mentioned folder structure.
````
├── test
│   ├── login_test.dart
│   ├── signup_test.dart
│   └── widget_test.dart
└── test_driver
    └── integration_driver.dart
    
├── integration_test
│   ├── integ_login_test.dart
│   └── integ_signup_test.dart
````
#### Sample for Integration testing of signup module.

![Integration Testing](/screenshots/integration_test.gif)

### Installation Instructions
***

For development, the latest version of Android Studio is required. The latest version can be downloaded from [here](https://developer.android.com/studio?gclid=CjwKCAiAjfyqBhAsEiwA-UdzJL6PSj-kSHbT1kVELCLlfYCfj0AI1xeaxlntfr_A5OflgFY_ZAEaJxoCSU0QAvD_BwE&gclsrc=aw.ds).
App uses latest version of flutter & dart SDK.   
  * Open Android studio
  * Install the required plugins as mentioned below if not installed.
    1. Dart
    2. Flutter 
    3. Flutter Intl
  * Restart the android studio.

### TODO

***

- [x] UI implementation with data & validations
   - [x] Login screen
   - [x] Signup screen
   - [x] Dashboard screen
   - [x] Explore screen
   - [x] Trips screen
   - [x] Hotels screen
   - [x] User Profile screen
   - [x] Search screen
   - [x] Settings screen
- [x] Implementation of light/dark theme
- [x] Implementation of unit test cases
- [x] Implementation of integration test cases
- [x] Localisation
- [x] State/Route management using GetX

### Technologies
***

Following technologies are used in this project.

1. [intl](https://pub.dev/packages/intl) : version ^0.18.1
2. [intl_utils](https://pub.dev/packages/intl_utils) : version ^2.8.5
3. [integration_test] (flutter sdk)
4. [flutter_test] (flutter sdk)
5. [flutter_localizations] (flutter sdk)
6. [cupertino_icons](https://pub.dev/packages/cupertino_icons) : version ^1.0.4
7. [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter) : version ^9.2.0
8. [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) : version ^4.0.1
9. [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator) : version ^1.0.0+2

### Security
***

  * Use HTTPS for all network communication to encrypt data in transit.
  * Use secure storage, such as the flutter_secure_storage package, to store sensitive information on the device.
  * Implement authentication and authorization mechanisms to control access to sensitive data and functions.
  * Regularly update dependencies and use a dependency management tool, such as pub, to keep track of known vulnerabilities.
  * Use a code obfuscation tool to make it harder for attackers to reverse-engineer the app and understand its inner workings.
  * Implement an encryption library and use it to encrypt sensitive data at rest.
  * Use input validation and sanitization to protect against injection attacks.

### Performance 
***

  #### Do Not Rebuild Widgets
  Too often, we see widget rebuild as a typical performance anti-pattern. Every user interaction with the widget will refresh the whole view. That, in turn, will impact the scaffold and the background widget, which only delays the app's ability to load fully. It is better to limit the rebuild process to the things you need to update. You can use the Bloc pattern to rebuild the necessary parts.

  #### Async/Await
  When developing an app, it is essential to verify if the code is synchronous or asynchronous. You can start writing codes asynchronously using the Async/Await app. By inserting "await" after an async function, the following lines wait for the Future's results, so the operation appears synchronous. Of course, it is not easy to update or debug the Async code.

  #### Only Render Visible Widgets
  When there's a long horizontal or vertical list of widgets, you want to control how many widgets appear on the screen simultaneously. You can do that using the ListView.builder, one of Flutter's best practices.

  For instance, you can use ListView.builder when planning to develop a timeline of 50 posts. Instead, if you use a column or ListView constructor, there's a good chance that all posts will be created simultaneously once the app starts.
  
  #### Avoid Using Columns For Longer Lists
  Again, ListView.builder can help. If you can't see the entire list on a single screen page, it's better to use the ListView.builder than a column.

  Why? Because only elements visible on the screen occupy memory space, and if they are not on the screen, the memory space will remain free. That's highly effective in optimizing memory and boosting performance.

  #### Use Stateless Widgets to Avoid Splits
  If the building method has different nesting levels, you can consider splitting the widget into multiple methods. This can dramatically affect the CPU's performance because Flutter has to rebuild all the small widgets, including the static ones, every time the main widget is rebuilt. To maintain the CPU's efficiency, you should use stateless widgets.

  #### Use Flutter's Latest Version
  The latest version is always improved and packed with new and enticing features. Flutter is a framework that is active and updated on a regular basis. Staying in tune with the recent version and implementing it into your development ensures the performance optimization of your project.

  #### Utilize a State Management Library
  State management is a non-negotiable factor for developing highly-performing flutter apps. Centralize your app's state and witness a fall in the rebuilds needed for UI updates. Multiple libraries are available, like Bloc, Redux, and Provider, with their own set of pros and cons. So, pick one that works well for your project. 



### GIFs
***

   #### Sample for app transition animations.

   ![Transition Animations](/screenshots/transitions.gif)


