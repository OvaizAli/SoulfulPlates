import 'package:soulful_plates/model/menu/sub_category_model.dart';
import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

/// categoryId : 1
/// categoryName : "Cate"
/// storeId : "1"

class MenuCategory extends GenericModel {
  MenuCategory({
    num? categoryId,
    String? categoryName,
    String? storeId,
  }) {
    _categoryId = categoryId;
    _categoryName = categoryName;
    _storeId = storeId;
  }

  MenuCategory.fromJson(dynamic json) {
    _categoryId = json['categoryId'];
    _categoryName = json['categoryName'];
    _storeId = json['storeId'];
  }

  num? _categoryId;
  String? _categoryName;
  String? _storeId;

  MenuCategory copyWith({
    num? categoryId,
    String? categoryName,
    String? storeId,
  }) =>
      MenuCategory(
        categoryId: categoryId ?? _categoryId,
        categoryName: categoryName ?? _categoryName,
        storeId: storeId ?? _storeId,
      );

  num? get categoryId => _categoryId;

  String? get categoryName => _categoryName;

  String? get storeId => _storeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = _categoryId;
    map['categoryName'] = _categoryName;
    map['storeId'] = _storeId;
    return map;
  }

  List<SubCategoryModel> subcategories = [];

  void addSubCategory(SubCategoryModel newSubCategory) {
    if (!subcategories.contains(newSubCategory)) {
      subcategories.add(newSubCategory);
    }
  }

  @override
  from(json) {
    return MenuCategory.fromJson(json);
  }
}
