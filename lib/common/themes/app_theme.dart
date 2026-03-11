/// Application theme configuration.
///
/// This class provides theme data for both light and dark modes.
/// It combines various style components (text, cards, app bars, etc.)
/// into cohesive theme configurations that can be applied to the app.
///
/// The themes use Material 3 design system and include:
/// - Text styles with responsive sizing
/// - Card styles for light/dark modes
/// - App bar styles
/// - Bottom navigation bar styles
/// - Color schemes
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.getLightTheme(),
///   darkTheme: AppTheme.getDarkTheme(),
/// )
/// ```
import 'package:flutter/material.dart';
import 'package:taghyeer_test/common/colors/app_colors.dart';
import 'package:taghyeer_test/common/themes/appbar_style/app_bar_style.dart';
import 'package:taghyeer_test/common/themes/bottom_navigation_bar_style/bottom_navigation_bar_style.dart';
import 'package:taghyeer_test/common/themes/card_style/card_style.dart';
import 'package:taghyeer_test/common/themes/text_style/text_style.dart';

class AppTheme {
  /// Returns the light theme configuration.
  ///
  /// Creates a complete [ThemeData] object with:
  /// - Material 3 design system
  /// - White scaffold background
  /// - Blue color scheme
  /// - Custom text styles
  /// - Card styles
  /// - App bar styles
  /// - Bottom navigation bar styles
  ///
  /// Returns:
  /// - [ThemeData] configured for light mode
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
    cardTheme: CardStyle.getLightCardStyle(),
    bottomNavigationBarTheme: BottomNavigationBarStyle.getLightStyle(),
    splashColor: AppColors.cTransparent,
    splashFactory: NoSplash.splashFactory,
    appBarTheme: AppBarStyles.getLightAppBarStyle()
  );

  /// Returns the dark theme configuration.
  ///
  /// Creates a dark theme by copying the light theme and overriding
  /// specific properties for dark mode:
  /// - Dark scaffold background (#181A20)
  /// - White text color
  /// - Dark card styles
  /// - Dark app bar styles
  /// - Dark bottom navigation bar styles
  ///
  /// Returns:
  /// - [ThemeData] configured for dark mode
  static ThemeData getDarkTheme() => getLightTheme().copyWith(
    textTheme: AppTextStyle.getTextStyles(Colors.white),
    scaffoldBackgroundColor: AppColors.c181A20,
    cardTheme: CardStyle.getDarkCardStyle(),
    bottomNavigationBarTheme: BottomNavigationBarStyle.getDarkStyle(),
      appBarTheme: AppBarStyles.getDarkAppBarStyle()

  );
}
