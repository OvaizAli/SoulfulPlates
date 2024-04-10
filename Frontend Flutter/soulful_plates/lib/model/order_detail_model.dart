import 'package:soulful_plates/constants/app_theme.dart';
import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

/// orderId : 1
/// orderStatus : "COMPLETED"
/// createdDate : "2024-03-21T03:37:24.975+00:00"
/// userId : 1
/// storeId : 1
/// rating : null
/// feedback : null
/// paymentStatus : null
/// totalAmount : 20.5
/// instructions : "Leave at door"
/// items : [{"menuItemId":1,"itemName":"Banana shake","quantity":2,"price":10.25}]
/// cartItems : [{"menuItemId":1,"itemName":"Banana shake","quantity":2,"price":10.25}]

/*
            "username": null,
            "userPhone": "9876543210",
            "userEmail": "seller@seller.com",
            "storeName": "Nikul’s Veggies",
            "storePhone": "1234561230",
            "storeEmail": "Nikul@gmail.com",

 */
class OrderDetailModel extends GenericModel {
  OrderDetailModel({
    num? orderId,
    String? orderStatus,
    String? createdDate,
    num? userId,
    num? storeId,
    num? rating,
    String? feedback,
    dynamic paymentStatus,
    num? totalAmount,
    String? instructions,
    List<Items>? items,
    List<CartItems>? cartItems,
    String? username,
    String? userPhone,
    String? userEmail,
    String? storeName,
    String? storePhone,
    String? storeEmail,
  }) {
    _orderId = orderId;
    _orderStatus = orderStatus;
    _createdDate = createdDate;
    _userId = userId;
    _storeId = storeId;
    _rating = rating;
    _feedback = feedback;
    _paymentStatus = paymentStatus;
    _totalAmount = totalAmount;
    _instructions = instructions;
    _items = items;
    _cartItems = cartItems;
    _username = username;
    _userPhone = userPhone;
    _userEmail = userEmail;
    _storeName = storeName;
    _storePhone = storePhone;
    _storeEmail = storeEmail;
  }

  OrderDetailModel.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _orderStatus = json['orderStatus'];
    _createdDate = json['createdDate'];
    _userId = json['userId'];
    _storeId = json['storeId'];
    _rating = json['rating'];
    _feedback = json['feedback'];
    _paymentStatus = json['paymentStatus'];
    _totalAmount = json['totalAmount'];
    _instructions = json['instructions'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    if (json['cartItems'] != null) {
      _cartItems = [];
      json['cartItems'].forEach((v) {
        _cartItems?.add(CartItems.fromJson(v));
      });
    }
    _username = json['username'];
    _userPhone = json['userPhone'];
    _userEmail = json['userEmail'];
    _storeName = json['storeName'];
    _storePhone = json['storePhone'];
    _storeEmail = json['storeEmail'];
  }
  num? _orderId;
  String? _orderStatus;
  String? _createdDate;
  num? _userId;
  num? _storeId;
  num? _rating;
  String? _feedback;
  dynamic _paymentStatus;
  num? _totalAmount;
  String? _instructions;
  List<Items>? _items;
  List<CartItems>? _cartItems;

  String? _username;
  String? _userPhone;
  String? _userEmail;
  String? _storeName;
  String? _storePhone;
  String? _storeEmail;

  String? get username => _username;
  String? get userPhone => _userPhone;
  String? get userEmail => _userEmail;
  String? get storeName => _storeName;
  String? get storePhone => _storePhone;
  String? get storeEmail => _storeEmail;

  setRating(int value) {
    _rating = value;
  }

  setOrderStatus(OrderStatus orderStatus) {
    _orderStatus = orderStatus.name;
  }

