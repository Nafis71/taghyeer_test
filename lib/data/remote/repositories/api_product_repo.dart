/// Abstract repository interface for product API operations.
///
/// This interface defines the contract for product-related API calls
/// in the data layer. Implementations handle the actual HTTP communication.
///
/// Example implementation:
/// ```dart
/// class ProductRequest extends ApiProductRepository {
///   @override
///   Future<ApiResponse> fetchProductList(Map<String, dynamic> params) {
///     // Implementation
///   }
/// }
/// ```
import 'package:taghyeer_test/data/remote/response/api_response.dart';

abstract class ApiProductRepository {
  /// Fetches a paginated list of products from the API.
  ///
  /// Parameters:
  /// - [params]: Map containing pagination parameters:
  ///   - `limit`: Maximum number of products to retrieve
  ///   - `skip`: Number of products to skip
  ///
  /// Returns:
  /// - [ApiResponse] containing either:
  ///   - Success response with product list data
  ///   - Error response with error message and status code
  ///
  /// Example:
  /// ```dart
  /// final response = await repository.fetchProductList({
  ///   'limit': 10,
  ///   'skip': 0,
  /// });
  /// ```
  Future<ApiResponse> fetchProductList(Map<String, dynamic> params);
}