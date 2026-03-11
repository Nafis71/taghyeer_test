/// View model for managing product list state and operations.
///
/// This class extends [GetxController] and manages the state of product-related
/// UI components. It handles product fetching, pagination, and loading states.
///
/// Responsibilities:
/// - Manage product list state
/// - Handle pagination logic
/// - Control loading indicators
/// - Track current image index for product details carousel
/// - Handle error states and user feedback
///
/// The view model uses reactive programming with GetX observables to automatically
/// update the UI when state changes.
///
/// Example:
/// ```dart
/// final productVM = Get.find<ProductVM>();
/// await productVM.loadProductList();
/// ```
import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/logger/logger_util.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';
import 'package:taghyeer_test/domain/repositories/product_repo.dart';
import 'package:taghyeer_test/domain/result/failure.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_toast.dart';

class ProductVM extends GetxController {
  /// Reactive list of products currently loaded.
  ///
  /// Automatically updates UI when products are added or removed.
  RxList<ProductEntity> productList = RxList();

  /// Indicates whether the initial product list is being loaded.
  ///
  /// Set to true when fetching the first page of products.
  RxBool isLoading = false.obs;

  /// Indicates whether more products are being loaded (pagination).
  ///
  /// Set to true when fetching additional pages of products.
  RxBool isLoadingMore = false.obs;

  /// Indicates whether more products are available to load.
  ///
  /// Set to false when the last page of products has been loaded.
  RxBool hasMore = true.obs;

  /// Current index of the image being displayed in product details carousel.
  ///
  /// Used to track which image is currently visible when viewing product details.
  RxInt productDetailsImageCurrentIndex = 0.obs;

  /// Repository instance for fetching product data.
  ///
  /// Used to communicate with the domain layer to retrieve products.
  final ProductRepository _productRepository;

  /// Maximum number of products to fetch per page.
  ///
  /// Used for pagination to limit the number of items per API request.
  static const int _pageLimit = 10;

  /// Current pagination offset.
  ///
  /// Tracks how many products have been skipped for pagination.
  int _currentSkip = 0;

  /// Creates a new [ProductVM] instance.
  ///
  /// Parameters:
  /// - [productRepository]: Repository for product data operations
  ProductVM(this._productRepository);

  /// Loads products from the repository.
  ///
  /// Fetches products either as a fresh load or as pagination (load more).
  /// Handles loading states, error states, and updates the product list accordingly.
  ///
  /// The method prevents concurrent requests and checks if more products
  /// are available before attempting to load more.
  ///
  /// Parameters:
  /// - [loadMore]: If true, appends products to existing list (pagination).
  ///                If false, replaces the list with new products (refresh).
  ///
  /// Behavior:
  /// - Returns early if a request is already in progress
  /// - Returns early if loading more but no more products available
  /// - Shows error toast if the request fails
  /// - Updates pagination state based on response size
  /// - Logs operations for debugging
  ///
  /// Example:
  /// ```dart
  /// // Load initial products
  /// await productVM.loadProductList();
  ///
  /// // Load more products (pagination)
  /// await productVM.loadProductList(loadMore: true);
  /// ```
  Future<void> loadProductList({bool loadMore = false}) async {
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
        productList.clear();
        hasMore.value = true;
      }

      // Fetch products from repository
      Result result = await _productRepository.getProducts(
        limit: _pageLimit,
        skip: _currentSkip,
      );

      // Handle failure case
      if (result is Failure) {
        if (Get.context == null) return;
        CommonToast.show(
          context: Get.context!,
          title: "Failed to fetch products right now",
        );
        return;
      }

      // Extract products from success result
      List<ProductEntity> newProducts = (result as Success).data;

      // Check if we've reached the end of the list
      if (newProducts.length < _pageLimit) {
        hasMore.value = false;
      }

      // Update product list based on load type
      if (loadMore) {
        productList.addAll(newProducts);
      } else {
        productList.assignAll(newProducts);
      }

      // Update pagination offset
      _currentSkip += newProducts.length;

      // Log operation for debugging
      logger.i(
        "Product list length : ${productList.length}, Skip: $_currentSkip",
      );
    } catch (exception, stackTrace) {
      // Log exceptions for debugging
      logger.e(exception, stackTrace: stackTrace);
    } finally {
      // Always reset loading states
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  /// Convenience method to load more products (pagination).
  ///
  /// This is a shorthand for calling [loadProductList] with [loadMore] set to true.
  ///
  /// Example:
  /// ```dart
  /// await productVM.loadMoreProducts();
  /// ```
  Future<void> loadMoreProducts() async {
    await loadProductList(loadMore: true);
  }
}
