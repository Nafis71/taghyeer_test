import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeVM extends GetxController{
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  ThemeMode get getThemeMode => themeMode.value;

  set setThemeMode(ThemeMode themeMode) {
    // LocalStorage().write(key: "themeMode", value: themeMode.name);
    this.themeMode.value = themeMode;
  }

  bool isDarkMode(BuildContext context) {
    if (themeMode.value == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  }
}