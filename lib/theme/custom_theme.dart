import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primaryColor: ColorConstants.primary,
      scaffoldBackgroundColor: ColorConstants.background,
      colorScheme: _customColorScheme,
      fontFamily: 'Montserrat', //3
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorConstants.primary),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: ColorConstants.onPrimary,
          )),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
        ),
      ),
    );
  }
}

const ColorScheme _customColorScheme = ColorScheme(
  primary: ColorConstants.primary,
  secondary: ColorConstants.secondary,
  surface: Colors.purpleAccent,
  background: ColorConstants.background,
  error: Colors.redAccent,
  onPrimary: ColorConstants.onPrimary,
  onSecondary: ColorConstants.onSecondary,
  onSurface: Colors.redAccent,
  onBackground: Colors.redAccent,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);
