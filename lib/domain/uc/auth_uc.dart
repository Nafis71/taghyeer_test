import 'dart:convert';

import 'package:taghyeer_test/data/local/config/cache_keys.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/data/remote/models/login_m.dart';
import 'package:taghyeer_test/data/remote/repositories/api_auth_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';
import 'package:taghyeer_test/domain/entities/login_e.dart';
import 'package:taghyeer_test/domain/repositories/auth_repo.dart';
import 'package:taghyeer_test/domain/result/failure.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';

import '../../common/utils/logger/logger_util.dart';

class AuthUseCase extends AuthRepository {
  final ApiAuthRepository _apiAuthRepository;
  final StorageController _storageController = StorageController();
  final NetworkController _networkController = NetworkController();

  AuthUseCase(this._apiAuthRepository);

  @override
  Future<Result> loginUser(String userName, String password) async {
    try {
      final ApiResponse response = await _apiAuthRepository.login({
        "username": userName,
        "password": password,
        "expiresInMins": 30,
      });
      if (!response.isSuccess) {
        return Failure(
          failureMessage: response.message,
          statusCode: response.statusCode,
        );
      }
      LoginEntity loginEntity = LoginModel.fromJson(response.data);
      await _saveUserInformation(loginEntity);
      return Success();
    } catch (exception, stacktrace) {
      logger.e(exception, stackTrace: stacktrace);
    }
    return Failure(failureMessage: "Something went wrong");
  }

  Future<void> _saveUserInformation(LoginEntity loginEntity) async {
    await _storageController.write(
      key: CacheKeys.accessToken,
      value: loginEntity.accessToken,
    );
    await _storageController.write(
      key: CacheKeys.userInfo,
      value: jsonEncode((loginEntity as LoginModel).toJson()),
    );
    _networkController.setAccessToken = loginEntity.accessToken ?? "";
  }
}
