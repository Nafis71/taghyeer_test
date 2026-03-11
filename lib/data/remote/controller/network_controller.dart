import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:taghyeer_test/data/local/controller/storage_controller.dart';
import 'package:taghyeer_test/data/remote/response/api_response.dart';

import '../../../common/utils/logger/logger_util.dart';
import '../../local/config/cache_keys.dart';
import '../config/api_endpoints.dart';

enum Method { post, get, put, delete, patch }

class NetworkController {
  static NetworkController? _instance;

  NetworkController._internal();

  factory NetworkController() => _instance ??= NetworkController._internal();

  Dio? _dio;
  String? _accessToken;

  String? get accessToken => _accessToken;
  set setAccessToken(String accessToken) => _accessToken = accessToken;


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

  static Map<String, String> _header(String? token) {
    return {"Accept": "application/json", "Authorization": "Bearer $token"};
  }

  Future<void> _loadToken() async {
    _accessToken = StorageController().read(key: CacheKeys.accessToken);
  }

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

  static void handleDioError(DioException e) {
    logger.e(e);
  }
}
