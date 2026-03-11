/// SVG asset path constants.
///
/// This class contains all SVG asset paths used throughout the application.
/// Using constants prevents typos and makes asset management easier.
///
/// All paths are relative to the assets folder and defined as static const strings.
///
/// Example:
/// ```dart
/// SvgPicture.asset(SvgAsset.productOutlined)
/// ```
class SvgAsset {
  /// Base path for all SVG assets.
  static const String basePath = "assets/svgs";

  /// Product icon (outlined style) for navigation and UI elements.
  static const String productOutlined = "$basePath/product_outlined.svg";

  /// Post icon (outlined style) for navigation and UI elements.
  static const String postOutlined = "$basePath/post_outlined.svg";

  /// Settings icon (outlined style) for navigation and UI elements.
  static const String settingsOutlined = "$basePath/settings_outlined.svg";

  /// Product icon (filled style) for active navigation state.
  static const String productFilled = "$basePath/product_filled.svg";

  /// Post icon (filled style) for active navigation state.
  static const String postFilled = "$basePath/post_filled.svg";

  /// Settings icon (filled style) for active navigation state.
  static const String settingsFilled = "$basePath/settings_filled.svg";

  /// Discount badge icon for product cards.
  static const String discount = "$basePath/discount.svg";

  /// Like icon for post reactions.
  static const String like = "$basePath/like.svg";

  /// Dislike icon for post reactions.
  static const String dislike = "$basePath/dislike.svg";

  /// Logout icon for user actions.
  static const String logout = "$basePath/logout.svg";

  /// Right arrow icon for navigation indicators.
  static const String rightArrow = "$basePath/right_arrow.svg";

  /// Empty result icon for empty state screens.
  static const String emptyResult = "$basePath/empty_result.svg";
}