  OrderDetailModel copyWith({
    num? orderId,
    String? orderStatus,
    String? createdDate,
    num? userId,
    num? storeId,
    num? rating,
    String? feedback,
    dynamic paymentStatus,
    num? totalAmount,
    String? instructions,
    List<Items>? items,
    List<CartItems>? cartItems,
    String? username,
    String? userPhone,
    String? userEmail,
    String? storeName,
    String? storePhone,
    String? storeEmail,
  }) =>
      OrderDetailModel(
        orderId: orderId ?? _orderId,
        orderStatus: orderStatus ?? _orderStatus,
        createdDate: createdDate ?? _createdDate,
        userId: userId ?? _userId,
        storeId: storeId ?? _storeId,
        rating: rating ?? _rating,
        feedback: feedback ?? _feedback,
        paymentStatus: paymentStatus ?? _paymentStatus,
        totalAmount: totalAmount ?? _totalAmount,
        instructions: instructions ?? _instructions,
        items: items ?? _items,
        cartItems: cartItems ?? _cartItems,
        username: username ?? _username,
        userPhone: userPhone ?? _userPhone,
        userEmail: userEmail ?? _userEmail,
        storeName: storeName ?? _storeName,
        storePhone: storePhone ?? _storePhone,
        storeEmail: storeEmail ?? _storeEmail,
      );
  num? get orderId => _orderId;
  String? get orderStatus => _orderStatus;
  String? get createdDate => _createdDate;
  num? get userId => _userId;
  num? get storeId => _storeId;
  num? get rating => _rating;
  String? get feedback => _feedback;
  dynamic get paymentStatus => _paymentStatus;
  num? get totalAmount => _totalAmount;
  String? get instructions => _instructions;
  List<Items>? get items => _items;
  List<CartItems>? get cartItems => _cartItems;

  bool isSeller = false;

  setIsSeller(seller) {
    isSeller = seller;
  }

  OrderStatus getOrderStatusType() {
    OrderStatus orderStatusType = OrderStatus.values.firstWhere(
      (element) => element.toString().split('.').last == orderStatus,
      orElse: () => OrderStatus.Pending,
    );
    return orderStatusType;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['orderStatus'] = _orderStatus;
    map['createdDate'] = _createdDate;
    map['userId'] = _userId;
    map['storeId'] = _storeId;
    map['rating'] = _rating;
    map['feedback'] = _feedback;
    map['paymentStatus'] = _paymentStatus;
    map['totalAmount'] = _totalAmount;
    map['instructions'] = _instructions;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    if (_cartItems != null) {
      map['cartItems'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    map['username'] = _username;
    map['userPhone'] = _userPhone;
    map['userEmail'] = _userEmail;
    map['storeName'] = _storeName;
    map['storePhone'] = _storePhone;
    map['storeEmail'] = _storeEmail;
    return map;
  }

  @override
  from(json) {
    return OrderDetailModel.fromJson(json);
  }
}

/// menuItemId : 1
/// itemName : "Banana shake"
/// quantity : 2
/// price : 10.25

class CartItems {
  CartItems({
    num? menuItemId,
    String? itemName,
    num? quantity,
    num? price,
  }) {
    _menuItemId = menuItemId;
    _itemName = itemName;
    _quantity = quantity;
    _price = price;
  }

  CartItems.fromJson(dynamic json) {
    _menuItemId = json['menuItemId'];
    _itemName = json['itemName'];
    _quantity = json['quantity'];
    _price = json['price'];
  }
  num? _menuItemId;
  String? _itemName;
  num? _quantity;
  num? _price;
  CartItems copyWith({
    num? menuItemId,
    String? itemName,
    num? quantity,
    num? price,
  }) =>
      CartItems(
        menuItemId: menuItemId ?? _menuItemId,
        itemName: itemName ?? _itemName,
        quantity: quantity ?? _quantity,
        price: price ?? _price,
      );
  num? get menuItemId => _menuItemId;
  String? get itemName => _itemName;
  num? get quantity => _quantity;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuItemId'] = _menuItemId;
    map['itemName'] = _itemName;
    map['quantity'] = _quantity;
    map['price'] = _price;
    return map;
  }
}

/// menuItemId : 1
/// itemName : "Banana shake"
/// quantity : 2
/// price : 10.25

class Items {
  Items({
    num? menuItemId,
    String? itemName,
    num? quantity,
    num? price,
  }) {
    _menuItemId = menuItemId;
    _itemName = itemName;
    _quantity = quantity;
    _price = price;
  }

  Items.fromJson(dynamic json) {
    _menuItemId = json['menuItemId'];
    _itemName = json['itemName'];
    _quantity = json['quantity'];
    _price = json['price'];
  }
  num? _menuItemId;
  String? _itemName;
  num? _quantity;
  num? _price;
  Items copyWith({
    num? menuItemId,
    String? itemName,
    num? quantity,
    num? price,
  }) =>
      Items(
        menuItemId: menuItemId ?? _menuItemId,
        itemName: itemName ?? _itemName,
        quantity: quantity ?? _quantity,
        price: price ?? _price,
      );
  num? get menuItemId => _menuItemId;
  String? get itemName => _itemName;
  num? get quantity => _quantity;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menuItemId'] = _menuItemId;
    map['itemName'] = _itemName;
    map['quantity'] = _quantity;
    map['price'] = _price;
    return map;
  }
}
