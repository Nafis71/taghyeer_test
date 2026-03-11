/// Standard padding constants used throughout the application.
///
/// Provides consistent spacing values to maintain visual harmony
/// across all screens and widgets. These values are used with ScreenUtil
/// for responsive design, ensuring consistent spacing across different
/// screen sizes.
///
/// Example:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AppPaddings.kDefaultPadding),
///   child: Widget(),
/// )
/// ```
class AppPaddings {
  /// Small padding value (8 pixels).
  ///
  /// Used for tight spacing between closely related elements.
  static const double kPaddingSmall = 8;

  /// Medium padding value (16 pixels).
  ///
  /// Used for standard spacing between sections and components.
  static const double kPaddingMedium = 16;

  /// Large padding value (32 pixels).
  ///
  /// Used for generous spacing between major sections.
  static const double kPaddingLarge = 32;

  /// Default padding value (12 pixels).
  ///
  /// Most commonly used padding value throughout the application.
  static const double kDefaultPadding = 12;
}
