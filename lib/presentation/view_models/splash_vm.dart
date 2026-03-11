/// View model for managing splash screen logic and initial app routing.
///
/// This class extends [GetxController] and handles the splash screen functionality,
/// including authentication check, user session validation, and initial navigation.
///
/// Responsibilities:
/// - Display splash screen for a minimum duration
/// - Check if user is already logged in
/// - Validate JWT token expiration
/// - Load user information from local storage
/// - Navigate to appropriate screen (login or main app)
///
/// The splash screen serves as the entry point that determines where the user
/// should be directed based on their authentication status.
///
/// Example:
/// ```dart
/// final splashVM = Get.find<SplashVM>();
/// await splashVM.triggerSplash();
/// ```
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:taghyeer_test/common/utils/logger/logger_util.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/presentation/view_models/user_vm.dart';

import '../../data/local/config/cache_keys.dart';
import '../../data/remote/models/login_m.dart';

class SplashVM extends GetxController {
  /// Storage controller instance for accessing local storage.
  ///
  /// Used to read authentication tokens and user information.
  final StorageController _storageController;

  /// User view model instance for managing user state.
  ///
  /// Used to load and store user information after authentication check.
  final UserVM _userVM;

  /// Creates a new [SplashVM] instance.
  ///
  /// Parameters:
  /// - [storageController]: Controller for local storage operations
  /// - [userVM]: View model for user state management
  SplashVM(this._storageController, this._userVM);

  /// Triggers the splash screen flow.
  ///
  /// This method performs the following operations:
  /// 1. Displays splash screen for 2 seconds
  /// 2. Checks if user has a valid authentication token
  /// 3. If logged in: loads user info and navigates to main app
  /// 4. If not logged in: navigates to login screen
  ///
  /// The method uses JWT token validation to determine if the user's
  /// session is still valid. If the token is expired or missing, the
  /// user is redirected to the login screen.
  ///
  /// Navigation:
  /// - Authenticated users → Bottom navigation (main app)
  /// - Unauthenticated users → Login screen
  ///
  /// Example:
  /// ```dart
  /// await splashVM.triggerSplash();
  /// ```
  Future<void> triggerSplash() async {
    // Display splash screen for minimum duration
    await Future.delayed(Duration(seconds: 2));

    // Check authentication status
    logger.i("user logged in : ${_isUserLoggedIn()}");

    if (_isUserLoggedIn()) {
      // User is authenticated, load user info and go to main app
      await _loadUserInfo();
      Get.offNamed(AppPages.bottomNavigation);
      return;
    }

    // User is not authenticated, go to login screen
    Get.offNamed(AppPages.login);
  }

  /// Checks if the user is currently logged in.
  ///
  /// Validates the authentication status by:
  /// 1. Reading the access token from local storage
  /// 2. Checking if the token exists
  /// 3. Validating if the JWT token is expired
  ///
  /// Returns:
  /// - `true` if user has a valid, non-expired token
  /// - `false` if token is missing or expired
  ///
  /// The method uses JWT decoder to check token expiration without
  /// making a network request, providing fast authentication check.
  bool _isUserLoggedIn() {
    final String? accessToken = _storageController.read(
      key: CacheKeys.accessToken,
    );
    if (accessToken == null) return false;
    return !JwtDecoder.isExpired(accessToken);
  }

  /// Loads user information from local storage.
  ///
  /// Retrieves the stored user information (encoded as JSON) and deserializes
  /// it into a [LoginModel] object, then stores it in the user view model.
  ///
  /// If no user information is found in storage, the method returns early
  /// without updating the user view model.
  ///
  /// The user information is stored during login and retrieved here to
  /// restore the user session without requiring a new login.
  Future<void> _loadUserInfo() async {
    String encodedUserInfo =
        await _storageController.read(key: CacheKeys.userInfo) ?? "";
    if (encodedUserInfo.isEmpty) return;
    _userVM.userInfo = LoginModel.fromJson(jsonDecode(encodedUserInfo));
  }
}
