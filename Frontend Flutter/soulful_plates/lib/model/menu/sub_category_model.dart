import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

import 'menu_model.dart';

/// subCategoryId : 1
/// subCategoryName : null
/// categoryId : 2

class SubCategoryModel extends GenericModel {
  SubCategoryModel({
    num? subCategoryId,
    String? subCategoryName,
    num? categoryId,
  }) {
    _subCategoryId = subCategoryId;
    _subCategoryName = subCategoryName;
    _categoryId = categoryId;
  }

  SubCategoryModel.fromJson(dynamic json) {
    _subCategoryId = json['subCategoryId'];
    _subCategoryName = json['subCategoryName'];
    _categoryId = json['categoryId'];
  }
  num? _subCategoryId;
  String? _subCategoryName;
  num? _categoryId;
  SubCategoryModel copyWith({
    num? subCategoryId,
    String? subCategoryName,
    num? categoryId,
  }) =>
      SubCategoryModel(
        subCategoryId: subCategoryId ?? _subCategoryId,
        subCategoryName: subCategoryName ?? _subCategoryName,
        categoryId: categoryId ?? _categoryId,
      );
  num? get subCategoryId => _subCategoryId;
  String? get subCategoryName => _subCategoryName;
  num? get categoryId => _categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subCategoryId'] = _subCategoryId;
    map['subCategoryName'] = _subCategoryName;
    map['categoryId'] = _categoryId;
    return map;
  }

  List<MenuModel> items = [];
// Method to add a new menu item to the current subcategory
  void addMenuItem(MenuModel newItem) {
    if (!items.contains(newItem)) {
      items.add(newItem);
    }
  }

  @override
  from(json) {
    return SubCategoryModel.fromJson(json);
  }
}
