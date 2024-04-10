import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

/// store_id : 1
/// distance : 0
/// user_id : 2
/// store_email : "contact@store.com"
/// store_image_url : null
/// store_name : "store name"
/// lon : -74.006
/// store_contact_number : "123-456-7890"
/// lat : null
/// store_description : "A brief description of the store"

class StoreModel extends GenericModel {
  StoreModel({
    num? storeId,
    num? distance,
    num? userId,
    String? storeEmail,
    dynamic storeImageUrl,
    String? storeName,
    num? lon,
    String? storeContactNumber,
    dynamic lat,
    String? storeDescription,
  }) {
    _storeId = storeId;
    _distance = distance;
    _userId = userId;
    _storeEmail = storeEmail;
    _storeImageUrl = storeImageUrl;
    _storeName = storeName;
    _lon = lon;
    _storeContactNumber = storeContactNumber;
    _lat = lat;
    _storeDescription = storeDescription;
  }

  StoreModel.fromJson(dynamic json) {
    _storeId = json['store_id'];
    _distance = json['distance'];
    _userId = json['user_id'];
    _storeEmail = json['store_email'];
    _storeImageUrl = json['store_image_url'];
    _storeName = json['store_name'];
    _lon = json['lon'];
    _storeContactNumber = json['store_contact_number'];
    _lat = json['lat'];
    _storeDescription = json['store_description'];
  }
  num? _storeId;
  num? _distance;
  num? _userId;
  String? _storeEmail;
  dynamic _storeImageUrl;
  String? _storeName;
  num? _lon;
  String? _storeContactNumber;
  dynamic _lat;
  String? _storeDescription;
  StoreModel copyWith({
    num? storeId,
    num? distance,
    num? userId,
    String? storeEmail,
    dynamic storeImageUrl,
    String? storeName,
    num? lon,
    String? storeContactNumber,
    dynamic lat,
    String? storeDescription,
  }) =>
      StoreModel(
        storeId: storeId ?? _storeId,
        distance: distance ?? _distance,
        userId: userId ?? _userId,
        storeEmail: storeEmail ?? _storeEmail,
        storeImageUrl: storeImageUrl ?? _storeImageUrl,
        storeName: storeName ?? _storeName,
        lon: lon ?? _lon,
        storeContactNumber: storeContactNumber ?? _storeContactNumber,
        lat: lat ?? _lat,
        storeDescription: storeDescription ?? _storeDescription,
      );
  num? get storeId => _storeId;
  num? get distance => _distance;
  num? get userId => _userId;
  String? get storeEmail => _storeEmail;
  dynamic get storeImageUrl => _storeImageUrl;
  String? get storeName => _storeName;
  num? get lon => _lon;
  String? get storeContactNumber => _storeContactNumber;
  dynamic get lat => _lat;
  String? get storeDescription => _storeDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = _storeId;
    map['distance'] = _distance;
    map['user_id'] = _userId;
    map['store_email'] = _storeEmail;
    map['store_image_url'] = _storeImageUrl;
    map['store_name'] = _storeName;
    map['lon'] = _lon;
    map['store_contact_number'] = _storeContactNumber;
    map['lat'] = _lat;
    map['store_description'] = _storeDescription;
    return map;
  }

  @override
  from(json) {
    return StoreModel.fromJson(json);
  }
}
