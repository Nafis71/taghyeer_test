/// View model for managing user state and authentication-related operations.
///
/// This class extends [GetxController] and handles user information management
/// and logout functionality. It maintains the current user's information and
/// provides methods to clear user session data.
///
/// Responsibilities:
/// - Store and manage current user information
/// - Handle user logout operations
/// - Clear authentication data from local storage
/// - Navigate to login screen after logout
///
/// The view model is registered as a permanent dependency in the DI container,
/// ensuring user information persists throughout the app lifecycle.
///
/// Example:
/// ```dart
/// final userVM = Get.find<UserVM>();
/// await userVM.logoutUser();
/// ```
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/data/local/config/cache_keys.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/domain/entities/login_e.dart';

class UserVM extends GetxController {
  /// Current logged-in user's information.
  ///
  /// Contains user details retrieved during login, including user ID,
  /// username, and other profile information.
  ///
  /// Set to `null` when user logs out or is not authenticated.
  LoginEntity? userInfo;

  /// Storage controller instance for local storage operations.
  ///
  /// Used to read and write user-related data to persistent storage.
  final StorageController _storageController;

  /// Creates a new [UserVM] instance.
  ///
  /// Parameters:
  /// - [storageController]: Controller for local storage operations
  UserVM(this._storageController);

  /// Logs out the current user and clears all authentication data.
  ///
  /// This method performs the following operations:
  /// 1. Clears user information from memory
  /// 2. Removes user info from local storage
  /// 3. Removes access token from local storage
  /// 4. Navigates to login screen
  ///
  /// The logout process is atomic - all storage operations are performed
  /// concurrently using [Future.wait] for better performance.
  ///
  /// After logout, the user will need to log in again to access the app.
  ///
  /// Navigation:
  /// - Always navigates to login screen after logout
  ///
  /// Example:
  /// ```dart
  /// await userVM.logoutUser();
  /// ```
  Future<void> logoutUser() async {
    // Clear user information from memory
    userInfo = null;

    // Clear authentication data from storage concurrently
    await Future.wait([
      _storageController.clear(key: CacheKeys.userInfo),
      _storageController.clear(key: CacheKeys.accessToken),
    ]);

    // Navigate to login screen
    Get.offAllNamed(AppPages.login);
  }
}
