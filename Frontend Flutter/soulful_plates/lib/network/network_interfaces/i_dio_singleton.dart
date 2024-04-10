import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum ApiCallType { imageCall, simple, user, seller }

enum RequestMethod { get, put, post, delete, getPost }

/// DioSingleton interface for using the dio method for common api calls.
abstract class IDioSing {
  String url = '';

  Future<Dio> getDio(
      {String? baseUrl,
      ApiCallType? apiCallType,
      Map<String, dynamic>? customHeaders}) async {
    var dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? url,
        connectTimeout: const Duration(seconds: 50000),
        receiveTimeout: const Duration(seconds: 50000),
        headers: customHeaders));
    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return dio;
  }
}
