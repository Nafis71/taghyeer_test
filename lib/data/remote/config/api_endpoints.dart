/// API endpoint configuration constants.
///
/// This class contains all API endpoint URLs used throughout the application.
/// Using constants centralizes endpoint management and makes it easier to
/// update URLs when needed.
///
/// All endpoints are defined as static const strings.
///
/// Base URL: https://dummyjson.com
///
/// Example:
/// ```dart
/// final response = await networkController.request(
///   url: ApiEndpoints.productList,
///   method: Method.get,
/// );
/// ```
class ApiEndpoints {
  /// Base URL for all API endpoints.
  static const String baseUrl = "https://dummyjson.com";

  /// User authentication endpoint.
  ///
  /// Method: POST
  /// Body: {username, password, expiresInMins}
  static const String loginUrl = "$baseUrl/auth/login";

  /// Product list endpoint with pagination support.
  ///
  /// Method: GET
  /// Query params: limit, skip
  static const String productList = "$baseUrl/products";

  /// Post list endpoint with pagination support.
  ///
  /// Method: GET
  /// Query params: limit, skip
  static const String postList = "$baseUrl/posts";
}