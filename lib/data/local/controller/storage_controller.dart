/// Singleton controller for managing local storage operations.
///
/// This class provides a centralized interface for reading and writing data
/// to local storage using GetStorage. It implements the Singleton pattern
/// to ensure a single instance manages all storage operations.
///
/// Features:
/// - Thread-safe storage operations
/// - Error handling with logging
/// - Key-value storage interface
/// - Support for any serializable data type
///
/// Storage bucket: "taghyeer"
///
/// Example:
/// ```dart
/// final storage = StorageController();
/// await storage.init();
/// await storage.write(key: 'userName', value: 'john');
/// final userName = storage.read(key: 'userName');
/// ```
import 'package:get_storage/get_storage.dart';

import '../../../common/utils/logger/logger_util.dart';

class StorageController {
  /// Singleton instance of [StorageController].
  static final StorageController _instance = StorageController._();

  /// GetStorage instance for actual storage operations.
  ///
  /// Initialized in [init] method with the storage bucket name.
  static late final GetStorage _storage;

  /// Private constructor for singleton pattern.
  StorageController._();

  /// Factory constructor that returns the singleton instance.
  factory StorageController() => _instance;

  /// Initializes the storage controller with the storage bucket.
  ///
  /// This method must be called before using any storage operations.
  /// It initializes GetStorage with the bucket name "taghyeer".
  ///
  /// Throws [Exception] if initialization fails.
  Future<void> init() async {
    await GetStorage.init("taghyeer");
    _storage = GetStorage('taghyeer');
  }

  /// Reads a value from storage by key.
  ///
  /// Parameters:
  /// - [key]: The storage key to read
  ///
  /// Returns:
  /// - The stored value if found, or `null` if key doesn't exist or error occurs
  ///
  /// Example:
  /// ```dart
  /// final token = storage.read(key: CacheKeys.accessToken);
  /// ```
  dynamic read({required String key}) {
    try {
      return _storage.read(key);
    } catch (exception) {
      logger.e('Error reading key "$key": $exception');
      return null;
    }
  }

  /// Writes a value to storage with the given key.
  ///
  /// Parameters:
  /// - [key]: The storage key
  /// - [value]: The value to store (can be any serializable type)
  ///
  /// The operation is asynchronous and handles errors gracefully.
  ///
  /// Example:
  /// ```dart
  /// await storage.write(key: CacheKeys.accessToken, value: token);
  /// ```
  Future<void> write({required String key, required dynamic value}) async {
    try {
      await _storage.write(key, value);
    } catch (exception) {
      logger.e('Error writing key "$key": $exception');
    }
  }

  /// Removes a value from storage by key.
  ///
  /// Parameters:
  /// - [key]: The storage key to remove
  ///
  /// Example:
  /// ```dart
  /// await storage.clear(key: CacheKeys.accessToken);
  /// ```
  Future<void> clear({required String key}) async {
    try {
      await _storage.remove(key);
    } catch (exception) {
      logger.e('Error removing key "$key": $exception');
    }
  }

  /// Clears all data from storage.
  ///
  /// **Warning**: This will remove all stored data including user information
  /// and authentication tokens. Use with caution.
  ///
  /// Example:
  /// ```dart
  /// await storage.clearAll();
  /// ```
  Future<void> clearAll() async {
    try {
      await _storage.erase();
    } catch (exception) {
      logger.e('Error erasing the storage: $exception');
    }
  }
}
