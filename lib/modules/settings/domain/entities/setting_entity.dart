import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingEntity {
  String? titleTxt;
  String? subTxt;
  IconData iconData;
  bool isSelected;

  SettingEntity({
    this.titleTxt = '',
    this.isSelected = false,
    this.subTxt = '',
    this.iconData = Icons.supervised_user_circle,
  });

  List<SettingEntity> getCountryListFromJson(Map<String, dynamic> json) {
    List<SettingEntity> countryList = [];
    if (json['countryList'] != null) {
      json['countryList'].forEach((v) {
        SettingEntity data = SettingEntity();
        data.titleTxt = v["name"];
        data.subTxt = v["code"];
        countryList.add(data);
      });
    }
    return countryList;
  }

  static List<SettingEntity> userSettingsList = [
    SettingEntity(
      titleTxt: 'Change password',
      isSelected: false,
      iconData: FontAwesomeIcons.lock,
    ),
    SettingEntity(
      titleTxt: 'Invite Friends',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingEntity(
      titleTxt: 'Credits & Coupons',
      isSelected: false,
      iconData: FontAwesomeIcons.gift,
    ),
    SettingEntity(
      titleTxt: 'Help Center',
      isSelected: false,
      iconData: FontAwesomeIcons.infoCircle,
    ),
    SettingEntity(
      titleTxt: 'Payments',
      isSelected: false,
      iconData: FontAwesomeIcons.wallet,
    ),
    SettingEntity(
      titleTxt: 'Settings',
      isSelected: false,
      iconData: FontAwesomeIcons.cog,
    )
  ];
  static List<SettingEntity> settingsList = [
    SettingEntity(
      titleTxt: 'Notifications',
      isSelected: false,
      iconData: FontAwesomeIcons.solidBell,
    ),
    SettingEntity(
      titleTxt: 'Country',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingEntity(
      titleTxt: 'Currency',
      isSelected: false,
      iconData: FontAwesomeIcons.gift,
    ),
    SettingEntity(
      titleTxt: 'Terms of Services',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingEntity(
      titleTxt: 'Privacy Policy',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingEntity(
      titleTxt: 'Give Us Feedbacks',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingEntity(
      titleTxt: 'Log out',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    )
  ];

  static List<SettingEntity> currencyList = [
    SettingEntity(
      titleTxt: 'Australia Dollar',
      subTxt: "\$ AUD",
    ),
    SettingEntity(
      titleTxt: 'Argentina Peso',
      subTxt: "\$ ARS",
    ),
    SettingEntity(
      titleTxt: 'Indian rupee',
      subTxt: "₹ Rupee",
    ),
    SettingEntity(
      titleTxt: 'United States Dollar',
      subTxt: "\$ USD",
    ),
    SettingEntity(
      titleTxt: 'Chinese Yuan',
      subTxt: "¥ Yuan",
    ),
    SettingEntity(
      titleTxt: 'Belgian Euro',
      subTxt: "€ Euro",
    ),
    SettingEntity(
      titleTxt: 'Brazilian Real',
      subTxt: "R\$ Real",
    ),
    SettingEntity(
      titleTxt: 'Canadian Dollar',
      subTxt: "\$ CAD",
    ),
    SettingEntity(
      titleTxt: 'Cuban Peso',
      subTxt: "₱ PESO",
    ),
    SettingEntity(
      titleTxt: 'French Euro',
      subTxt: "€ Euro",
    ),
    SettingEntity(
      titleTxt: 'Hong Kong Dollar',
      subTxt: "\$ HKD",
    ),
    SettingEntity(
      titleTxt: 'Italian Lira',
      subTxt: "€ Euro",
    ),
    SettingEntity(
      titleTxt: 'New Zealand Dollar',
      subTxt: "\$ NZ",
    ),
  ];

  static List<SettingEntity> helpSearchList = [
    SettingEntity(
      titleTxt: 'Paying for a reservation',
      subTxt: "",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "How do I cancel my rooms reservation?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "What methods pf payment does Roome accept?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingEntity(
      titleTxt: 'Trust and safety',
      subTxt: "",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "I'm a guest. What are some safety tips I can follow?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingEntity(
      titleTxt: 'Paying for a reservation',
      subTxt: "",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "How do I cancel my rooms reservation?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "What methods pf payment does Roome accept?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingEntity(
      titleTxt: 'Trust and safety',
      subTxt: "",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "I'm a guest. What are some safety tips I can follow?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingEntity(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
  ];

  static List<SettingEntity> subHelpList = [
    SettingEntity(
      titleTxt: "",
      subTxt:
          "You can cancel a reservation any time before Or during your trip. To cancel a reservation:",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt:
          "GO to Trips and choose yotr trip\nClick Your home reservation\nClick Modify reservation",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt:
          "You'll be taken to a new page where you either change or cancel your reservation. Click the Next button under Cancel reservation to Start the cancellation process.",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt:
          "If you cancel, your refund Will be determined by your host'r cancellation policy. We'll show your refund breakdown before you finalize the cancellation.",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt: "Give feedback",
      isSelected: true,
    ),
    SettingEntity(
      titleTxt: "Related articles",
      subTxt: "",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt: "Can I change a reservation as a guest?",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt: "HOW do I cancel a reservation request?",
    ),
    SettingEntity(
      titleTxt: "",
      subTxt: "What is the Resolution Center?",
    ),
  ];

  static List<SettingEntity> userInfoList = [
    SettingEntity(
      titleTxt: '',
      subTxt: "",
    ),
    SettingEntity(
      titleTxt: 'UserName',
      subTxt: "Amanda Jane",
    ),
    SettingEntity(
      titleTxt: 'Email',
      subTxt: "amanda@gmail.com",
    ),
    SettingEntity(
      titleTxt: 'Phone',
      subTxt: "+65 1122334455",
    ),
    SettingEntity(
      titleTxt: 'Date of birth',
      subTxt: "20, Aug, 1990",
    ),
    SettingEntity(
      titleTxt: 'Address',
      subTxt: "123 Royal Street, New York",
    ),
  ];
}
