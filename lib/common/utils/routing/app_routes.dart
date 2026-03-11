import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/presentation/views/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:taghyeer_test/presentation/views/login/views/login_v.dart';
import 'package:taghyeer_test/presentation/views/product_details/views/product_details_v.dart';
import 'package:taghyeer_test/presentation/views/splash/views/splash_v.dart';

class AppRoutes {
  static List<GetPage> appRoutes = [
    GetPage(name: AppPages.initial, page: () => Splash()),
    GetPage(name: AppPages.login, page: () => Login()),
    GetPage(name: AppPages.bottomNavigation, page: () => BottomNavBar()),
    GetPage(name: AppPages.productDetails, page: () => ProductDetails()),
  ];
}
