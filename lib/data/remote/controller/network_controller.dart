import 'dart:io';

import 'package:dio/dio.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

import '../../../common/utils/logger/logger_util.dart';
import '../../local/config/cache_keys.dart';
import '../config/api_endpoints.dart';

/// HTTP method types supported by the network controller.
///
/// Used to specify the HTTP method for API requests.
enum Method {
  /// HTTP POST method for creating resources.
  post,

  /// HTTP GET method for retrieving resources.
  get,

  /// HTTP PUT method for updating resources.
  put,

  /// HTTP DELETE method for deleting resources.
  delete,

  /// HTTP PATCH method for partial updates.
  patch
}

/// Singleton network controller for managing HTTP requests.
///
/// This class provides a centralized way to handle all API communications
/// using the Dio HTTP client. It implements the Singleton pattern to ensure
/// a single instance manages all network operations throughout the app.
///
/// Features:
/// - Automatic token injection in request headers
/// - Request/response logging
/// - Error handling and status code mapping
/// - Timeout configuration
/// - Interceptor support for request/response modification
///
/// The controller automatically:
/// - Adds Bearer token authentication to requests
/// - Logs all requests and responses for debugging
/// - Handles common HTTP status codes (200, 201, 400, 401, 404, 500)
/// - Manages connection timeouts
///
/// Example:
/// ```dart
/// final controller = NetworkController();
/// await controller.init();
/// final response = await controller.request(
///   url: '/api/products',
///   method: Method.get,
///   params: {'limit': 10},
/// );
/// ```

class NetworkController {
  /// Singleton instance of [NetworkController].
  ///
  /// Used to maintain a single instance throughout the application lifecycle.
  static NetworkController? _instance;

  /// Private constructor for singleton pattern.
  NetworkController._internal();

  /// Factory constructor that returns the singleton instance.
  ///
  /// Creates a new instance only if one doesn't exist, otherwise returns
  /// the existing instance.
  factory NetworkController() => _instance ??= NetworkController._internal();

  /// Dio HTTP client instance for making requests.
  ///
  /// Initialized in [init] method with base configuration.
  Dio? _dio;

  /// Access token for authenticated requests.
  ///
  /// Loaded from local storage and automatically injected into request headers.
  String? _accessToken;

  /// Gets the current access token.
  ///
  /// Returns null if no token is set.
  String? get accessToken => _accessToken;

  /// Sets the access token for authenticated requests.
  ///
  /// The token will be automatically included in subsequent request headers.
  set setAccessToken(String accessToken) => _accessToken = accessToken;


