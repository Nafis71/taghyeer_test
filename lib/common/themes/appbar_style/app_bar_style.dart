/// App bar theme styles for light and dark modes.
///
/// This class provides consistent app bar styling across the application.
/// It defines the appearance of app bars including colors, text styles,
/// and elevation settings.
import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class AppBarStyles {
  /// Returns light theme app bar style.
  ///
  /// Configures app bar with:
  /// - White background
  /// - Black icons
  /// - No elevation
  ///
  /// Returns:
  /// - [AppBarTheme] for light mode
  static AppBarTheme getLightAppBarStyle() {
    return AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      toolbarTextStyle: const TextTheme(titleLarge: TextStyle(color: Colors.white, fontSize: 20)).bodyMedium,
      titleTextStyle: const TextTheme(titleLarge: TextStyle(color: Colors.white, fontSize: 20)).titleLarge,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  /// Returns dark theme app bar style.
  ///
  /// Configures app bar with:
  /// - Dark background (#181A20)
  /// - White icons
  /// - No elevation
  ///
  /// Returns:
  /// - [AppBarTheme] for dark mode
  static AppBarTheme getDarkAppBarStyle() {
    return getLightAppBarStyle().copyWith(
      backgroundColor: AppColors.c181A20,
      surfaceTintColor: AppColors.c181A20,
      foregroundColor: AppColors.c181A20,
      iconTheme: IconThemeData(color: AppColors.white),
    );
  }
}
