import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:soulful_plates/constants/language/language_constants.dart';

import '../network_interfaces/base_response.dart';
import '../network_interfaces/end_points.dart';
import '../network_interfaces/i_dio_singleton.dart';
import '../network_interfaces/i_net_call.dart';
import 'dio_singleton.dart';

class NetworkCallDio implements INetCall {
  Future<Dio>? dio;

  NetworkCallDio(
      {String? baseUrl,
      ApiCallType? apiCallType,
      Map<String, dynamic>? customHeaders}) {
    dio = DioSing().getDio(
        baseUrl: baseUrl,
        apiCallType: apiCallType,
        customHeaders: customHeaders);
  }

  @override
  Future apiRequest(String path,
      {Function? response,
      Function? error,
      RequestMethod? requestMethod,
      body,
      bool? isData,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var dio = await this.dio;
      Response? res;
      switch (requestMethod) {
        case RequestMethod.post:
          res = await dio?.post(path,
              data: body, queryParameters: queryParameters);
          break;
        case RequestMethod.put:
          res = await dio?.put(path,
              data: body, queryParameters: queryParameters);
          break;
        case RequestMethod.delete:
          res = await dio?.delete(path,
              data: body, queryParameters: queryParameters);
          break;
        case RequestMethod.getPost:
          res = await dio?.get(path,
              data: body, queryParameters: queryParameters);
          break;
        default:
          res = await dio?.get(path, queryParameters: queryParameters);
          break;
      }
      if (isData == true) {
        try {
          return json.decode(res.toString());
        } catch (e) {
          debugPrint("Error was found in the api call ${e.toString()}");
          return res;
        }
      }
      return await sendResponse(res, response);
    } catch (err) {
      if (err is DioException && err.response?.statusCode != 200) {
        return Future.error(LanguageConst.couldNotConnectToServer);
      }
      try {
        DioException dioError = err as DioException;
        return sendResponse(dioError.response, response);
      } catch (dError) {
        if (error != null) {
          error(err);
        }
        return Future.error(err);
      }
    }
  }

  @override
  Future downloadFile(String baseUrl, String downloadPath,
      {String extension = "aac",
      Map<String, dynamic>? queryParameter,
      Map<String, String>? headers}) async {
    // Bug:156633 As the dio is providing the default error class we can use
    // Direct response object as a String message from the backend and show it
    // to the UI.
    try {
      var dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 600000),
          receiveTimeout: const Duration(seconds: 600000),
          headers: headers));
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
      Response response = await dio.download(
        EndPoints.appToken,
        downloadPath,
        queryParameters: queryParameter,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status == 200;
            }),
      );
      if (response.statusCode != 200) {
        deleteFile(File(downloadPath));
        return LanguageConst.fileDownloadError;
      }
      return '';
    } catch (e) {
      log(e.toString());
      deleteFile(File(downloadPath));
      if (e is DioException) {
        if (e.response?.statusCode == 404) return e.response.toString();
      }
      log(e.toString());
      return LanguageConst.fileDownloadError;
    }
  }

  @override
  Future getImage(String path,
      {Function? response,
      Function? error,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var dio = await this.dio;
      var res = await dio?.get(path, queryParameters: queryParameters);
      return res?.data;
    } catch (err) {
      if (error != null) {
        error(err);
      }
      return err;
    }
  }

  static Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  static Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // prefer using rename as it is probably faster
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
      debugPrint(e.message);
      // if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  @override
  Future sendResponse(res, Function? response, {bool? isData}) async {
    BaseResponse baseResponse;
    try {
      baseResponse = BaseResponse.fromJson(json.decode(res.data));
    } catch (e) {
      try {
        baseResponse = BaseResponse.fromJson(res.data);
      } catch (e) {
        return Future.error(LanguageConst.couldNotConnectToServer);
      }
    }

    if (baseResponse.code == 0 ||
        baseResponse.code == 1 ||
        baseResponse.code == '1') {
      if (response != null) {
        debugPrint('THis is data returned');
        response(baseResponse.data);
      }

      if (baseResponse.data == null) {
        return baseResponse.description;
      }
      return baseResponse.data;
    } else if (baseResponse.code == -3) {
      debugPrint('This is code$baseResponse ');
      return Future.error(
          baseResponse.description ?? LanguageConst.couldNotConnectToServer);
    } else {
      return Future.error(
          baseResponse.description ?? LanguageConst.couldNotConnectToServer);
    }
  }
}
