/// Bottom navigation bar theme styles for light and dark modes.
///
/// This class provides consistent bottom navigation bar styling across
/// the application. It defines colors, text styles, and visual properties
/// for the navigation bar.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taghyeer_test/common/colors/app_colors.dart';

class BottomNavigationBarStyle {
  /// Returns light theme bottom navigation bar style.
  ///
  /// Configures navigation bar with:
  /// - White background
  /// - Primary color for selected items
  /// - Gray for unselected items
  /// - Responsive text sizing
  ///
  /// Returns:
  /// - [BottomNavigationBarThemeData] for light mode
  static BottomNavigationBarThemeData getLightStyle() => BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      color: AppColors.black,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 12.sp,
    ),
    elevation: 12,
    selectedItemColor: AppColors.cPrimary,
    unselectedItemColor: Colors.grey.shade600,
    enableFeedback: false,
  );

  /// Returns dark theme bottom navigation bar style.
  ///
  /// Configures navigation bar with:
  /// - Dark background (#1F222A)
  /// - White text for selected items
  /// - Gray for unselected items
  ///
  /// Returns:
  /// - [BottomNavigationBarThemeData] for dark mode
  static BottomNavigationBarThemeData getDarkStyle() => getLightStyle().copyWith(
    backgroundColor: AppColors.c1F222A,
    selectedLabelStyle: TextStyle(
      color: AppColors.white,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.grey.shade600,
      fontSize: 12.sp,
    ),
  );
}