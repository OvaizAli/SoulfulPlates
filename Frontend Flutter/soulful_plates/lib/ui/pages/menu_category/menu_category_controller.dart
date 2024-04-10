import 'package:flutter/cupertino.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/model/menu/sub_category_model.dart';

import '../../../controller/base_controller.dart';
import '../../../model/menu/menu_category_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class MenuCategoryController extends BaseController {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();

  // List<MenuCategory> menuCategories = [];
  // List<SubCategoryModel> subCategories = [];

  MenuCategory? selectedCategory;

  @override
  void onInit() async {
    super.onInit();
    fetchCategory();
  }

  fetchCategory() async {
    await Utils.fetchCategoryList(setLoaderState);
    update();
  }

  fetchSubCategory() async {
    await Utils.fetchSubCategoryList(
        setLoaderState, selectedCategory?.categoryId?.toString() ?? "");
    update();
  }

  void addCategory() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.addCategory,
        apiCallType: ApiCallType.seller,
        parameters: {
          "categoryName": categoryController.text.trim(),
          "storeId": AppSingleton.storeId
        });
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      categoryController.clear();
      await Utils.fetchCategoryList(setLoaderState);
      Utils.showSuccessToast("Category created successfully.", true);
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while creating category. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  void addSubCategory() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.addSubCategory,
        apiCallType: ApiCallType.seller,
        parameters: {
          "categoryId": selectedCategory?.categoryId,
          "subCategoryName": subCategoryController.text.trim(),
          "storeId": AppSingleton.storeId
        });
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Sub Category created successfully.", true);
      await Utils.fetchSubCategoryList(
          setLoaderState, selectedCategory?.categoryId?.toString() ?? '');
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while creating sub category. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  updateSubCategoryName(SubCategoryModel subCategoryModel, String name) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.put,
        endPoint:
            "${EndPoints.addSubCategory}/${subCategoryModel.subCategoryId}",
        apiCallType: ApiCallType.seller,
        parameters: {
          "categoryId": selectedCategory?.categoryId,
          "subCategoryName": name,
          "storeId": AppSingleton.storeId
        });
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Sub Category created successfully.", true);
      await Utils.fetchSubCategoryList(
          setLoaderState, selectedCategory?.categoryId?.toString() ?? '');
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while creating sub category. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  updateCategoryName(MenuCategory menuCategory, String name) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.put,
        endPoint: "${EndPoints.addCategory}/${menuCategory.categoryId}",
        apiCallType: ApiCallType.seller,
        parameters: {"categoryName": name, "storeId": AppSingleton.storeId});
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Sub Category created successfully.", true);
      await Utils.fetchCategoryList(setLoaderState);
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while creating sub category. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }
}
