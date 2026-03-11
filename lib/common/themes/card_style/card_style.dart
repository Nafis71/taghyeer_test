/// Card theme styles for light and dark modes.
///
/// This class provides consistent card styling across the application.
/// It defines card colors and elevation for both theme modes.
import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class CardStyle {
  /// Returns light theme card style.
  ///
  /// Configures cards with:
  /// - Light gray background (#FAFAFA)
  /// - No elevation (flat design)
  ///
  /// Returns:
  /// - [CardThemeData] for light mode
  static CardThemeData getLightCardStyle() =>
      CardThemeData(color: AppColors.cFAFAFA, elevation: 0);

  /// Returns dark theme card style.
  ///
  /// Configures cards with:
  /// - Dark background (#1F222A)
  /// - No elevation (flat design)
  ///
  /// Returns:
  /// - [CardThemeData] for dark mode
  static CardThemeData getDarkCardStyle() =>
      getLightCardStyle().copyWith(color: AppColors.c1F222A);
}
