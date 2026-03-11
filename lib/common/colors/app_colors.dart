/// Application color constants.
///
/// This class contains all color values used throughout the application.
/// Using constants ensures color consistency and makes it easier to update
/// the color scheme when needed.
///
/// All colors are defined as static const [Color] values.
///
/// Example:
/// ```dart
/// Container(color: AppColors.cPrimary)
/// ```
import 'package:flutter/material.dart';

class AppColors {
  /// Pure white color.
  static const Color white = Colors.white;

  /// Pure black color.
  static const Color black = Colors.black;

  /// Transparent color.
  static const Color cTransparent = Colors.transparent;

  /// Primary brand color (dark blue: #0000B3).
  ///
  /// Used for primary actions, highlights, and brand elements.
  static const Color cPrimary = Color(0xFF0000B3);

  /// Light gray background color (#EEEEEE).
  static const Color cEEEEEE = Color(0xFFEEEEEE);

  /// Dark gray color for dark theme (#1F222A).
  static const Color c1F222A = Color(0xFF1F222A);

  /// Very light gray background color (#FAFAFA).
  static const Color cFAFAFA = Color(0xFFFAFAFA);

  /// Light blue tint color (#EDF0FF).
  static const Color cEDF0FF = Color(0xFFEDF0FF);

  /// Light gray color (#F2F2F2).
  ///
  /// Commonly used for card backgrounds and dividers.
  static const Color cF2F2F2 = Color(0xFFF2F2F2);

  /// Dark background color for dark theme (#181A20).
  static const Color c181A20 = Color(0xFF181A20);
}
