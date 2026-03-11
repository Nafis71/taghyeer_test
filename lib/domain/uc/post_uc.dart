/// Use case implementation for post-related business logic.
///
/// This class implements the [PostRepository] interface and contains
/// the business logic for fetching posts. It acts as an intermediary
/// between the presentation layer and the data layer, ensuring separation
/// of concerns.
///
/// Responsibilities:
/// - Execute post fetching operations
/// - Handle API response mapping
/// - Transform API models to domain entities
/// - Handle errors and exceptions
/// - Log operations for debugging
///
/// Example:
/// ```dart
/// final useCase = PostUseCase(apiRepository);
/// final result = await useCase.fetchPosts(limit: 10, skip: 0);
/// ```
import 'package:taghyeer_test/data/remote/models/post_m.dart';
import 'package:taghyeer_test/data/remote/repositories/api_post_repo.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';
import 'package:taghyeer_test/domain/repositories/post_repo.dart';
import 'package:taghyeer_test/domain/result/result.dart';

import '../../common/utils/logger/logger_util.dart';
import '../../data/remote/response/api_response.dart';
import '../result/failure.dart';
import '../result/success.dart';

class PostUseCase extends PostRepository {
  /// API repository instance for fetching post data.
  ///
  /// This repository handles the actual API communication and returns
  /// raw API responses that are then transformed into domain entities.
  final ApiPostRepository _apiPostRepository;

  /// Creates a new [PostUseCase] instance.
  ///
  /// Parameters:
  /// - [apiPostRepository]: The API repository for post data access
  PostUseCase(this._apiPostRepository);

  /// Fetches a paginated list of posts from the API.
  ///
  /// This method:
  /// 1. Calls the API repository to fetch post data
  /// 2. Validates the API response
  /// 3. Transforms API models to domain entities
  /// 4. Returns a [Result] object with success or failure
  ///
  /// Parameters:
  /// - [limit]: Maximum number of posts to retrieve (default: 10)
  /// - [skip]: Number of posts to skip for pagination (default: 0)
  ///
  /// Returns:
  /// - [Success] containing a list of [PostEntity] if the operation succeeds
  /// - [Failure] with an error message if the operation fails
  ///
  /// Throws:
  /// - Logs exceptions but returns a [Failure] instead of throwing
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.fetchPosts(limit: 20, skip: 0);
  /// if (result is Success) {
  ///   final posts = result.data as List<PostEntity>;
  ///   print('Fetched ${posts.length} posts');
  /// }
  /// ```
  @override
  Future<Result<dynamic>> fetchPosts({required int limit, required int skip}) async {
    try {
      // Fetch post data from API
      ApiResponse response = await _apiPostRepository.fetchPostList({
        'limit': limit,
        'skip': skip,
      });

      // Check if API call was successful
      if (!response.isSuccess) {
        return Failure(failureMessage: response.message);
      }

      // Transform API response data to domain entities
      List<PostEntity> postList = List.from(
        (response.data['posts'] as List).map(
          (post) => PostModel.fromJson(post),
        ),
      );

      return Success(data: postList);
    } catch (exception, stacktrace) {
      // Log exception for debugging
      logger.e(exception, stackTrace: stacktrace);
    }

    // Return generic failure if exception occurs
    return Failure(failureMessage: "Something went wrong");
  }
}