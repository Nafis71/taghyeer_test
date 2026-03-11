/// Abstract repository interface for authentication operations.
///
/// This interface defines the contract for authentication-related data access
/// in the domain layer. Implementations should be provided in the data layer.
///
/// Following Clean Architecture principles, this interface is defined in the
/// domain layer to ensure business logic remains independent of data sources.
///
/// Example implementation:
/// ```dart
/// class AuthUseCase extends AuthRepository {
///   @override
///   Future<Result> loginUser(String userName, String password) {
///     // Implementation
///   }
/// }
/// ```
import 'package:taghyeer_test/domain/result/result.dart';

abstract class AuthRepository {
  /// Authenticates a user with provided credentials.
  ///
  /// Performs user login by validating credentials and returning authentication
  /// tokens. The method returns a [Result] object that can be either [Success]
  /// indicating successful login or [Failure] with error information.
  ///
  /// Parameters:
  /// - [userName]: User's username or email address
  /// - [password]: User's password
  ///
  /// Returns:
  /// - [Result] containing either:
  ///   - [Success] if authentication succeeds (user info and tokens are stored)
  ///   - [Failure] with error message and status code if authentication fails
  ///
  /// Security considerations:
  /// - Credentials should be transmitted securely (HTTPS)
  /// - Passwords should never be logged or stored in plain text
  /// - Tokens should be stored securely after successful login
  ///
  /// Example:
  /// ```dart
  /// final result = await repository.loginUser('username', 'password');
  /// if (result is Success) {
  ///   // User is logged in, tokens are stored
  /// } else if (result is Failure) {
  ///   // Handle error: result.failureMessage
  /// }
  /// ```
  Future<Result> loginUser(String userName, String password);
}