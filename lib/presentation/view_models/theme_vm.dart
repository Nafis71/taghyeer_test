/// View model for managing application theme state.
///
/// This class extends [GetxController] and handles theme mode management,
/// including light, dark, and system theme modes. It persists theme preferences
/// to local storage and provides reactive theme state updates.
///
/// Responsibilities:
/// - Manage current theme mode (light/dark/system)
/// - Persist theme preferences to local storage
/// - Determine if dark mode is active based on current theme
/// - Provide reactive theme updates to UI components
///
/// The view model is registered as a permanent dependency, ensuring theme
/// preferences persist across app restarts.
///
/// Example:
/// ```dart
/// final themeVM = Get.find<ThemeVM>();
/// themeVM.setThemeMode = ThemeMode.dark;
/// final isDark = themeVM.isDarkMode(context);
/// ```
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/data/local/config/cache_keys.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';

class ThemeVM extends GetxController {
  /// Reactive theme mode observable.
  ///
  /// Tracks the current theme mode and automatically updates UI when changed.
  /// Defaults to [ThemeMode.system] to follow system preferences.
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  /// Gets the current theme mode.
  ///
  /// Returns the currently active theme mode (light, dark, or system).
  ///
  /// Returns:
  /// - [ThemeMode] representing the current theme preference
  ThemeMode get getThemeMode => themeMode.value;

  /// Sets the theme mode and persists it to local storage.
  ///
  /// Updates the theme mode and saves the preference to local storage
  /// so it persists across app restarts. The change triggers reactive
  /// UI updates automatically.
  ///
  /// Parameters:
  /// - [themeMode]: The theme mode to set (light, dark, or system)
  ///
  /// The theme preference is stored as a string representation of the
  /// theme mode name and can be restored on app startup.
  set setThemeMode(ThemeMode themeMode) {
    StorageController().write(key: CacheKeys.themeMode, value: themeMode.name);
    this.themeMode.value = themeMode;
  }

  /// Determines if dark mode is currently active.
  ///
  /// Checks the current theme mode and returns whether dark mode should be used.
  /// If theme mode is set to system, it checks the device's platform brightness.
  ///
  /// Parameters:
  /// - [context]: Build context to access MediaQuery for system brightness
  ///
  /// Returns:
  /// - `true` if dark mode is active
  /// - `false` if light mode is active
  ///
  /// Theme mode resolution:
  /// - [ThemeMode.light] → Always returns `false`
  /// - [ThemeMode.dark] → Always returns `true`
  /// - [ThemeMode.system] → Returns based on device brightness
  ///
  /// Example:
  /// ```dart
  /// final isDark = themeVM.isDarkMode(context);
  /// final color = isDark ? Colors.white : Colors.black;
  /// ```
  bool isDarkMode(BuildContext context) {
    if (themeMode.value == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  }
}