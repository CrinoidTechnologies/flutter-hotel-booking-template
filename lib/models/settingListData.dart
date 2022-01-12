import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsListData {
  String titleTxt;
  String subTxt;
  IconData iconData;
  bool isSelected;

  SettingsListData({
    this.titleTxt = '',
    this.isSelected = false,
    this.subTxt = '',
    this.iconData = Icons.supervised_user_circle,
  });

  List<SettingsListData> getCountryListFromJson(Map<String, dynamic> json) {
    List<SettingsListData> countryList = [];
    if (json['countryList'] != null) {
      json['countryList'].forEach((v) {
        SettingsListData data = SettingsListData();
        data.titleTxt = v["name"];
        data.subTxt = v["code"];
        countryList.add(data);
      });
    }
    return countryList;
  }

  static List<SettingsListData> userSettingsList = [
    SettingsListData(
      titleTxt: 'Change password',
      isSelected: false,
      iconData: FontAwesomeIcons.lock,
    ),
    SettingsListData(
      titleTxt: 'Invite Friends',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingsListData(
      titleTxt: 'Credits & Coupons',
      isSelected: false,
      iconData: FontAwesomeIcons.gift,
    ),
    SettingsListData(
      titleTxt: 'Help Center',
      isSelected: false,
      iconData: FontAwesomeIcons.infoCircle,
    ),
    SettingsListData(
      titleTxt: 'Payments',
      isSelected: false,
      iconData: FontAwesomeIcons.wallet,
    ),
    SettingsListData(
      titleTxt: 'Settings',
      isSelected: false,
      iconData: FontAwesomeIcons.cog,
    )
  ];
  static List<SettingsListData> settingsList = [
    SettingsListData(
      titleTxt: 'Notifications',
      isSelected: false,
      iconData: FontAwesomeIcons.solidBell,
    ),
    SettingsListData(
      titleTxt: 'Country',
      isSelected: false,
      iconData: FontAwesomeIcons.userFriends,
    ),
    SettingsListData(
      titleTxt: 'Currency',
      isSelected: false,
      iconData: FontAwesomeIcons.gift,
    ),
    SettingsListData(
      titleTxt: 'Terms of Services',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingsListData(
      titleTxt: 'Privacy Policy',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingsListData(
      titleTxt: 'Give Us Feedbacks',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    ),
    SettingsListData(
      titleTxt: 'Log out',
      isSelected: false,
      iconData: Icons.keyboard_arrow_right,
    )
  ];

  static List<SettingsListData> currencyList = [
    SettingsListData(
      titleTxt: 'Australia Dollar',
      subTxt: "\$ AUD",
    ),
    SettingsListData(
      titleTxt: 'Argentina Peso',
      subTxt: "\$ ARS",
    ),
    SettingsListData(
      titleTxt: 'Indian rupee',
      subTxt: "₹ Rupee",
    ),
    SettingsListData(
      titleTxt: 'United States Dollar',
      subTxt: "\$ USD",
    ),
    SettingsListData(
      titleTxt: 'Chinese Yuan',
      subTxt: "¥ Yuan",
    ),
    SettingsListData(
      titleTxt: 'Belgian Euro',
      subTxt: "€ Euro",
    ),
    SettingsListData(
      titleTxt: 'Brazilian Real',
      subTxt: "R\$ Real",
    ),
    SettingsListData(
      titleTxt: 'Canadian Dollar',
      subTxt: "\$ CAD",
    ),
    SettingsListData(
      titleTxt: 'Cuban Peso',
      subTxt: "₱ PESO",
    ),
    SettingsListData(
      titleTxt: 'French Euro',
      subTxt: "€ Euro",
    ),
    SettingsListData(
      titleTxt: 'Hong Kong Dollar',
      subTxt: "\$ HKD",
    ),
    SettingsListData(
      titleTxt: 'Italian Lira',
      subTxt: "€ Euro",
    ),
    SettingsListData(
      titleTxt: 'New Zealand Dollar',
      subTxt: "\$ NZ",
    ),
  ];

  static List<SettingsListData> helpSearchList = [
    SettingsListData(
      titleTxt: 'Paying for a reservation',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I cancel my rooms reservation?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "What methods pf payment does Roome accept?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingsListData(
      titleTxt: 'Trust and safety',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "I'm a guest. What are some safety tips I can follow?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingsListData(
      titleTxt: 'Paying for a reservation',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I cancel my rooms reservation?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "What methods pf payment does Roome accept?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
    SettingsListData(
      titleTxt: 'Trust and safety',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "I'm a guest. What are some safety tips I can follow?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "When am I charged for a reservation?",
    ),
    SettingsListData(
      titleTxt: '',
      subTxt: "How do I edit or remove a payment method?",
    ),
  ];

  static List<SettingsListData> subHelpList = [
    SettingsListData(
      titleTxt: "",
      subTxt: "You can cancel a reservation any time before Or during your trip. To cancel a reservation:",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "GO to Trips and choose yotr trip\nClick Your home reservation\nClick Modify reservation",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt:
          "You'll be taken to a new page where you either change or cancel your reservation. Click the Next button under Cancel reservation to Start the cancellation process.",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt:
          "If you cancel, your refund Will be determined by your host'r cancellation policy. We'll show your refund breakdown before you finalize the cancellation.",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "Give feedback",
      isSelected: true,
    ),
    SettingsListData(
      titleTxt: "Related articles",
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "Can I change a reservation as a guest?",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "HOW do I cancel a reservation request?",
    ),
    SettingsListData(
      titleTxt: "",
      subTxt: "What is the Resolution Center?",
    ),
  ];

  static List<SettingsListData> userInfoList = [
    SettingsListData(
      titleTxt: '',
      subTxt: "",
    ),
    SettingsListData(
      titleTxt: 'UserName',
      subTxt: "Amanda Jane",
    ),
    SettingsListData(
      titleTxt: 'Email',
      subTxt: "amanda@gmail.com",
    ),
    SettingsListData(
      titleTxt: 'Phone',
      subTxt: "+65 1122334455",
    ),
    SettingsListData(
      titleTxt: 'Date of birth',
      subTxt: "20, Aug, 1990",
    ),
    SettingsListData(
      titleTxt: 'Address',
      subTxt: "123 Royal Street, New York",
    ),
  ];
}
