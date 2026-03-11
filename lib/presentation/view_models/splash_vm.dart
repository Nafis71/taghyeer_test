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
  final StorageController _storageController;
  final UserVM _userVM;

  SplashVM(this._storageController, this._userVM);

  Future<void> triggerSplash() async {
    await Future.delayed(Duration(seconds: 2));
    logger.i("user logged in : ${_isUserLoggedIn()}");
    if (_isUserLoggedIn()) {
      _loadUserInfo();
      Get.offNamed(AppPages.bottomNavigation);
      return;
    }
    Get.offNamed(AppPages.login);
  }

  bool _isUserLoggedIn() {
    final String? accessToken = _storageController.read(
      key: CacheKeys.accessToken,
    );
    return !JwtDecoder.isExpired(accessToken ?? "");
  }

  void _loadUserInfo() {
    String encodedUserInfo =
        _storageController.read(key: CacheKeys.userInfo) ?? "";
    if (encodedUserInfo.isEmpty) return;
    _userVM.userInfo = LoginModel.fromJson(jsonDecode(encodedUserInfo));
  }
}
