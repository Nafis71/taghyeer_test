/// Abstract repository interface for post data operations.
///
/// This interface defines the contract for post-related data access
/// in the domain layer. Implementations should be provided in the data layer.
///
/// Following Clean Architecture principles, this interface is defined in the
/// domain layer to ensure business logic remains independent of data sources.
///
/// Example implementation:
/// ```dart
/// class PostUseCase extends PostRepository {
///   @override
///   Future<Result> fetchPosts({required int limit, required int skip}) {
///     // Implementation
///   }
/// }
/// ```
import 'package:taghyeer_test/domain/result/result.dart';

abstract class PostRepository {
  /// Fetches a paginated list of posts.
  ///
  /// Retrieves posts from the data source with pagination support.
  /// The method returns a [Result] object that can be either [Success]
  /// containing the post list or [Failure] with error information.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of posts to retrieve per page
  /// - [skip]: Number of posts to skip (for pagination)
  ///
  /// Returns:
  /// - [Result] containing either:
  ///   - [Success] with a list of [PostEntity] objects
  ///   - [Failure] with error message and status code
  ///
  /// Pagination:
  /// - Use [limit] to control page size (e.g., 10, 20, 50)
  /// - Use [skip] to navigate through pages (0, limit, 2*limit, etc.)
  /// - Check response size to determine if more posts are available
  ///
  /// Example:
  /// ```dart
  /// // Fetch first page
  /// final result = await repository.fetchPosts(limit: 10, skip: 0);
  ///
  /// // Fetch second page
  /// final result2 = await repository.fetchPosts(limit: 10, skip: 10);
  ///
  /// if (result is Success) {
  ///   final posts = result.data;
  /// }
  /// ```
  Future<Result> fetchPosts({required int limit, required int skip});
}