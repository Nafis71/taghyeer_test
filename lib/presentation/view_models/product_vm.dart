import 'package:get/get.dart';
import 'package:taghyeer_test/common/utils/logger/logger_util.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';
import 'package:taghyeer_test/domain/repositories/product_repo.dart';
import 'package:taghyeer_test/domain/result/failure.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';
import 'package:taghyeer_test/presentation/views/common_widgets/common_toast.dart';

class ProductVM extends GetxController {
  RxList<ProductEntity> productList = RxList();
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isError = false.obs;
  RxBool hasMore = true.obs;
  RxInt productDetailsImageCurrentIndex = 0.obs;
  final ProductRepository _productRepository;

  static const int _pageLimit = 10;
  int _currentSkip = 0;

  ProductVM(this._productRepository);

  Future<void> loadProductList({bool loadMore = false}) async {
    if (isLoading.value || isLoadingMore.value) return;

    if (loadMore && !hasMore.value) return;

    try {
      if (loadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        _currentSkip = 0;
        productList.clear();
        hasMore.value = true;
      }

      Result result = await _productRepository.getProducts(
        limit: _pageLimit,
        skip: _currentSkip,
      );

      if (result is Failure) {
        if (Get.context == null) return;
        CommonToast.show(
          context: Get.context!,
          title: "Failed to fetch products right now",
        );
        return;
      }
      List<ProductEntity> newProducts = (result as Success).data;
      if (newProducts.length < _pageLimit) {
        hasMore.value = false;
      }
      if (loadMore) {
        productList.addAll(newProducts);
      } else {
        productList.assignAll(newProducts);
      }
      _currentSkip += newProducts.length;
      logger.i(
        "Product list length : ${productList.length}, Skip: $_currentSkip",
      );
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    await loadProductList(loadMore: true);
  }
}
