/// Utility class for displaying toast messages to users.
///
/// This class provides a simple way to show snackbar-style toast messages
/// throughout the application. Toast messages are displayed at the bottom
/// of the screen with a primary color background.
///
/// Example:
/// ```dart
/// CommonToast.show(
///   context: context,
///   title: "Login successful",
/// );
/// ```
import 'package:flutter/material.dart';
import 'package:taghyeer_test/common/colors/app_colors.dart';

class CommonToast {
  /// Displays a toast message to the user.
  ///
  /// Shows a snackbar-style toast with the provided message.
  /// The toast uses the primary color background and white text.
  ///
  /// Parameters:
  /// - [context]: Build context for accessing ScaffoldMessenger
  /// - [title]: Message text to display
  ///
  /// Example:
  /// ```dart
  /// CommonToast.show(
  ///   context: context,
  ///   title: "Operation completed",
  /// );
  /// ```
  static void show({required BuildContext context, required String title}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cPrimary,
        content: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
