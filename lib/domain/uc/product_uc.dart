/// Use case implementation for product-related business logic.
///
/// This class implements the [ProductRepository] interface and contains
/// the business logic for fetching products. It acts as an intermediary
/// between the presentation layer and the data layer, ensuring separation
/// of concerns.
///
/// Responsibilities:
/// - Execute product fetching operations
/// - Handle API response mapping
/// - Transform API models to domain entities
/// - Handle errors and exceptions
/// - Log operations for debugging
///
/// Example:
/// ```dart
/// final useCase = ProductUseCase(apiRepository);
/// final result = await useCase.getProducts(limit: 10, skip: 0);
/// ```
import 'package:taghyeer_test/data/remote/response/api_response.dart';
import 'package:taghyeer_test/domain/entities/product_entity_e.dart';
import 'package:taghyeer_test/domain/repositories/product_repo.dart';
import 'package:taghyeer_test/domain/result/result.dart';
import 'package:taghyeer_test/domain/result/success.dart';

import '../../common/utils/logger/logger_util.dart';
import '../../data/remote/repositories/api_product_repo.dart';
import '../result/failure.dart';

class ProductUseCase extends ProductRepository {
  /// API repository instance for fetching product data.
  ///
  /// This repository handles the actual API communication and returns
  /// raw API responses that are then transformed into domain entities.
  final ApiProductRepository _apiProductRepository;

  /// Creates a new [ProductUseCase] instance.
  ///
  /// Parameters:
  /// - [apiProductRepository]: The API repository for product data access
  ProductUseCase(this._apiProductRepository);

  /// Fetches a paginated list of products from the API.
  ///
  /// This method:
  /// 1. Calls the API repository to fetch product data
  /// 2. Validates the API response
  /// 3. Transforms API models to domain entities
  /// 4. Returns a [Result] object with success or failure
  ///
  /// Parameters:
  /// - [limit]: Maximum number of products to retrieve (default: 10)
  /// - [skip]: Number of products to skip for pagination (default: 0)
  ///
  /// Returns:
  /// - [Success] containing a list of [ProductEntity] if the operation succeeds
  /// - [Failure] with an error message if the operation fails
  ///
  /// Throws:
  /// - Logs exceptions but returns a [Failure] instead of throwing
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.getProducts(limit: 20, skip: 0);
  /// if (result is Success) {
  ///   final products = result.data as List<ProductEntity>;
  ///   print('Fetched ${products.length} products');
  /// }
  /// ```
  @override
  Future<Result> getProducts({required int limit, required int skip}) async {
    try {
      // Fetch product data from API
      ApiResponse response = await _apiProductRepository.fetchProductList({
        'limit': limit,
        'skip': skip,
      });

      // Check if API call was successful
      if (!response.isSuccess) {
        return Failure(failureMessage: response.message);
      }

      // Transform API response data to domain entities
      List<ProductEntity> productList = List.from(
        (response.data['products'] as List).map(
          (product) => ProductEntity.fromJson(product),
        ),
      );

      return Success(data: productList);
    } catch (exception, stacktrace) {
      // Log exception for debugging
      logger.e(exception, stackTrace: stacktrace);
    }

    // Return generic failure if exception occurs
    return Failure(failureMessage: "Something went wrong");
  }
}
