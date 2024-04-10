import 'dart:convert';

import 'package:get/get.dart';
import 'package:soulful_plates/Utils/Extensions.dart';

import '../../network/network_interfaces/generic_model.dart';

/// token : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzZWxsZXIyIiwiaWF0IjoxNzA5NjYwMTQ1LCJleHAiOjE3MDk3NDY1NDV9.NEJja-eznh23gLXY3iZpxC40PY1mU5AVbf0YIgSFLRM"
/// type : "Bearer"
/// id : 3
/// username : "seller2"
/// email : "seller2@seller.com"
/// roles : ["ROLE_SELLER"]
/// firstname : "seller1"
/// contactNumber : "1234567890"
/// notificationFlag : true
/// sellerId : 1
/// sellerName : ""
/// sellerEmail : ""
/// sellerContactNumber : ""

class UserProfile extends GenericModel {
  UserProfile({
    String? token,
    String? type,
    num? id,
    String? username,
    String? email,
    List<String>? roles,
    String? firstname,
    String? contactNumber,
    bool? notificationFlag,
    num? sellerId,
    String? sellerName,
    String? sellerEmail,
    String? sellerContactNumber,
    String? storeDescription,
    String? image,
  }) {
    _token = token;
    _type = type;
    _id = id;
    _username = username;
    _email = email;
    _roles = roles;
    _firstname = firstname;
    _contactNumber = contactNumber;
    _notificationFlag = notificationFlag;
    _sellerId = sellerId;
    _sellerName = sellerName;
    _sellerEmail = sellerEmail;
    _sellerContactNumber = sellerContactNumber;
    _storeDescription = storeDescription;
    _image = image;
  }

  UserProfile.fromJson(dynamic json) {
    _token = json['token'];
    _type = json['type'];
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    _firstname = json['firstname'];
    _contactNumber = json['contactNumber'];
    _notificationFlag = json['notificationFlag'];
    _sellerId = json['sellerId'];
    _sellerName = json['sellerName'];
    _sellerEmail = json['sellerEmail'];
    _sellerContactNumber = json['sellerContactNumber'];
    _storeDescription = json['storeDescription'];
    _image = json['image'];
  }
  String? _token;
  String? _type;
  num? _id;
  String? _username;
  String? _email;
  List<String>? _roles;
  String? _firstname;
  String? _contactNumber;
  bool? _notificationFlag;
  num? _sellerId;
  String? _sellerName;
  String? _sellerEmail;
  String? _sellerContactNumber;
  String? _storeDescription;
  String? _image;
  UserProfile copyWith({
    String? token,
    String? type,
    num? id,
    String? username,
    String? email,
    List<String>? roles,
    String? firstname,
    String? contactNumber,
    bool? notificationFlag,
    num? sellerId,
    String? sellerName,
    String? sellerEmail,
    String? storeDescription,
    String? image,
    String? sellerContactNumber,
  }) =>
      UserProfile(
        token: token ?? _token,
        type: type ?? _type,
        id: id ?? _id,
        username: username ?? _username,
        email: email ?? _email,
        roles: roles ?? _roles,
        firstname: firstname ?? _firstname,
        contactNumber: contactNumber ?? _contactNumber,
        notificationFlag: notificationFlag ?? _notificationFlag,
        sellerId: sellerId ?? _sellerId,
        sellerName: sellerName ?? _sellerName,
        sellerEmail: sellerEmail ?? _sellerEmail,
        storeDescription: storeDescription ?? _storeDescription,
        sellerContactNumber: sellerContactNumber ?? _sellerContactNumber,
        image: image ?? _image,
      );
  String? get token => _token;
  String? get type => _type;
  String? get id => "$_id";
  String? get username => _username;
  String? get email => _email;
  List<String>? get roles => _roles;
  String? get firstname => _firstname;
  String? get contactNumber => _contactNumber;
  bool? get notificationFlag => _notificationFlag;
  num? get sellerId => _sellerId;
  String? get sellerName => _sellerName;
  String? get sellerEmail => _sellerEmail;
  String? get sellerContactNumber => _sellerContactNumber;
  String? get storeDescription => _storeDescription;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['type'] = _type;
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['roles'] = _roles;
    map['firstname'] = _firstname;
    map['contactNumber'] = _contactNumber;
    map['notificationFlag'] = _notificationFlag;
    map['sellerId'] = _sellerId;
    map['sellerName'] = _sellerName;
    map['sellerEmail'] = _sellerEmail;
    map['sellerContactNumber'] = _sellerContactNumber;
    map['storeDescription'] = _storeDescription;
    map['image'] = _image;
    return map;
  }

  static UserProfile? fromRawJson(String str) {
    if (str.isNotEmpty) {
      return UserProfile.fromJson(jsonDecode(str));
    } else {
      return null;
    }
  }

  String toRawJson() => jsonEncode(toJson());

  String shortName() {
    if (username.isNotNullOrEmpty) {
      return username!.substring(0, 1).capitalizeFirst ?? '';
    }
    return '-';
  }

  @override
  String toString() {
    return 'UserProfile{_id: $_id, _username: $_username, _email: $_email, _phoneNumber: $_contactNumber, _image: $_image}';
  }

  @override
  from(json) {
    return UserProfile.fromJson(json);
  }
}
