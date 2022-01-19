import 'dart:ui';

import 'package:flutter/material.dart';

import 'appTheme.dart';

class ColorHelper {
  static Color get facebookColor => Color(0xFF3C5799);

  static Color get twitterColor => Color(0xFF05A9F0);

  static Color get primaryColor => AppTheme.getTheme().primaryColor;

  static Color get lightColor => Colors.white;

  static Color get darkColor => Colors.black;

  static Color get disabledColor => AppTheme.getTheme().disabledColor;

  static Color get transparentColor => Colors.transparent;

  static Color get dividerColor => AppTheme.getTheme().dividerColor;

  static Color get bgColor => AppTheme.getTheme().backgroundColor;

  static Color get errorColor => AppTheme.getTheme().errorColor;
}
