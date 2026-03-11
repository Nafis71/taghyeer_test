import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';

class SplashVM extends GetxController {
  Future<void> triggerSplash() async {
    await Future.delayed(Duration(seconds: 2));
    Get.offNamed(AppPages.login);
  }
}
