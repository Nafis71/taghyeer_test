import 'package:taghyeer_test/data/remote/config/api_endpoints.dart';
import 'package:taghyeer_test/data/remote/repositories/api_product_repo.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

import '../controller/network_controller.dart';

class ProductRequest extends ApiProductRepository {
  final NetworkController _networkController;

  ProductRequest(this._networkController);

  @override
  Future<ApiResponse<dynamic>> fetchProductList(
    Map<String, dynamic> params,
  ) async {
    return _networkController.request(
      url: ApiEndpoints.productList,
      method: .get,
      params: {'limit': params['limit'], 'skip': params['skip']},
    );
  }
}
