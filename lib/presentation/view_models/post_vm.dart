/// View model for managing post list state and operations.
///
/// This class extends [GetxController] and manages the state of post-related
/// UI components. It handles post fetching, pagination, and loading states.
///
/// Responsibilities:
/// - Manage post list state
/// - Handle pagination logic
/// - Control loading indicators
/// - Track current image index for post details carousel
/// - Handle error states and user feedback
///
/// The view model uses reactive programming with GetX observables to automatically
/// update the UI when state changes.
///
/// Example:
/// ```dart
/// final postVM = Get.find<PostVM>();
/// await postVM.loadPostList();
/// ```
import 'package:get/get.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';
import 'package:taghyeer_test/domain/repositories/post_repo.dart';

import '../../common/utils/logger/logger_util.dart';
import '../../domain/result/failure.dart';
import '../../domain/result/result.dart';
import '../../domain/result/success.dart';
import '../views/common_widgets/common_toast.dart';

class PostVM extends GetxController {
  /// Reactive list of posts currently loaded.
  ///
  /// Automatically updates UI when posts are added or removed.
  RxList<PostEntity> postList = RxList();

  /// Indicates whether the initial post list is being loaded.
  ///
  /// Set to true when fetching the first page of posts.
  RxBool isLoading = false.obs;

  /// Indicates whether more posts are being loaded (pagination).
  ///
  /// Set to true when fetching additional pages of posts.
  RxBool isLoadingMore = false.obs;

  /// Indicates whether more posts are available to load.
  ///
  /// Set to false when the last page of posts has been loaded.
  RxBool hasMore = true.obs;

  /// Current index of the image being displayed in post details carousel.
  ///
  /// Used to track which image is currently visible when viewing post details.
  /// Note: This property name references "productDetails" but is used for posts.
  RxInt productDetailsImageCurrentIndex = 0.obs;

  /// Repository instance for fetching post data.
  ///
  /// Used to communicate with the domain layer to retrieve posts.
  final PostRepository _postRepository;

  /// Maximum number of posts to fetch per page.
  ///
  /// Used for pagination to limit the number of items per API request.
  static const int _pageLimit = 10;

  /// Current pagination offset.
  ///
  /// Tracks how many posts have been skipped for pagination.
  int _currentSkip = 0;

  /// Creates a new [PostVM] instance.
  ///
  /// Parameters:
  /// - [postRepository]: Repository for post data operations
  PostVM(this._postRepository);

  /// Loads posts from the repository.
  ///
  /// Fetches posts either as a fresh load or as pagination (load more).
  /// Handles loading states, error states, and updates the post list accordingly.
  ///
  /// The method prevents concurrent requests and checks if more posts
  /// are available before attempting to load more.
  ///
  /// Parameters:
  /// - [loadMore]: If true, appends posts to existing list (pagination).
  ///                If false, replaces the list with new posts (refresh).
  ///
  /// Behavior:
  /// - Returns early if a request is already in progress
  /// - Returns early if loading more but no more posts available
  /// - Shows error toast if the request fails
  /// - Updates pagination state based on response size
  /// - Logs operations for debugging
  ///
  /// Example:
  /// ```dart
  /// // Load initial posts
  /// await postVM.loadPostList();
  ///
  /// // Load more posts (pagination)
  /// await postVM.loadPostList(loadMore: true);
  /// ```
  Future<void> loadPostList({bool loadMore = false}) async {
    // Prevent multiple simultaneous requests
    if (isLoading.value || isLoadingMore.value) return;

    // Check if there are more items to load
    if (loadMore && !hasMore.value) return;

    try {
      // Set appropriate loading state
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        _currentSkip = 0;
        postList.clear();
        hasMore.value = true;
      }

      // Fetch posts from repository
      Result result = await _postRepository.fetchPosts(
        limit: _pageLimit,
        skip: _currentSkip,
      );

      // Handle failure case
      if (result is Failure) {
        if (Get.context == null) return;
        CommonToast.show(
          context: Get.context!,
          title: "Failed to fetch posts right now",
        );
        return;
      }

      // Extract posts from success result
      List<PostEntity> newPosts = (result as Success).data;

      // Check if we've reached the end of the list
      if (newPosts.length < _pageLimit) {
        hasMore.value = false;
      }

      // Update post list based on load type
      if (loadMore) {
        postList.addAll(newPosts);
      } else {
        postList.assignAll(newPosts);
      }

      // Update pagination offset
      _currentSkip += newPosts.length;

      // Log operation for debugging
      logger.i("Post list length : ${postList.length}, Skip: $_currentSkip");
    } catch (exception, stackTrace) {
      // Log exceptions for debugging
      logger.e(exception, stackTrace: stackTrace);
    } finally {
      // Always reset loading states
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  /// Convenience method to load more posts (pagination).
  ///
  /// This is a shorthand for calling [loadPostList] with [loadMore] set to true.
  ///
  /// Example:
  /// ```dart
  /// await postVM.loadMorePosts();
  /// ```
  Future<void> loadMorePosts() async {
    await loadPostList(loadMore: true);
  }
}
