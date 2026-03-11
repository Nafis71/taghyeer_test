import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/routing/app_pages.dart';
import 'package:taghyeer_test/domain/repositories/auth_repo.dart';
import 'package:taghyeer_test/domain/result/failure.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_toast.dart';

import '../../common/utils/logger/logger_util.dart';

class AuthVM extends GetxController{
  final AuthRepository _authRepository;
  RxBool isBusy = false.obs;

  AuthVM(this._authRepository);


  Future<void> initiateUserLogin(String userName, String password)async{
    if(Get.context == null) return;
    if(userName.isEmpty || password.isEmpty){
      return CommonToast.show(context: Get.context!, title: "User name or password cannot be empty");
    }
    if(isBusy.value) return;
    try{
      isBusy.value = true;
      final Result result = await _authRepository.loginUser(userName, password);
      if(result is Failure){
        CommonToast.show(context: Get.context!, title: result.failureMessage!);
        return;
      }
      Get.offAllNamed(AppPages.bottomNavigation);
    }catch(exception, stacktrace){
      logger.e(exception, stackTrace: stacktrace);
    } finally{
      isBusy.value = false;
    }
  }


}