import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/model/menu/menu_category_model.dart';
import 'package:soulful_plates/model/menu/sub_category_model.dart';

import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class CreateMenuController extends BaseController {
  TextEditingController itemName = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController serviceType = TextEditingController();
  TextEditingController portion = TextEditingController();
  FocusNode itemNameFocus = FocusNode();
  FocusNode itemPriceFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  FocusNode serviceTypeFocus = FocusNode();
  FocusNode portionFocus = FocusNode();

  bool inStock = false;
  bool isRecommended = false;

  List<String> type = ["Veg", "NonVeg", "Eggs"];
  String selectType = "Veg";

  MenuCategory? selectCategory;

  SubCategoryModel? selectSubCategory;

  onSave() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.addMenuItem,
        apiCallType: ApiCallType.seller,
        parameters: {
          "itemName": itemName.text.trim(),
          "itemImage": "",
          "itemPrice": itemPrice.text.trim(),
          "type": selectType,
          "storeId": AppSingleton.storeId,
          "categoryId": selectCategory?.categoryId ?? 0,
          "subcategoryId": selectSubCategory?.subCategoryId ?? 0,
          "servingType": serviceType.text.trim(),
          "portion": portion.text.trim(),
          "inStock": inStock,
          "recommended": isRecommended,
          "description": description.text.trim()
        });
    print("This is the menu item ${response}");
    await Utils.fetchUpdatedMenuItemList(setLoaderState);
    Get.back();
  }
}
