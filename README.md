## Table of Contents
1. [General Info](#general-info)
2. [Screenshots](#screenshots)
3. [Showcase](#showcase)
4. [Technologies](#technologies)
5. [GIFs](#gifs)

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
    │       ├── rating_bar_widget.dart
    │       ├── round_corner_text_input_widget.dart
    │       ├── round_corners_button_widget.dart
    │       └── selectable_title_widget.dart
    ├── authentication
    │   ├── domain
    │   │   └── entities
    │   │       ├── login_entity.dart
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
    │           ├── explore_item_header_widget.dart
    │           ├── explore_slider_widget.dart
    │           ├── popular_destination_list_widget.dart
    │           └── popular_destination_row_widget.dart
    ├── hotel
    │   ├── domain
    │   │   └── entities
    │   │       └── hotel_entity.dart
    │   └── presentation
    │       ├── pages
    │       │   ├── hotel_details_page.dart
    │       │   ├── hotel_list_landing_page.dart
    │       │   ├── review_list_page.dart
    │       │   └── room_list_page.dart
    │       └── widget
    │           ├── calendar_popup_widget.dart
    │           ├── custom_calendar_widget.dart
    │           ├── hotel_map_view_row_widget.dart
    │           ├── hotel_rating_widget.dart
    │           ├── hotel_row_one_widget.dart
    │           ├── hotel_row_three_widget.dart
    │           ├── hotel_row_two_widget.dart
    │           ├── review_list_row_widget.dart
    │           ├── room_images_widget.dart
    │           ├── room_list_row_widget.dart
    │           └── room_range_selection_widget.dart
    ├── myTrips
    │   └── presentation
    │       ├── pages
    │       │   ├── favorite_trips_page.dart
    │       │   ├── finished_trips_page.dart
    │       │   ├── my_trips_page.dart
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
    │       │   ├── feedback_page.dart
    │       │   ├── help_center_page.dart
    │       │   ├── invite_page.dart
    │       │   └── profile_page.dart
    │       └── widgets
    ├── search
    │   ├── domain
    │   │   └── entities
    │   │       └── filter_entity.dart
    │   └── presentation
    │       ├── pages
    │       │   ├── filters_page.dart
    │       │   └── search_page.dart
    │       └── widgets
    │           ├── range_slider_widget.dart
    │           ├── search_types_widget.dart
    │           └── slider_widget.dart
    └── settings
        ├── domain
        │   └── entities
        │       └── setting_entity.dart
        └── presentation
            └── pages
                ├── country_list_page.dart
                ├── currency_list_page.dart
                └── settings_page.dart
```


### Technologies
***

   Following technologies are used in this project.

   1. [intl] (https://pub.dev/packages/intl) : version ^0.17.0
   2. [intl_utils] (https://pub.dev/packages/intl_utils) : version ^2.6.0
   3. [integration_test] (flutter sdk)
   4. [flutter_test] (flutter sdk)
   5. [flutter_localizations] (flutter sdk)
   6. [cupertino_icons] (https://pub.dev/packages/cupertino_icons) : version ^1.0.4
   7. [font_awesome_flutter] (https://pub.dev/packages/font_awesome_flutter) : version ^9.2.0
   8. [flutter_rating_bar] (https://pub.dev/packages/flutter_rating_bar) : version ^4.0.0
   9. [smooth_page_indicator] (https://pub.dev/packages/smooth_page_indicator) : version ^1.0.0+2


### GIFs
***

   #### Sample for Integration testing of signup module.

   ![Integration Testing](/screenshots/integration_test.gif)

   #### Sample for app transition animations.

   ![Transition Animations](/screenshots/transitions.gif)


