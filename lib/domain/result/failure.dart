/// Represents a failed operation result.
///
/// This class is used to wrap error information when an operation fails.
/// It extends [Result] and contains details about why the operation failed,
/// including an error message and optional HTTP status code.
///
/// Example:
/// ```dart
/// final result = Failure(
///   failureMessage: "Network error",
///   statusCode: 500,
/// );
/// if (result is Failure) {
///   print(result.failureMessage);
/// }
/// ```
///
/// Type parameter:
/// - [T]: The type parameter (unused but maintained for consistency)
import 'package:taghyeer_test/domain/result/result.dart';

class Failure<T> extends Result {
  /// Human-readable error message describing the failure.
  ///
  /// Should provide clear information about what went wrong.
  final String? failureMessage;

  /// HTTP status code associated with the failure (if applicable).
  ///
  /// Useful for API-related failures to determine the type of error.
  /// Can be null for non-HTTP errors.
  final int? statusCode;

  /// Creates a new [Failure] instance.
  ///
  /// Parameters:
  /// - [failureMessage]: Error message describing the failure
  /// - [statusCode]: Optional HTTP status code
  Failure({this.statusCode, this.failureMessage});
}
