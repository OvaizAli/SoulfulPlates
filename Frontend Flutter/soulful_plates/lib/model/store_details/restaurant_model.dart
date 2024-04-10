import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

/// store_id : 1
/// distance : 0
/// user_id : 1
/// store_email : "Nikul@gmail.com"
/// store_name : "Nikul’s Veggies"
/// store_image_url : ""
/// lon : -74.006
/// store_contact_number : "1234561230"
/// lat : -74.006
/// store_description : "Nikul’s veggies healthy and better food for everyone…"

class RestaurantModel extends GenericModel {
  RestaurantModel({
    num? storeId,
    num? distance,
    num? userId,
    String? storeEmail,
    String? storeName,
    String? storeImageUrl,
    num? lon,
    String? storeContactNumber,
    num? lat,
    String? storeDescription,
  }) {
    _storeId = storeId;
    _distance = distance;
    _userId = userId;
    _storeEmail = storeEmail;
    _storeName = storeName;
    _storeImageUrl = storeImageUrl;
    _lon = lon;
    _storeContactNumber = storeContactNumber;
    _lat = lat;
    _storeDescription = storeDescription;
  }

  RestaurantModel.fromJson(dynamic json) {
    _storeId = json['store_id'];
    _distance = json['distance'];
    _userId = json['user_id'];
    _storeEmail = json['store_email'];
    _storeName = json['store_name'];
    _storeImageUrl = json['store_image_url'];
    _lon = json['lon'];
    _storeContactNumber = json['store_contact_number'];
    _lat = json['lat'];
    _storeDescription = json['store_description'];
  }
  num? _storeId;
  num? _distance;
  num? _userId;
  String? _storeEmail;
  String? _storeName;
  String? _storeImageUrl;
  num? _lon;
  String? _storeContactNumber;
  num? _lat;
  String? _storeDescription;
  RestaurantModel copyWith({
    num? storeId,
    num? distance,
    num? userId,
    String? storeEmail,
    String? storeName,
    String? storeImageUrl,
    num? lon,
    String? storeContactNumber,
    num? lat,
    String? storeDescription,
  }) =>
      RestaurantModel(
        storeId: storeId ?? _storeId,
        distance: distance ?? _distance,
        userId: userId ?? _userId,
        storeEmail: storeEmail ?? _storeEmail,
        storeName: storeName ?? _storeName,
        storeImageUrl: storeImageUrl ?? _storeImageUrl,
        lon: lon ?? _lon,
        storeContactNumber: storeContactNumber ?? _storeContactNumber,
        lat: lat ?? _lat,
        storeDescription: storeDescription ?? _storeDescription,
      );
  num? get storeId => _storeId;
  num? get distance => _distance;
  num? get userId => _userId;
  String? get storeEmail => _storeEmail;
  String? get storeName => _storeName;
  String? get storeImageUrl => _storeImageUrl;
  num? get lon => _lon;
  String? get storeContactNumber => _storeContactNumber;
  num? get lat => _lat;
  String? get storeDescription => _storeDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = _storeId;
    map['distance'] = _distance;
    map['user_id'] = _userId;
    map['store_email'] = _storeEmail;
    map['store_name'] = _storeName;
    map['store_image_url'] = _storeImageUrl;
    map['lon'] = _lon;
    map['store_contact_number'] = _storeContactNumber;
    map['lat'] = _lat;
    map['store_description'] = _storeDescription;
    return map;
  }

  @override
  from(json) {
    return RestaurantModel.fromJson(json);
  }
}
