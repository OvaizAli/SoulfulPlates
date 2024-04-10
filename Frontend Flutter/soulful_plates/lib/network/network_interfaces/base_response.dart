class BaseResponse {
  final dynamic code;
  final dynamic data;
  final String? description;
  final String? backendVersion;
  final String? dbVersion;

  BaseResponse(
      {this.backendVersion,
      this.dbVersion,
      this.code,
      this.data,
      this.description});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        code: json['code'],
        data: json['data'],
        description: json['description'],
        backendVersion: json['backend_version'],
        dbVersion: json['db_version']);
  }

  @override
  String toString() {
    return 'code: $code, data: $data, description : $description';
  }
}
