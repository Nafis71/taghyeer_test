import 'package:get_storage/get_storage.dart';

import '../../../common/utils/logger/logger_util.dart';

class StorageController {
  static final StorageController _instance = StorageController._();
  static late final GetStorage _storage;

  StorageController._();

  factory StorageController() => _instance;

  Future<void> init() async {
    await GetStorage.init("taghyeer");
    _storage = GetStorage('taghyeer');
  }

  dynamic read({required String key}) {
    try {
      return _storage.read(key);
    } catch (exception) {
      logger.e('Error reading key "$key": $exception');
      return null;
    }
  }

  Future<void> write({required String key, required dynamic value}) async {
    try {
      await _storage.write(key, value);
    } catch (exception) {
      logger.e('Error writing key "$key": $exception');
    }
  }

  Future<void> clear({required String key}) async {
    try {
      await _storage.remove(key);
    } catch (exception) {
      logger.e('Error removing key "$key": $exception');
    }
  }

  Future<void> clearAll() async {
    try {
      await _storage.erase();
    } catch (exception) {
      logger.e('Error erasing the storage: $exception');
    }
  }
}
