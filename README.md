## Table of Contents
1. [General Info](#general-info)
2. [Screenshots](#screenshots)
3. [Features](#features)
4. [Architecture Layers](#architecture-layers)
5. [Design Resources](#design-resources)
6. [Folder Structure](#folder-structure)
7. [Test Cases](#test-cases)
8. [Installation Instructions](#installation-instructions)
9. [Security](#security)
10. [Performance](#performance)
11. [Technologies](#technologies)
12. [GIFs](#gifs)

### General Info
***
# Hotel Template
  This is a template project which basically explores list of hotels, rooms, popular destinations and trips. A basic search and room selection interface is also
  implemented in this. A UI interface to view/edit user profile is also implemented. There is a setting page with basic setting options including an
  option to change app theme(Light/Dark) as per your requirement. A basic validations for Signup & Login is also implemented in this.
  Following is the list of some modules included in this project.

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



### Features
***

  This project is build to Showcase following things implemented in this project.

  1. Transition animations.
  2. Unit test cases/Integration test cases.
  3. Basic code structure.
  4. Localisation.
  5. App Theme management.(Light/Dark Mode).



### Architecture Layers
***
## 1. Clean Architecture
   Clean architecture promotes separation of concerns, making the code loosely coupled. This results in a more testable and flexible code.

   ![](/screenshots/onboarding.png)

   The core principles of the clean approach can be summarized as follows:

    1. The application code is separated into layers inside the code base.
    2. The layers follow a strict dependency rule, they can only interact 
    with the layers below it.
    3. As we move toward the bottom layer — the code becomes generic -
    The bottom layers dictate policies and rules, and the upper layers dictate implementation
    details such as the database, networking manager, and UI.

   The 3 modules of architecture are:

    * Presentation: Layer with the Android Framework, the MVVM pattern and the DI module. 
    Depends on the domain to access the use cases and on di, to inject dependencies.
    * Domain: Layer with the business logic. Contains the use cases, in charge of calling 
    the correct repository or data member.
    * Data: Layer with the responsibility of selecting the proper data source for the domain layer.
    It contains the implementations of the repositories declared in the domain layer.
    It may, for example, check if the data in a database is up to date, and retrieve it 
    from the service if it’s not.


### Design Resources
***

  Here are some design resources used for creating the designs for this template.
  
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
    │       │   └── signup_page.dart
    │       └── widget
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
    │       │   └── room_list_page.dart
    │       └── widget
    │           ├── calendar_popup_widget.dart
    │           └── custom_calendar_widget.dart
    ├── myTrips
    │   └── presentation
    │       ├── pages
    │       │   ├── favorite_trips_page.dart
    │       │   └── upcoming_trips_page.dart
    │       └── widget
    ├── onBoadring
    │   └── presentation
    │       └── pages
    │           ├── introduction_screen.dart
    │           └── splash_screen.dart
    ├── password_recovery
    │   └── presentation
    │       └── pages
    │           ├── change_password_page.dart
    │           └── forgot_password_page.dart
    ├── profile
    │   └── presentation
    │       ├── pages
    │       │   ├── edit_profile_page.dart
    │       │   └── profile_page.dart
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

````

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


### Security
***

  * Use HTTPS for all network communication to encrypt data in transit.
  * Use secure storage, such as the flutter_secure_storage package, to store sensitive information on the device.
  * Implement authentication and authorization mechanisms to control access to sensitive data and functions.
  * Regularly update dependencies and use a dependency management tool, such as pub, to keep track of known vulnerabilities.
  * Use a code obfuscation tool to make it harder for attackers to reverse-engineer the app and understand its inner workings.
  * Implement an encryption library and use it to encrypt sensitive data at rest.
  * Use input validation and sanitization to protect against injection attacks.
  * Use Firebase Authentication for user authentication.
  * Use Firebase Security Rules for database security.
  * Use Firebase Cloud Messaging for secure messaging.

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


### GIFs
***

   #### Sample for Integration testing of signup module.

   ![Integration Testing](/screenshots/integration_test.gif)

   #### Sample for app transition animations.

   ![Transition Animations](/screenshots/transitions.gif)