  /// Initializes the network controller.
  ///
  /// Sets up the Dio client with base configuration including:
  /// - Base URL from [ApiEndpoints]
  /// - Timeout settings (10 seconds for connect, receive, send)
  /// - Status code validation
  /// - Request/response interceptors
  /// - Access token loading from storage
  ///
  /// This method must be called before making any network requests.
  ///
  /// Throws [Exception] if initialization fails.
  Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    _initInterceptors();
    await _loadToken();
  }

  /// Creates HTTP headers with authentication token.
  ///
  /// Parameters:
  /// - [token]: Bearer token for authentication (can be null)
  ///
  /// Returns a [Map] containing Accept and Authorization headers.
  static Map<String, String> _header(String? token) {
    return {"Accept": "application/json", "Authorization": "Bearer $token"};
  }

  /// Loads the access token from local storage.
  ///
  /// Retrieves the stored token and sets it for use in authenticated requests.
  Future<void> _loadToken() async {
    _accessToken = StorageController().read(key: CacheKeys.accessToken);
  }

  /// Initializes Dio interceptors for logging and request modification.
  ///
  /// Sets up interceptors to:
  /// - Log all outgoing requests with method, path, parameters, and headers
  /// - Log all incoming responses with status code and data
  /// - Log errors with status codes
  ///
  /// Interceptors are useful for debugging and monitoring network activity.
  void _initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOption, handler) {
          logger.i(
            "REQUEST[${requestOption.method}] => RESPONSE: ${requestOption.path}"
            "=> REQUEST VALUES: ${requestOption.queryParameters} => HEADERS: ${requestOption.headers}",
          );
          return handler.next(requestOption);
        },
        onError: (error, handler) {
          logger.i("Error[${error.response?.statusCode}]");
          return handler.next(error);
        },
        onResponse: (response, handler) {
          logger.i(
            "RESPONSE[${response.statusCode}] => DATA: ${response.data}",
          );
          return handler.next(response);
        },
      ),
    );
  }

  /// Performs an HTTP request and returns a standardized response.
  ///
  /// This method handles the complete request lifecycle including:
  /// - Request execution with appropriate HTTP method
  /// - Error handling for network and format errors
  /// - Status code mapping to user-friendly messages
  /// - Response wrapping in [ApiResponse]
  ///
  /// Parameters:
  /// - [url]: Endpoint URL (relative to base URL)
  /// - [method]: HTTP method to use ([Method.get], [Method.post], etc.)
  /// - [params]: Optional query parameters (GET) or request body (POST/PUT/PATCH)
  /// - [responseType]: Optional response type (defaults to JSON)
  ///
  /// Returns:
  /// - [ApiResponse.success] for successful requests (200, 201)
  /// - [ApiResponse.error] for failed requests with appropriate error message
  ///
  /// Status code handling:
  /// - 200, 201: Success
  /// - 400: Bad request
  /// - 401: Unauthenticated
  /// - 404: Not found
  /// - 500: Server error
  /// - 600: No internet connection (custom code)
  ///
  /// Throws:
  /// - [FormatException] for malformed responses
  /// - [Exception] for unexpected errors
  ///
  /// Example:
  /// ```dart
  /// final response = await controller.request(
  ///   url: '/api/products',
  ///   method: Method.get,
  ///   params: {'limit': 10, 'skip': 0},
  /// );
  /// if (response.isSuccess) {
  ///   final data = response.data;
  /// }
  /// ```
  Future<ApiResponse> request({
    required String url,
    required Method method,
    Map<String, dynamic>? params,
    ResponseType? responseType,
  }) async {
    try {
      logger.i("Params: $params}");
      final response = await _performHttpRequest({
        'url': url,
        'method': method,
        'params': params,
        'responseType': responseType,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(data: response.data);
      }
      if (response.statusCode == 401) {
        return ApiResponse.error(
          message: "User is unauthenticated",
          statusCode: response.statusCode,
        );
      }
      if (response.statusCode == 400) {
        return ApiResponse.error(
          message: "Bad request",
          statusCode: response.statusCode,
        );
      }
      if (response.statusCode == 404) {
        return ApiResponse.error(
          statusCode: response.statusCode,
          message: "Content not found",
        );
      }
      if (response.statusCode == 500) {
        return ApiResponse.error(
          message: "Server error",
          statusCode: response.statusCode,
        );
      }
      return ApiResponse.error(
        message: "Something went wrong",
        statusCode: 400,
      );
    } on SocketException catch (exception) {
      logger.e(exception);
      return ApiResponse.error(
        message: "No internet connection",
        statusCode: 600,
      );
    } on FormatException catch (exception) {
      logger.e(exception);
      throw Exception("Bad response format");
    } catch (exception, stackTrace) {
      logger.e(exception, stackTrace: stackTrace);
      throw Exception("Something went wrong");
    }
  }

  /// Performs the actual HTTP request using Dio.
  ///
  /// This private method executes the HTTP request based on the specified method
  /// and parameters. It handles different HTTP methods appropriately:
  /// - GET: Uses queryParameters
  /// - POST/PUT/PATCH: Uses request body (data)
  /// - DELETE: No body or parameters
  ///
  /// Parameters:
  /// - [data]: Map containing url, method, params, and responseType
  ///
  /// Returns:
  /// - [Response] object from Dio containing the HTTP response
  ///
  /// Throws:
  /// - [DioException] for Dio-specific errors
  /// - [Exception] for other errors
  Future<Response> _performHttpRequest(Map<String, dynamic> data) async {
    final url = data['url'];
    final method = data['method'];
    final params = data['params'];
    final responseType = data['responseType'];
    try {
      Response response;
      logger.i("is dio null? : ${_dio == null}");
      switch (method) {
        case Method.post:
          response = await _dio!.post(
            url,
            data: params,
            options: Options(
              contentType: "application/json",
              headers: _header(_accessToken),
            ),
          );
          break;
        case Method.delete:
          response = await _dio!.delete(
            url,
            options: Options(
              contentType: "application/json",
              headers: _header(_accessToken),
            ),
          );
          break;
        case Method.patch:
          response = await _dio!.patch(
            url,
            data: params,
            options: Options(
              contentType: "application/json",
              headers: _header(_accessToken),
            ),
          );
          break;
        default:
          response = await _dio!.get(
            url,
            queryParameters: params,
            options: Options(
              headers: {"Authorization": "Bearer $_accessToken"},
              responseType: responseType,
              contentType: "application/json",
            ),
          );
          break;
      }
      return response;
    } on DioException catch (e) {
      handleDioError(e);
      throw Exception("Exception from performHTTPCallback :$e");
    }
  }

  /// Handles Dio-specific errors.
  ///
  /// Logs the error for debugging purposes. Can be extended to handle
  /// specific error types or trigger error reporting.
  ///
  /// Parameters:
  /// - [e]: The [DioException] that occurred
  static void handleDioError(DioException e) {
    logger.e(e);
  }
}
