import 'package:get/get.dart';
import 'package:taghyeer_test/presentation/view_models/splash_vm.dart';

import '../../../presentation/view_models/theme_vm.dart';

class DependencyInjection {
  static void init() {
    Get.put<ThemeVM>(ThemeVM(), permanent: true);
    Get.lazyPut<SplashVM>(() => SplashVM(), fenix: true);
  }
}
