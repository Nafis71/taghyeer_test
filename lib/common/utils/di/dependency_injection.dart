import 'package:get/get.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/data/remote/requests/auth_request.dart';
import 'package:taghyeer_test/domain/uc/auth_uc.dart';
import 'package:taghyeer_test/domain/uc/product_uc.dart';
import 'package:taghyeer_test/presentation/view_models/auth_vm.dart';
import 'package:taghyeer_test/presentation/view_models/product_vm.dart';
import 'package:taghyeer_test/presentation/view_models/splash_vm.dart';
import 'package:taghyeer_test/presentation/view_models/user_vm.dart';

import '../../../data/remote/requests/product_request.dart';
import '../../../presentation/view_models/bottom_navigation_vm.dart';
import '../../../presentation/view_models/theme_vm.dart';

class DependencyInjection {
  static void init() {
    NetworkController networkController = NetworkController();
    Get.put<ThemeVM>(ThemeVM(), permanent: true);
    Get.put<AuthVM>(
      AuthVM(AuthUseCase(AuthRequest(networkController))),
      permanent: true,
    );
    Get.put<UserVM>(UserVM(), permanent: true);
    Get.lazyPut<SplashVM>(
      () => SplashVM(StorageController(), Get.find<UserVM>()),
      fenix: true,
    );
    Get.lazyPut<BottomNavigationVM>(() => BottomNavigationVM(), fenix: true);
    Get.lazyPut<ProductVM>(
      () => ProductVM(ProductUseCase(ProductRequest(networkController))),
      fenix: true,
    );
  }
}
