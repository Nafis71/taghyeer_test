/// View model for managing authentication state and operations.
///
/// This class extends [GetxController] and handles user authentication logic,
/// including login validation, API communication, and navigation after successful login.
///
/// Responsibilities:
/// - Validate user credentials
/// - Handle login API calls
/// - Manage loading states during authentication
/// - Navigate to appropriate screens based on authentication result
/// - Display error messages to users
///
/// The view model uses reactive programming with GetX observables to automatically
/// update the UI when authentication state changes.
///
/// Example:
/// ```dart
/// final authVM = Get.find<AuthVM>();
/// await authVM.initiateUserLogin('username', 'password');
/// ```
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/domain/repositories/auth_repo.dart';
import 'package:taghyeer_test/domain/result/failure.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_toast.dart';

import '../../common/utils/logger/logger_util.dart';

class AuthVM extends GetxController {
  /// Repository instance for authentication operations.
  ///
  /// Used to communicate with the domain layer to perform login operations.
  final AuthRepository _authRepository;

  /// Indicates whether an authentication operation is in progress.
  ///
  /// Set to true when login is being processed, false otherwise.
  /// Used to prevent multiple simultaneous login attempts and show loading indicators.
  RxBool isBusy = false.obs;

  /// Creates a new [AuthVM] instance.
  ///
  /// Parameters:
  /// - [authRepository]: Repository for authentication data operations
  AuthVM(this._authRepository);

  /// Initiates user login with provided credentials.
  ///
  /// This method performs the following operations:
  /// 1. Validates input credentials (non-empty)
  /// 2. Prevents concurrent login attempts
  /// 3. Calls the authentication repository
  /// 4. Handles success/failure responses
  /// 5. Navigates to appropriate screen based on result
  ///
  /// Parameters:
  /// - [userName]: User's username or email (will be trimmed)
  /// - [password]: User's password
  ///
  /// Behavior:
  /// - Returns early if context is null (widget disposed)
  /// - Shows error toast if credentials are empty
  /// - Shows error toast if login fails
  /// - Navigates to bottom navigation on success
  /// - Logs exceptions for debugging
  ///
  /// Example:
  /// ```dart
  /// await authVM.initiateUserLogin('"emilys', 'emilyspass');
  /// ```
  Future<void> initiateUserLogin(String userName, String password) async {
    if (Get.context == null) return;
    if (userName.trim().isEmpty || password.isEmpty) {
      return CommonToast.show(
        context: Get.context!,
        title: "User name or password cannot be empty",
      );
    }
    if (isBusy.value) return;
    try {
      isBusy.value = true;
      final Result result = await _authRepository.loginUser(
        userName.trim(),
        password,
      );
      if (result is Failure) {
        CommonToast.show(context: Get.context!, title: result.failureMessage!);
        return;
      }
      Get.offAllNamed(AppPages.bottomNavigation);
    } catch (exception, stacktrace) {
      logger.e(exception, stackTrace: stacktrace);
    } finally {
      isBusy.value = false;
    }
  }
}
