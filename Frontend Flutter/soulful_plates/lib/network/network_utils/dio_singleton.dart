import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../app_singleton.dart';
import '../../model/profile/user_profile.dart';
import '../network_interfaces/i_dio_singleton.dart';

///
/// DioSing().getDio(
///        baseUrl: baseUrl,
///        apiCallType: apiCallType,
///        customHeaders: customHeaders)
///
class DioSing implements IDioSing {
  static final DioSing _singleton = DioSing._internal();

  factory DioSing() {
    return _singleton;
  }

  DioSing._internal();

  @override
  // String url = 'http://192.168.1.9:8080';
  // String url = 'http://192.168.2.143:8080/api/';
  // String url = 'http://192.168.2.145:8080/api/';
  String url = 'http://172.17.2.123:8080/api/';
  // String url = 'http://localhost:8080/api';
  /// Use dio as below
  /// using the baseUrl and customHeaders
  @override
  Future<Dio> getDio(
      {String? baseUrl,
      ApiCallType? apiCallType,
      Map<String, dynamic>? customHeaders}) async {
    Map<String, dynamic> headers = <String, dynamic>{};

    switch (apiCallType) {
      case ApiCallType.simple:
        headers = <String, dynamic>{
          'Content-Type': 'application/json',
        };
        break;

      case ApiCallType.user:
        UserProfile? userModel = AppSingleton.loggedInUserProfile;
        debugPrint('This is called user model $userModel ${userModel?.id}');
        headers = <String, dynamic>{
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${userModel?.token}',
          'Authorization': 'Bearer ${userModel?.token}',
          // 'Authorization':
          //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJidXllciIsImlhdCI6MTcxMDk5MjIwMiwiZXhwIjoxNzExMDc4NjAyfQ.9YxgeNnJI5S_MSnNvzb01kkn2C30SMuTQ8YSQWqLt_Y',
        };
        break;
      case ApiCallType.seller:
        UserProfile? userModel = AppSingleton.loggedInUserProfile;
        headers = <String, dynamic>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userModel?.token}',
        };
        break;
      case ApiCallType.imageCall:
        url = '';
        headers = <String, dynamic>{};
        break;
      default:
        break;
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    var dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? url,
        connectTimeout: const Duration(seconds: 50000),
        receiveTimeout: const Duration(seconds: 50000),
        headers: headers));
    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return dio;
  }
}
