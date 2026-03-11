import 'package:taghyeer_test/data/remote/response/api_response.dart';

abstract class ApiAuthRepository{
  Future<ApiResponse> login(Map<String,dynamic> params);
}
