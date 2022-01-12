import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class AppTheme {
  static bool isDark = false;
  static Color primaryColors = HexColor("#4FBE9F");


  static TextTheme _buildTextTheme(TextTheme base) {
    var fontName = "WorkSans";
    return base.copyWith(
      headline6: base.headline6?.copyWith(fontFamily: fontName),
      bodyText1: base.headline6?.copyWith(fontFamily: fontName),
      bodyText2: base.headline6?.copyWith(fontFamily: fontName),
      button: base.headline6?.copyWith(fontFamily: fontName),
      caption: base.headline6?.copyWith(fontFamily: fontName),
      headline1: base.headline6?.copyWith(fontFamily: fontName),
      headline2: base.headline6?.copyWith(fontFamily: fontName),
      headline3: base.headline6?.copyWith(fontFamily: fontName),
      headline4: base.headline6?.copyWith(fontFamily: fontName),
      headline5: base.headline6?.copyWith(fontFamily: fontName),
      overline: base.headline6?.copyWith(fontFamily: fontName),
      subtitle1: base.headline6?.copyWith(fontFamily: fontName),
      subtitle2: base.headline6?.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData getTheme() {
    if (isDark) {
      return newDarkTheme();
    } else {
      return newLightTheme();
    }
  }

  static ThemeData newLightTheme() {
    Color primaryColor = primaryColors;
    Color secondaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }

  static ThemeData newDarkTheme() {
    Color primaryColor = primaryColors;
    Color secondaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }

  Color get lightColor => isDark ? Color(0xFF595F69) : Colors.white;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
