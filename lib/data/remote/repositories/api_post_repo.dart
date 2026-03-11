/// Abstract repository interface for post API operations.
///
/// This interface defines the contract for post-related API calls
/// in the data layer. Implementations handle the actual HTTP communication.
///
/// Example implementation:
/// ```dart
/// class PostRequest extends ApiPostRepository {
///   @override
///   Future<ApiResponse> fetchPostList(Map<String, dynamic> params) {
///     // Implementation
///   }
/// }
/// ```
import 'package:taghyeer_test/data/remote/response/api_response.dart';

abstract class ApiPostRepository {
  /// Fetches a paginated list of posts from the API.
  ///
  /// Parameters:
  /// - [params]: Map containing pagination parameters:
  ///   - `limit`: Maximum number of posts to retrieve
  ///   - `skip`: Number of posts to skip
  ///
  /// Returns:
  /// - [ApiResponse] containing either:
  ///   - Success response with post list data
  ///   - Error response with error message and status code
  ///
  /// Example:
  /// ```dart
  /// final response = await repository.fetchPostList({
  ///   'limit': 10,
  ///   'skip': 0,
  /// });
  /// ```
  Future<ApiResponse> fetchPostList(Map<String, dynamic> params);
}