import 'package:taghyeer_test/domain/result/result.dart';

class Success<T> extends Result {
  final T? data;
  Success({this.data});
}
