import 'package:taghyeer_test/domain/result/result.dart';

abstract class AuthRepository{
  Future<Result> loginUser(String userName, String password);
}