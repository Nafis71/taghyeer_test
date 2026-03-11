import 'package:taghyeer_test/data/remote/config/api_endpoints.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/data/remote/repositories/api_auth_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

class AuthRequest extends ApiAuthRepository {
  final NetworkController _networkController;

  AuthRequest(this._networkController);

  @override
  Future<ApiResponse<dynamic>> login(Map<String, dynamic> params) async {
    return _networkController.request(
      url: ApiEndpoints.loginUrl,
      method: .post,
      params: params,
    );
  }
}
