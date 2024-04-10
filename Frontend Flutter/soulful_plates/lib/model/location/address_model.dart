import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

/// addressId : 2
/// street : "123 "
/// city : "New York"
/// state : "NY"
/// postalCode : "10001"
/// country : "USA"
/// latitude : -15.4545
/// longitude : -74.006
/// label : "Home"

class AddressModel extends GenericModel {
  AddressModel({
    num? addressId,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    num? latitude,
    num? longitude,
    String? label,
  }) {
    _addressId = addressId;
    _street = street;
    _city = city;
    _state = state;
    _postalCode = postalCode;
    _country = country;
    _latitude = latitude;
    _longitude = longitude;
    _label = label;
  }

  AddressModel.fromJson(dynamic json) {
    _addressId = json['addressId'];
    _street = json['street'];
    _city = json['city'];
    _state = json['state'];
    _postalCode = json['postalCode'];
    _country = json['country'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _label = json['label'];
  }
  num? _addressId;
  String? _street;
  String? _city;
  String? _state;
  String? _postalCode;
  String? _country;
  num? _latitude;
  num? _longitude;
  String? _label;
  AddressModel copyWith({
    num? addressId,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    num? latitude,
    num? longitude,
    String? label,
  }) =>
      AddressModel(
        addressId: addressId ?? _addressId,
        street: street ?? _street,
        city: city ?? _city,
        state: state ?? _state,
        postalCode: postalCode ?? _postalCode,
        country: country ?? _country,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        label: label ?? _label,
      );
  num? get addressId => _addressId;
  String? get street => _street;
  String? get city => _city;
  String? get state => _state;
  String? get postalCode => _postalCode;
  String? get country => _country;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get label => _label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addressId'] = _addressId;
    map['street'] = _street;
    map['city'] = _city;
    map['state'] = _state;
    map['postalCode'] = _postalCode;
    map['country'] = _country;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['label'] = _label;
    return map;
  }

  @override
  from(json) {
    return AddressModel.fromJson(json);
  }
}
