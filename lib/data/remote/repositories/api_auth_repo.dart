/// Abstract repository interface for authentication API operations.
///
/// This interface defines the contract for authentication-related API calls
/// in the data layer. Implementations handle the actual HTTP communication.
///
/// Example implementation:
/// ```dart
/// class AuthRequest extends ApiAuthRepository {
///   @override
///   Future<ApiResponse> login(Map<String, dynamic> params) {
///     // Implementation
///   }
/// }
/// ```
library;
import 'package:taghyeer_test/data/remote/response/api_response.dart';

abstract class ApiAuthRepository {
  /// Performs user login API call.
  ///
  /// Parameters:
  /// - [params]: Map containing login credentials:
  ///   - `username`: User's username or email
  ///   - `password`: User's password
  ///   - `expiresInMins`: Token expiration time in minutes (optional)
  ///
  /// Returns:
  /// - [ApiResponse] containing either:
  ///   - Success response with user data and tokens
  ///   - Error response with error message and status code
  ///
  /// Example:
  /// ```dart
  /// final response = await repository.login({
  ///   'username': 'emilys',
  ///   'password': 'emilyspass',
  ///   'expiresInMins': 30,
  /// });
  /// ```
  Future<ApiResponse> login(Map<String, dynamic> params);
}
