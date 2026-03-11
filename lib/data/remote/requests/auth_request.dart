/// Implementation of [ApiAuthRepository] for authentication API requests.
///
/// This class handles authentication-related HTTP requests by delegating
/// to the [NetworkController]. It implements the repository interface
/// defined in the data layer.
///
/// Example:
/// ```dart
/// final request = AuthRequest(networkController);
/// final response = await request.login({
///   'username': 'emilys',
///   'password': 'emilyspass',
/// });
/// ```
import 'package:taghyeer_test/data/remote/config/api_endpoints.dart';
import 'package:taghyeer_test/data/remote/controller/network_controller.dart';
import 'package:taghyeer_test/data/remote/repositories/api_auth_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

class AuthRequest extends ApiAuthRepository {
  /// Network controller instance for making HTTP requests.
  final NetworkController _networkController;

  /// Creates a new [AuthRequest] instance.
  ///
  /// Parameters:
  /// - [networkController]: Network controller for HTTP operations
  AuthRequest(this._networkController);

  /// Performs user login API request.
  ///
  /// Sends a POST request to the login endpoint with user credentials.
  ///
  /// Parameters:
  /// - [params]: Map containing:
  ///   - `username`: User's username or email
  ///   - `password`: User's password
  ///   - `expiresInMins`: Token expiration time (optional, default: 30)
  ///
  /// Returns:
  /// - [ApiResponse] containing login response with user data and tokens
  ///
  /// Endpoint: POST /auth/login
  @override
  Future<ApiResponse<dynamic>> login(Map<String, dynamic> params) async {
    return _networkController.request(
      url: ApiEndpoints.loginUrl,
      method: Method.post,
      params: params,
    );
  }
}
