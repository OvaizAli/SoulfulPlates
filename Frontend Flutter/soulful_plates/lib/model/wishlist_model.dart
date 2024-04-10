import '../network/network_interfaces/generic_model.dart';

/// wishId : 1
/// storeId : 1
/// userId : 2
/// storeName : "Nikul's Curry"
/// storeEmail : "nikul@gmail.com"
/// menuItemId : 1
/// itemName : "berger 2 9"
/// itemPrice : 13

class WishlistModel extends GenericModel {
  WishlistModel({
    num? wishId,
    num? storeId,
    num? userId,
    String? storeName,
    String? storeEmail,
    num? menuItemId,
    String? itemName,
    num? itemPrice,
  }) {
    _wishId = wishId;
    _storeId = storeId;
    _userId = userId;
    _storeName = storeName;
    _storeEmail = storeEmail;
    _menuItemId = menuItemId;
    _itemName = itemName;
    _itemPrice = itemPrice;
  }

  WishlistModel.fromJson(dynamic json) {
    _wishId = json['wishId'];
    _storeId = json['storeId'];
    _userId = json['userId'];
    _storeName = json['storeName'];
    _storeEmail = json['storeEmail'];
    _menuItemId = json['menuItemId'];
    _itemName = json['itemName'];
    _itemPrice = json['itemPrice'];
  }
  num? _wishId;
  num? _storeId;
  num? _userId;
  String? _storeName;
  String? _storeEmail;
  num? _menuItemId;
  String? _itemName;
  num? _itemPrice;
  WishlistModel copyWith({
    num? wishId,
    num? storeId,
    num? userId,
    String? storeName,
    String? storeEmail,
    num? menuItemId,
    String? itemName,
    num? itemPrice,
  }) =>
      WishlistModel(
        wishId: wishId ?? _wishId,
        storeId: storeId ?? _storeId,
        userId: userId ?? _userId,
        storeName: storeName ?? _storeName,
        storeEmail: storeEmail ?? _storeEmail,
        menuItemId: menuItemId ?? _menuItemId,
        itemName: itemName ?? _itemName,
        itemPrice: itemPrice ?? _itemPrice,
      );
  num? get wishId => _wishId;
  num? get storeId => _storeId;
  num? get userId => _userId;
  String? get storeName => _storeName;
  String? get storeEmail => _storeEmail;
  num? get menuItemId => _menuItemId;
  String? get itemName => _itemName;
  num? get itemPrice => _itemPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wishId'] = _wishId;
    map['storeId'] = _storeId;
    map['userId'] = _userId;
    map['storeName'] = _storeName;
    map['storeEmail'] = _storeEmail;
    map['menuItemId'] = _menuItemId;
    map['itemName'] = _itemName;
    map['itemPrice'] = _itemPrice;
    return map;
  }

  @override
  from(json) {
    return WishlistModel.fromJson(json);
  }
}
