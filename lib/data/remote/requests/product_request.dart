/// Implementation of [ApiProductRepository] for product API requests.
///
/// This class handles product-related HTTP requests by delegating to the
/// [NetworkController]. It implements the repository interface defined
/// in the data layer.
///
/// Example:
/// ```dart
/// final request = ProductRequest(networkController);
/// final response = await request.fetchProductList({
///   'limit': 10,
///   'skip': 0,
/// });
/// ```
import 'package:taghyeer_test/data/remote/config/api_endpoints.dart';
import 'package:taghyeer_test/data/remote/repositories/api_product_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

import '../controller/network_controller.dart';

class ProductRequest extends ApiProductRepository {
  /// Network controller instance for making HTTP requests.
  final NetworkController _networkController;

  /// Creates a new [ProductRequest] instance.
  ///
  /// Parameters:
  /// - [networkController]: Network controller for HTTP operations
  ProductRequest(this._networkController);

  /// Fetches a paginated list of products from the API.
  ///
  /// Sends a GET request to the products endpoint with pagination parameters.
  ///
  /// Parameters:
  /// - [params]: Map containing:
  ///   - `limit`: Maximum number of products to retrieve
  ///   - `skip`: Number of products to skip
  ///
  /// Returns:
  /// - [ApiResponse] containing product list data
  ///
  /// Endpoint: GET /products?limit={limit}&skip={skip}
  @override
  Future<ApiResponse<dynamic>> fetchProductList(
    Map<String, dynamic> params,
  ) async {
    return _networkController.request(
      url: ApiEndpoints.productList,
      method: Method.get,
      params: {'limit': params['limit'], 'skip': params['skip']},
    );
  }
}
