import 'package:flutter/material.dart';
import 'package:taghyeer_test/common/themes/text_style/text_style.dart';

class AppTheme {
  static ThemeData getLightTheme() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      onSurface: Colors.black,
    ),
    brightness: Brightness.light,
    textTheme: AppTextStyle.getTextStyles(),
  );

  static ThemeData getDarkTheme() => getLightTheme().copyWith(
    textTheme: AppTextStyle.getTextStyles(Colors.white),
  );
}
