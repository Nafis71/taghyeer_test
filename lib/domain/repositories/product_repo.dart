import 'package:taghyeer_test/domain/result/result.dart';

abstract class ProductRepository {
  Future<Result> getProducts({required int limit, required int skip});
}
