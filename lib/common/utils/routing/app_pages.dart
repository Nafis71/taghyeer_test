/// Application route name constants.
///
/// This class contains all route names used throughout the application.
/// Using constants prevents typos and makes route management easier.
///
/// All routes are defined as static const strings to ensure they're
/// compile-time constants and can be used in switch statements.
///
/// Route naming convention:
/// - Use kebab-case for multi-word routes
/// - Keep route names descriptive and consistent
/// - Match route names with screen purposes
///
/// Example:
/// ```dart
/// Get.toNamed(AppPages.productDetails, arguments: {'product': product});
/// ```
class AppPages {
  /// Initial route (splash screen).
  static const String initial = "/";

  /// Login screen route.
  static const String login = "/login";

  /// Bottom navigation bar route (main app screen).
  static const String bottomNavigation = "/bottom-navigation";

  /// Product details screen route.
  static const String productDetails = "/product-details";

  /// Post details screen route.
  static const String postDetails = "/post-details";
}