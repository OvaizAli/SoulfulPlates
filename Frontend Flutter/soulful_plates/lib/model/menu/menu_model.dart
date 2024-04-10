import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

/// itemId : 2
/// itemName : "Pizza"
/// description : "It contains mayo and margarita cheese sauce."
/// itemPrice : "13"
/// type : "Veg"
/// inStock : true
/// itemImage : ""
/// servingType : 2
/// portion : "Medium"
/// categoryName : "Category"
/// subcategoryName : "Specialties"
/// recommended : false
/// subcategoryId : 2
/// categoryId : 1

class MenuModel extends GenericModel {
  MenuModel({
    num? itemId,
    String? itemName,
    String? description,
    String? itemPrice,
    String? type,
    bool? inStock,
    String? itemImage,
    num? servingType,
    String? portion,
    String? categoryName,
    String? subcategoryName,
    bool? recommended,
    num? subcategoryId,
    num? categoryId,
  }) {
    _itemId = itemId;
    _itemName = itemName;
    _description = description;
    _itemPrice = itemPrice;
    _type = type;
    _inStock = inStock;
    _itemImage = itemImage;
    _servingType = servingType;
    _portion = portion;
    _categoryName = categoryName;
    _subcategoryName = subcategoryName;
    _recommended = recommended;
    _subcategoryId = subcategoryId;
    _categoryId = categoryId;
  }

  MenuModel.fromJson(dynamic json) {
    _itemId = json['itemId'];
    _itemName = json['itemName'];
    _description = json['description'];
    _itemPrice = json['itemPrice'];
    _type = json['type'];
    _inStock = json['inStock'];
    _itemImage = json['itemImage'];
    _servingType = json['servingType'];
    _portion = json['portion'];
    _categoryName = json['categoryName'];
    _subcategoryName = json['subcategoryName'];
    _recommended = json['recommended'];
    _subcategoryId = json['subcategoryId'];
    _categoryId = json['categoryId'];
  }
  num? _itemId;
  String? _itemName;
  String? _description;
  String? _itemPrice;
  String? _type;
  bool? _inStock;
  String? _itemImage;
  num? _servingType;
  String? _portion;
  String? _categoryName;
  String? _subcategoryName;
  bool? _recommended;
  num? _subcategoryId;
  num? _categoryId;
  int quantity = 0;

  MenuModel copyWith({
    num? itemId,
    String? itemName,
    String? description,
    String? itemPrice,
    String? type,
    bool? inStock,
    String? itemImage,
    num? servingType,
    String? portion,
    String? categoryName,
    String? subcategoryName,
    bool? recommended,
    num? subcategoryId,
    num? categoryId,
  }) =>
      MenuModel(
        itemId: itemId ?? _itemId,
        itemName: itemName ?? _itemName,
        description: description ?? _description,
        itemPrice: itemPrice ?? _itemPrice,
        type: type ?? _type,
        inStock: inStock ?? _inStock,
        itemImage: itemImage ?? _itemImage,
        servingType: servingType ?? _servingType,
        portion: portion ?? _portion,
        categoryName: categoryName ?? _categoryName,
        subcategoryName: subcategoryName ?? _subcategoryName,
        recommended: recommended ?? _recommended,
        subcategoryId: subcategoryId ?? _subcategoryId,
        categoryId: categoryId ?? _categoryId,
      );
  num? get itemId => _itemId;
  String? get itemName => _itemName;
  String? get description => _description;
  String? get itemPrice => _itemPrice;
  String? get type => _type;
  bool? get inStock => _inStock;
  String? get itemImage => _itemImage;
  num? get servingType => _servingType;
  String? get portion => _portion;
  String? get categoryName => _categoryName;
  String? get subcategoryName => _subcategoryName;
  bool? get recommended => _recommended;
  num? get subcategoryId => _subcategoryId;
  num? get categoryId => _categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemId'] = _itemId;
    map['itemName'] = _itemName;
    map['description'] = _description;
    map['itemPrice'] = _itemPrice;
    map['type'] = _type;
    map['inStock'] = _inStock;
    map['itemImage'] = _itemImage;
    map['servingType'] = _servingType;
    map['portion'] = _portion;
    map['categoryName'] = _categoryName;
    map['subcategoryName'] = _subcategoryName;
    map['recommended'] = _recommended;
    map['subcategoryId'] = _subcategoryId;
    map['categoryId'] = _categoryId;
    return map;
  }

  @override
  from(json) {
    return MenuModel.fromJson(json);
  }

  void isInStock(bool value) {
    _inStock = value;
  }

  void isRecommended(bool value) {
    _recommended = value;
  }
}
