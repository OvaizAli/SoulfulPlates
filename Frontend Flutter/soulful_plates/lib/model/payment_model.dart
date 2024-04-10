import 'package:soulful_plates/constants/app_theme.dart';

import '../network/network_interfaces/generic_model.dart';

/// userId : 1
/// username : "seller"
/// storeId : 1
/// storeName : "Nikul’s Veggies"
/// amount : 61.00
/// orderId : 26
/// cardNumber : "34**-45**-53**-3434"
/// cardExpiry : "12/45"
/// cvv : "***"
/// paymentStatus : "Pending"
/// paymentId : 6
/// transactionId : 9
/// status : "Processing"
/// createdDate : "2024-03-28T01:32:42.500+00:00"
/// updatedDate : "2024-03-28T01:32:42.500+00:00"

class PaymentModel extends GenericModel {
  PaymentModel({
    num? userId,
    String? username,
    num? storeId,
    String? storeName,
    num? amount,
    num? orderId,
    String? cardNumber,
    String? cardExpiry,
    String? cvv,
    String? paymentStatus,
    num? paymentId,
    num? transactionId,
    String? status,
    String? createdDate,
    String? updatedDate,
  }) {
    _userId = userId;
    _username = username;
    _storeId = storeId;
    _storeName = storeName;
    _amount = amount;
    _orderId = orderId;
    _cardNumber = cardNumber;
    _cardExpiry = cardExpiry;
    _cvv = cvv;
    _paymentStatus = paymentStatus;
    _paymentId = paymentId;
    _transactionId = transactionId;
    _status = status;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
  }

  PaymentModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _username = json['username'];
    _storeId = json['storeId'];
    _storeName = json['storeName'];
    _amount = json['amount'];
    _orderId = json['orderId'];
    _cardNumber = json['cardNumber'];
    _cardExpiry = json['cardExpiry'];
    _cvv = json['cvv'];
    _paymentStatus = json['paymentStatus'];
    _paymentId = json['paymentId'];
    _transactionId = json['transactionId'];
    _status = json['status'];
    _createdDate = json['createdDate'];
    _updatedDate = json['updatedDate'];
  }
  num? _userId;
  String? _username;
  num? _storeId;
  String? _storeName;
  num? _amount;
  num? _orderId;
  String? _cardNumber;
  String? _cardExpiry;
  String? _cvv;
  String? _paymentStatus;
  num? _paymentId;
  num? _transactionId;
  String? _status;
  String? _createdDate;
  String? _updatedDate;
  PaymentModel copyWith({
    num? userId,
    String? username,
    num? storeId,
    String? storeName,
    num? amount,
    num? orderId,
    String? cardNumber,
    String? cardExpiry,
    String? cvv,
    String? paymentStatus,
    num? paymentId,
    num? transactionId,
    String? status,
    String? createdDate,
    String? updatedDate,
  }) =>
      PaymentModel(
        userId: userId ?? _userId,
        username: username ?? _username,
        storeId: storeId ?? _storeId,
        storeName: storeName ?? _storeName,
        amount: amount ?? _amount,
        orderId: orderId ?? _orderId,
        cardNumber: cardNumber ?? _cardNumber,
        cardExpiry: cardExpiry ?? _cardExpiry,
        cvv: cvv ?? _cvv,
        paymentStatus: paymentStatus ?? _paymentStatus,
        paymentId: paymentId ?? _paymentId,
        transactionId: transactionId ?? _transactionId,
        status: status ?? _status,
        createdDate: createdDate ?? _createdDate,
        updatedDate: updatedDate ?? _updatedDate,
      );
  num? get userId => _userId;
  String? get username => _username;
  num? get storeId => _storeId;
  String? get storeName => _storeName;
  num? get amount => _amount;
  num? get orderId => _orderId;
  String? get cardNumber => _cardNumber;
  String? get cardExpiry => _cardExpiry;
  String? get cvv => _cvv;
  String? get paymentStatus => _paymentStatus;
  num? get paymentId => _paymentId;
  num? get transactionId => _transactionId;
  String? get status => _status;
  String? get createdDate => _createdDate;
  String? get updatedDate => _updatedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['username'] = _username;
    map['storeId'] = _storeId;
    map['storeName'] = _storeName;
    map['amount'] = _amount;
    map['orderId'] = _orderId;
    map['cardNumber'] = _cardNumber;
    map['cardExpiry'] = _cardExpiry;
    map['cvv'] = _cvv;
    map['paymentStatus'] = _paymentStatus;
    map['paymentId'] = _paymentId;
    map['transactionId'] = _transactionId;
    map['status'] = _status;
    map['createdDate'] = _createdDate;
    map['updatedDate'] = _updatedDate;
    return map;
  }

  @override
  from(json) {
    return PaymentModel.fromJson(json);
  }

  PaymentStatus getPaymentStatusType() {
    PaymentStatus orderStatusType = PaymentStatus.values.firstWhere(
      (element) => element.toString().split('.').last == paymentStatus,
      orElse: () => PaymentStatus.Pending,
    );
    return orderStatusType;
  }
}
