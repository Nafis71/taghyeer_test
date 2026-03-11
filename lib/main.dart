/// Main entry point for the Taghyeer Test Flutter application.
///
/// This file initializes the Flutter application with all necessary dependencies,
/// sets up dependency injection, configures routing, and initializes the app theme.
/// The app uses Clean Architecture principles with GetX for state management.
///
/// Key responsibilities:
/// - Initialize Flutter bindings
/// - Set up local storage and network controllers
/// - Configure dependency injection
/// - Initialize theme preferences
/// - Set up responsive design with ScreenUtil
///
/// Author: Taghyeer Team
/// Version: 1.0.0+1

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taghyeer_test/common/themes/app_theme.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/data/local/config/cache_keys.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/presentation/view_models/theme_vm.dart';

import 'common/utils/di/dependency_injection.dart';
import 'common/utils/routing/app_routes.dart';
import 'data/local/controller/storage_controller.dart';

/// Application entry point.
///
/// Initializes the Flutter application with all required services and dependencies.
/// Sets up responsive design using ScreenUtil with iPhone X dimensions (375x812) as the design size.
///
/// The initialization process includes:
/// 1. Storage controller initialization
/// 2. Network controller initialization
/// 3. Dependency injection setup
/// 4. Theme preference loading
///
/// Throws [Exception] if initialization fails.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initApp();
  runApp(
    /// Initialize ScreenUtil for responsive design.
    /// Design size matches iPhone X dimensions (375x812).
    ScreenUtilInit(
      designSize: (const Size(375, 812)),
      minTextAdapt: true,
      splitScreenMode: true,
      child: TaghyeerTest(),
    ),
  );
}

/// Initializes all application services and dependencies.
///
/// This function performs the following initialization steps:
/// 1. Initializes the storage controller for local data persistence
/// 2. Initializes the network controller for API communication
/// 3. Sets up dependency injection using GetX
/// 4. Loads and applies saved theme preferences
///
/// Should be called before [runApp] to ensure all services are ready.
///
/// Throws [Exception] if any initialization step fails.
Future<void> _initApp() async {
  await StorageController().init();
  await NetworkController().init();
  DependencyInjection.init();
  _initTheme();
}

/// Initializes the application theme based on saved preferences.
///
/// Reads the theme mode from local storage and applies it to the theme view model.
/// If no saved preference exists, defaults to system theme mode.
///
/// Supported theme modes:
/// - `light`: Light theme
/// - `dark`: Dark theme
/// - `system`: Follows system theme preference
///
/// The theme preference is persisted in local storage and restored on app restart.
Future<void> _initTheme() async {
  final ThemeVM themeVM = Get.find();
  final String themeMode =
      await StorageController().read(key: CacheKeys.themeMode) ??
      ThemeMode.system.name;
  switch (themeMode) {
    case "light":
      themeVM.setThemeMode = ThemeMode.light;
      break;
    case "dark":
      themeVM.setThemeMode = ThemeMode.dark;
      break;
    case "system":
      themeVM.setThemeMode = ThemeMode.system;
      break;
  }
}

/// Root widget of the application.
///
/// Configures the GetMaterialApp with routing, theming, and navigation settings.
/// The app uses GetX for state management and navigation, with support for
/// light and dark themes that can be switched dynamically.
///
/// Features:
/// - Named route navigation
/// - Dynamic theme switching (light/dark/system)
/// - Custom page transitions
/// - Text scaling prevention for consistent UI
class TaghyeerTest extends StatefulWidget {
  /// Creates a new instance of [TaghyeerTest].
  ///
  /// The [key] parameter is optional and used for widget identification.
  const TaghyeerTest({super.key});

  @override
  State<TaghyeerTest> createState() => _TaghyeerTestState();
}

/// State class for [TaghyeerTest] widget.
///
/// Manages the application's root widget state and theme configuration.
/// Reactively updates the UI when theme changes occur through GetX observables.
class _TaghyeerTestState extends State<TaghyeerTest> {
  /// Theme view model instance for managing theme state.
  ///
  /// Retrieved from GetX dependency injection container.
  /// Used to observe theme changes and update the app theme accordingly.
  final ThemeVM _themeVM = Get.find();

  /// Builds the root application widget.
  ///
  /// Returns a [GetMaterialApp] configured with:
  /// - Named route navigation
  /// - Light and dark theme support
  /// - Custom page transitions
  /// - Text scaling disabled for consistent UI
  ///
  /// The widget is wrapped in [Obx] to reactively update when theme changes.
  ///
  /// Returns a [Widget] representing the root of the application.
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: .noScaling),
        child: GetMaterialApp(
          title: 'Flutter Demo',
          initialRoute: AppPages.initial,
          getPages: AppRoutes.appRoutes,
          theme: AppTheme.getLightTheme(),
          darkTheme: AppTheme.getDarkTheme(),
          themeMode: _themeVM.getThemeMode,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 200),
          opaqueRoute: true,
        ),
      ),
    );
  }
}
