import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:soulful_plates/utils/connection_status.dart';

import '../../constants/language/language_constants.dart';
import '../network_interfaces/generic_model.dart';
import '../network_interfaces/i_dio_singleton.dart';
import 'network_call.dart';

class ApiCall {
  ///  ApiCall used for all the api call from the application
  ///
  ///  method : as a api call methods {Get, PUT, POST, DELETE}
  ///  apiCallType : type of headers and url binding based on request type {MOS, PROVIDER, PATIENT, SIMPLE } for now
  ///  endPoint: end point of the api call like /api/loginToDB
  ///  parameters : send the parameters to the api calls
  ///  queryParameters: are used for the Get methods request as the
  ///            parameters as a query parameter not using body
  ///            used in the post method too when body and query parameter both
  ///            required
  ///  customHeaders : custom headers apart from the common headers
  ///  baseURL : for the custom different url and for the api call SIMPLE
  ///  obj : return type of the data model from the api
  ///  apiPath: path of the json from where we can get the data model obj or list of obj
  ///           example: { 'provider_list': {  }, ' office_list' : { }}
  ///           if we only want the def not abc then send apiPath as 'office_list'
  ///
  ///  Note below parameter responses
  ///  When apiPath and obj both empty then response is json with code data description
  ///  When only obj then obj with given model
  ///  When apiPath and obj then model of given apipath
  ///  When only apiPath return api path json response
  ///
  Future<dynamic> call<T>({
    required RequestMethod method,
    required String endPoint,
    dynamic parameters,
    dynamic queryParameters,
    Map<String, dynamic>? customHeaders,
    String? baseUrl,
    GenericModel? obj,
    String? apiPath,
    ApiCallType? apiCallType,
  }) async {
    List<T> list = [];

    //Network connection Check
    bool connection = await ConnectionStatus.isInternetAvailable();

    if (!connection) {
      throw (LanguageConst.internetNotAvailable);
    }
    //Create network call
    NetworkCallDio netCall = NetworkCallDio(
        baseUrl: baseUrl,
        apiCallType: apiCallType,
        customHeaders: customHeaders);

    var response = await netCall.apiRequest(endPoint,
        body: parameters,
        isData: obj == null && apiPath == null,
        queryParameters: queryParameters,
        requestMethod: method);
    print("This is the response of the data base ${response}");
    if (apiPath != null) {
      response = await getApiPathData(data: response, apiPath: apiPath);
    }
    if (obj == null) {
      return response;
    } else {
      if (response is Iterable) {
        debugPrint('THis is Iterable returned $response');
        if (response.isNotEmpty) {
          for (var val in response) {
            try {
              list.add(obj.from(val));
            } catch (e) {
              debugPrint('This is $e');
            }
          }
        }
        debugPrint('This is one ');
        return list.toList();
      } else {
        return obj.from(response);
      }
    }
  }

  /// For get the given api path json data from the json model
  getApiPathData({required apiPath, required data}) async {
    var keys = apiPath.split("/");
    var response = data is String ? jsonDecode(data) : data;
    for (String key in keys) {
      if (response.containsKey(key)) {
        response = response[key];
      } else {
        return Future.error(LanguageConst.conNotConvertData);
      }
    }
    return response;
  }
}
