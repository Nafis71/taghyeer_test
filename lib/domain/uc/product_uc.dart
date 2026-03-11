import 'package:taghyeer_test/data/remote/response/api_response.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';
import 'package:taghyeer_test/domain/repositories/product_repo.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';

import '../../common/utils/logger/logger_util.dart';
import '../../data/remote/repositories/api_product_repo.dart';
import '../result/failure.dart';

class ProductUseCase extends ProductRepository {
  final ApiProductRepository _apiProductRepository;

  ProductUseCase(this._apiProductRepository);

  @override
  Future<Result> getProducts({required int limit, required int skip}) async {
    try {
      ApiResponse response = await _apiProductRepository.fetchProductList({
        'limit': limit,
        'skip': skip,
      });
      if (!response.isSuccess) {
        return Failure(failureMessage: response.message);
      }
      List<ProductEntity> productList = List.from(
        (response.data['products'] as List).map(
          (product) => ProductEntity.fromJson(product),
        ),
      );
      return Success(data: productList);
    } catch (exception, stacktrace) {
      logger.e(exception, stackTrace: stacktrace);
    }
    return Failure(failureMessage: "Something went wrong");
  }
}
