/// Represents a successful operation result.
///
/// This class is used to wrap successful operation results along with
/// optional data. It extends [Result] and indicates that an operation
/// completed successfully.
///
/// The [data] field can contain any type of data returned from the operation,
/// or be null if the operation succeeded but returned no data.
///
/// Example:
/// ```dart
/// final result = Success(data: productList);
/// if (result is Success) {
///   final products = result.data;
/// }
/// ```
///
/// Type parameter:
/// - [T]: The type of data contained in this success result
import 'package:taghyeer_test/domain/result/result.dart';

class Success<T> extends Result {
  /// Optional data returned from the successful operation.
  ///
  /// Can be null if the operation succeeded but returned no data.
  final T? data;

  /// Creates a new [Success] instance.
  ///
  /// Parameters:
  /// - [data]: Optional data returned from the operation
  Success({this.data});
}
