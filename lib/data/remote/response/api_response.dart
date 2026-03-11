/// Wrapper class for API responses.
///
/// This class standardizes API responses by providing a consistent structure
/// for both successful and error responses. It simplifies error handling
/// and response parsing throughout the application.
///
/// Type parameter:
/// - [T]: The type of data contained in successful responses
///
/// Example:
/// ```dart
/// final response = ApiResponse.success(data: productList);
/// if (response.isSuccess) {
///   final products = response.data;
/// }
/// ```
class ApiResponse<T> {
  /// Response data payload (only present for successful responses).
  ///
  /// Can be any type depending on the API endpoint.
  final T? data;

  /// Human-readable message describing the response or error.
  final String? message;

  /// HTTP status code (only present for error responses).
  ///
  /// Common codes: 400 (Bad Request), 401 (Unauthorized), 404 (Not Found), 500 (Server Error)
  final int? statusCode;

  /// Indicates whether the API call was successful.
  ///
  /// - `true`: Request succeeded, [data] contains the response
  /// - `false`: Request failed, [message] and [statusCode] contain error details
  final bool isSuccess;

  /// Creates a successful API response.
  ///
  /// Parameters:
  /// - [data]: The response data payload
  /// - [message]: Optional success message
  ///
  /// Example:
  /// ```dart
  /// final response = ApiResponse.success(data: products);
  /// ```
  ApiResponse.success({this.data, this.message})
      : isSuccess = true,
        statusCode = null;

  /// Creates an error API response.
  ///
  /// Parameters:
  /// - [message]: Error message describing what went wrong
  /// - [statusCode]: HTTP status code (optional)
  ///
  /// Example:
  /// ```dart
  /// final response = ApiResponse.error(
  ///   message: "User not found",
  ///   statusCode: 404,
  /// );
  /// ```
  ApiResponse.error({this.message, this.statusCode})
      : isSuccess = false,
        data = null;
}
