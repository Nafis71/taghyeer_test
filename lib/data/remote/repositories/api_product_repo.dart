import 'package:taghyeer_test/data/remote/response/api_response.dart';

abstract class ApiProductRepository{
  Future<ApiResponse> fetchProductList(Map<String,dynamic> params);
}