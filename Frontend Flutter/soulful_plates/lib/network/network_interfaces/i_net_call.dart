import 'i_dio_singleton.dart';

///
/// NetCall interface for the different api call methods
///
abstract class INetCall {
  Future apiRequest(String path,
      {Function? response,
      Function? error,
      RequestMethod? requestMethod,
      dynamic body,
      bool? isData,
      Map<String, dynamic>? queryParameters});

  Future getImage(String path,
      {Function? response,
      Function? error,
      Map<String, dynamic>? queryParameters});

  Future downloadFile(String baseUrl, String downloadPath,
      {String extension = "aac",
      Map<String, dynamic>? queryParameter,
      Map<String, String>? headers});

  Future sendResponse(res, Function? response);
}
