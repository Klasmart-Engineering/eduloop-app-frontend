import 'package:edu_app/theme/theme_utils.dart';
import 'package:flutter/material.dart';

import 'theme_constants.dart';

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
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18.00)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 10, vertical: 25)),
            foregroundColor: MaterialStateProperty.resolveWith(
                (states) => fadeOnDisable(states, ColorConstants.onPrimary)),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => fadeOnDisable(states, ColorConstants.primary)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConstants.elevatedButtonRadius),
            )),
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: ColorConstants.backgroundDark,
        ));
  }
}

ColorScheme _customColorScheme = ColorScheme(
  primary: ColorConstants.primary,
  secondary: ColorConstants.secondary,
  tertiary: ColorConstants.tertiary,
  surface: Colors.purpleAccent,
  background: ColorConstants.background,
  error: Colors.redAccent,
  onPrimary: ColorConstants.onPrimary,
  onSecondary: ColorConstants.onSecondary,
  onTertiary: ColorConstants.onTertiary,
  onSurface: Colors.redAccent,
  onBackground: Colors.redAccent,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);
