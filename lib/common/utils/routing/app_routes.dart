/// Application routing configuration.
///
/// This class defines all routes available in the application using GetX routing.
/// Each route is mapped to a corresponding widget/page that will be displayed
/// when navigating to that route.
///
/// Routes are defined as a list of [GetPage] objects, each containing:
/// - Route name (from [AppPages])
/// - Page builder function that returns the widget
///
/// The routes are registered with GetMaterialApp in the main.dart file.
///
/// Route order:
/// 1. Initial route (splash)
/// 2. Authentication routes
/// 3. Main app routes
/// 4. Detail screens
///
/// Example:
/// ```dart
/// // Navigate to product details
/// Get.toNamed(AppPages.productDetails, arguments: {'product': product});
///
/// // Navigate to login
/// Get.offAllNamed(AppPages.login);
/// ```
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/presentation/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:taghyeer_test/presentation/views/login/views/login_v.dart';
import 'package:taghyeer_test/presentation/views/post_details/views/post_details_v.dart';
import 'package:taghyeer_test/presentation/views/product_details/views/product_details_v.dart';
import 'package:taghyeer_test/presentation/views/splash/views/splash_v.dart';

class AppRoutes {
  /// List of all application routes.
  ///
  /// This list is used by GetMaterialApp to configure navigation.
  /// Routes are evaluated in order, so the initial route should be first.
  ///
  /// Each route can accept arguments via GetX navigation:
  /// ```dart
  /// Get.toNamed(AppPages.productDetails, arguments: {'product': product});
  /// ```
  static List<GetPage> appRoutes = [
    GetPage(name: AppPages.initial, page: () => Splash()),
    GetPage(name: AppPages.login, page: () => Login()),
    GetPage(name: AppPages.bottomNavigation, page: () => BottomNavBar()),
    GetPage(name: AppPages.productDetails, page: () => ProductDetails()),
    GetPage(name: AppPages.postDetails, page: () => PostDetails()),
  ];
}
