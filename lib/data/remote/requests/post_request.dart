/// Implementation of [ApiPostRepository] for post API requests.
///
/// This class handles post-related HTTP requests by delegating to the
/// [NetworkController]. It implements the repository interface defined
/// in the data layer.
///
/// Example:
/// ```dart
/// final request = PostRequest(networkController);
/// final response = await request.fetchPostList({
///   'limit': 10,
///   'skip': 0,
/// });
/// ```
import 'package:taghyeer_test/data/remote/config/api_endpoints.dart';
import 'package:taghyeer_test/data/remote/repositories/api_post_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

import '../controller/network_controller.dart';

class PostRequest extends ApiPostRepository {
  /// Network controller instance for making HTTP requests.
  final NetworkController _networkController;

  /// Creates a new [PostRequest] instance.
  ///
  /// Parameters:
  /// - [networkController]: Network controller for HTTP operations
  PostRequest(this._networkController);

  /// Fetches a paginated list of posts from the API.
  ///
  /// Sends a GET request to the posts endpoint with pagination parameters.
  ///
  /// Parameters:
  /// - [params]: Map containing:
  ///   - `limit`: Maximum number of posts to retrieve
  ///   - `skip`: Number of posts to skip
  ///
  /// Returns:
  /// - [ApiResponse] containing post list data
  ///
  /// Endpoint: GET /posts?limit={limit}&skip={skip}
  @override
  Future<ApiResponse<dynamic>> fetchPostList(
    Map<String, dynamic> params,
  ) async {
    return _networkController.request(
      url: ApiEndpoints.postList,
      method: Method.get,
      params: {'limit': params['limit'], 'skip': params['skip']},
    );
  }
}
