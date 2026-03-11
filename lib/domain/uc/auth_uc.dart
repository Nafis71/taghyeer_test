/// Use case implementation for authentication business logic.
///
/// This class implements the [AuthRepository] interface and contains
/// the business logic for user authentication. It acts as an intermediary
/// between the presentation layer and the data layer, ensuring separation
/// of concerns.
///
/// Responsibilities:
/// - Execute authentication operations
/// - Handle API response mapping
/// - Transform API models to domain entities
/// - Store authentication tokens securely
/// - Update user state in UserVM
/// - Handle errors and exceptions
/// - Log operations for debugging
///
/// Security features:
/// - Stores access tokens in secure storage
/// - Updates network controller with access token
/// - Persists user information for session restoration
///
/// Example:
/// ```dart
/// final useCase = AuthUseCase(apiRepository, userVM);
/// final result = await useCase.loginUser('username', 'password');
/// ```
import 'dart:convert';

import 'package:taghyeer_test/data/local/config/cache_keys.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/data/remote/models/login_m.dart';
import 'package:taghyeer_test/data/remote/repositories/api_auth_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';
import 'package:taghyeer_test/domain/entities/login_e.dart';
import 'package:taghyeer_test/domain/repositories/auth_repo.dart';
import 'package:taghyeer_test/domain/result/failure.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';
import 'package:taghyeer_test/presentation/view_models/user_vm.dart';

import '../../common/utils/logger/logger_util.dart';

class AuthUseCase extends AuthRepository {
  /// API repository instance for authentication operations.
  ///
  /// This repository handles the actual API communication and returns
  /// raw API responses that are then transformed into domain entities.
  final ApiAuthRepository _apiAuthRepository;

  /// User view model instance for managing user state.
  ///
  /// Used to update user information after successful authentication.
  final UserVM _userVM;

  /// Storage controller instance for local data persistence.
  ///
  /// Used to store authentication tokens and user information securely.
  final StorageController _storageController = StorageController();

  /// Network controller instance for token management.
  ///
  /// Used to update the access token for authenticated API requests.
  final NetworkController _networkController = NetworkController();

  /// Creates a new [AuthUseCase] instance.
  ///
  /// Parameters:
  /// - [apiAuthRepository]: The API repository for authentication data access
  /// - [userVM]: User view model for state management
  AuthUseCase(this._apiAuthRepository, this._userVM);

  /// Authenticates a user with provided credentials.
  ///
  /// This method performs the following operations:
  /// 1. Calls the API repository to authenticate the user
  /// 2. Validates the API response
  /// 3. Transforms API model to domain entity
  /// 4. Saves authentication tokens and user info to storage
  /// 5. Updates network controller with access token
  /// 6. Updates user view model with user information
  /// 7. Returns a [Result] object with success or failure
  ///
  /// Parameters:
  /// - [userName]: User's username or email address
  /// - [password]: User's password
  ///
  /// Returns:
  /// - [Success] if authentication succeeds (tokens and user info are stored)
  /// - [Failure] with an error message if authentication fails
  ///
  /// Security:
  /// - Access token is stored in secure storage
  /// - User information is encoded as JSON before storage
  /// - Network controller is updated with access token for subsequent requests
  ///
  /// Throws:
  /// - Logs exceptions but returns a [Failure] instead of throwing
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.loginUser('emilys', 'emilyspass');
  /// if (result is Success) {
  ///   // User is logged in, tokens stored
  /// } else if (result is Failure) {
  ///   // Handle error
  /// }
  /// ```
  @override
  Future<Result> loginUser(String userName, String password) async {
    try {
      // Call API to authenticate user
      final ApiResponse response = await _apiAuthRepository.login({
        "username": userName,
        "password": password,
        "expiresInMins": 30, // Token expires in 30 minutes
      });

      // Check if API call was successful
      if (!response.isSuccess) {
        return Failure(
          failureMessage: response.message,
          statusCode: response.statusCode,
        );
      }

      // Transform API response to domain entity
      LoginEntity loginEntity = LoginModel.fromJson(response.data);

      // Save authentication data
      await _saveUserInformation(loginEntity);

      return Success();
    } catch (exception, stacktrace) {
      // Log exception for debugging
      logger.e(exception, stackTrace: stacktrace);
    }

    // Return generic failure if exception occurs
    return Failure(failureMessage: "Something went wrong");
  }

  /// Saves user information and authentication tokens to storage.
  ///
  /// This private method handles the persistence of authentication data:
  /// 1. Stores access token in secure storage
  /// 2. Stores user information as JSON in secure storage
  /// 3. Updates network controller with access token
  /// 4. Updates user view model with user information
  ///
  /// Parameters:
  /// - [loginEntity]: Login entity containing user info and tokens
  ///
  /// Storage keys:
  /// - [CacheKeys.accessToken]: Stores JWT access token
  /// - [CacheKeys.userInfo]: Stores encoded user information JSON
  ///
  /// The user information is encoded as JSON before storage to allow
  /// easy deserialization when restoring the session.
  Future<void> _saveUserInformation(LoginEntity loginEntity) async {
    // Store access token
    await _storageController.write(
      key: CacheKeys.accessToken,
      value: loginEntity.accessToken,
    );

    // Store user information as JSON
    await _storageController.write(
      key: CacheKeys.userInfo,
      value: jsonEncode((loginEntity as LoginModel).toJson()),
    );

    // Update network controller with access token
    _networkController.setAccessToken = loginEntity.accessToken ?? "";

    // Update user view model
    _userVM.userInfo = loginEntity;
  }
}
