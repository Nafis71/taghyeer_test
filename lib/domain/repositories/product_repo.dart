/// Abstract repository interface for product data operations.
///
/// This interface defines the contract for product-related data access
/// in the domain layer. Implementations should be provided in the data layer.
///
/// Following Clean Architecture principles, this interface is defined in the
/// domain layer to ensure business logic remains independent of data sources.
///
/// Example implementation:
/// ```dart
/// class ProductUseCase extends ProductRepository {
///   @override
///   Future<Result> getProducts({required int limit, required int skip}) {
///     // Implementation
///   }
/// }
/// ```
import 'package:taghyeer_test/domain/result/result.dart';

abstract class ProductRepository {
  /// Fetches a paginated list of products.
  ///
  /// Retrieves products from the data source with pagination support.
  /// The method returns a [Result] object that can be either [Success]
  /// containing the product list or [Failure] with error information.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of products to retrieve per page
  /// - [skip]: Number of products to skip (for pagination)
  ///
  /// Returns:
  /// - [Result] containing either:
  ///   - [Success] with a list of [ProductEntity] objects
  ///   - [Failure] with error message and status code
  ///
  /// Example:
  /// ```dart
  /// final result = await repository.getProducts(limit: 10, skip: 0);
  /// if (result is Success) {
  ///   final products = result.data;
  /// }
  /// ```
  Future<Result> getProducts({required int limit, required int skip});
}
