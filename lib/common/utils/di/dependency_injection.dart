/// Dependency injection configuration for the application.
///
/// This class manages the registration of all dependencies using GetX's
/// dependency injection system. It follows the Service Locator pattern
/// and ensures all dependencies are properly initialized before use.
///
/// The initialization process:
/// 1. Creates singleton instances for core services (NetworkController, ThemeVM, UserVM)
/// 2. Registers view models with their dependencies
/// 3. Uses lazy loading for view models to improve performance
/// 4. Marks permanent dependencies to prevent automatic disposal
///
/// Dependencies are registered using:
/// - [Get.put]: For immediate initialization (singletons)
/// - [Get.lazyPut]: For lazy initialization (created on first access)
/// - [fenix: true]: Allows automatic recreation if disposed
///
/// Example:
/// ```dart
/// // Initialize all dependencies
/// DependencyInjection.init();
///
/// // Access a dependency
/// final productVM = Get.find<ProductVM>();
/// ```
import 'package:get/get.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/data/remote/requests/auth_request.dart';
import 'package:taghyeer_test/data/remote/requests/post_request.dart';
import 'package:taghyeer_test/domain/uc/auth_uc.dart';
import 'package:taghyeer_test/domain/uc/post_uc.dart';
import 'package:taghyeer_test/domain/uc/product_uc.dart';
import 'package:taghyeer_test/presentation/view_models/auth_vm.dart';
import 'package:taghyeer_test/presentation/view_models/post_vm.dart';
import 'package:taghyeer_test/presentation/view_models/product_vm.dart';
import 'package:taghyeer_test/presentation/view_models/splash_vm.dart';
import 'package:taghyeer_test/presentation/view_models/user_vm.dart';

import '../../../data/remote/requests/product_request.dart';
import '../../../presentation/view_models/bottom_navigation_vm.dart';
import '../../../presentation/view_models/theme_vm.dart';

class DependencyInjection {
  /// Initializes and registers all application dependencies.
  ///
  /// This method should be called once during app initialization, typically
  /// in the [main] function before [runApp].
  ///
  /// Registration strategy:
  /// - **Permanent dependencies**: ThemeVM, UserVM, AuthVM (always available)
  /// - **Lazy dependencies**: ViewModels (created on first access, auto-recreated if disposed)
  ///
  /// The method creates dependency chains:
  /// - NetworkController → Request classes → Use Cases → ViewModels
  /// - StorageController → UserVM → AuthVM
  ///
  /// Throws [Exception] if dependency registration fails.
  static void init() {
    NetworkController networkController = NetworkController();
    Get.put<ThemeVM>(ThemeVM(), permanent: true);
    Get.put<UserVM>(UserVM(StorageController()), permanent: true);
    Get.put<AuthVM>(
      AuthVM(AuthUseCase(AuthRequest(networkController), Get.find<UserVM>())),
      permanent: true,
    );
    Get.lazyPut<SplashVM>(
      () => SplashVM(StorageController(), Get.find<UserVM>()),
      fenix: true,
    );
    Get.lazyPut<BottomNavigationVM>(() => BottomNavigationVM(), fenix: true);
    Get.lazyPut<ProductVM>(
      () => ProductVM(ProductUseCase(ProductRequest(networkController))),
      fenix: true,
    );
    Get.lazyPut(
      () => PostVM(PostUseCase(PostRequest(networkController))),
      fenix: true,
    );
  }
}
