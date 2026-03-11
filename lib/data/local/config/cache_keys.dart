/// Storage key constants for local cache operations.
///
/// This class contains all keys used for storing and retrieving data
/// from local storage. Using constants prevents typos and makes key
/// management easier.
///
/// All keys are defined as static const strings to ensure they're
/// compile-time constants.
///
/// Example:
/// ```dart
/// await storage.write(key: CacheKeys.accessToken, value: token);
/// final token = storage.read(key: CacheKeys.accessToken);
/// ```
class CacheKeys {
  /// Key for storing JWT access token.
  ///
  /// Used to persist authentication token for authenticated API requests.
  static const String accessToken = "accessToken";

  /// Key for storing user information as JSON.
  ///
  /// Contains encoded user profile data retrieved during login.
  static const String userInfo = "userInfo";

  /// Key for storing theme mode preference.
  ///
  /// Values: "light", "dark", or "system"
  static const String themeMode = "themeMode";
}