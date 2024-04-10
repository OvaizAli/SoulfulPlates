import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soulful_plates/constants/app_icons.dart';
import 'package:soulful_plates/utils/shared_prefs.dart';

import '../app_singleton.dart';
import '../constants/app_colors.dart';
import '../constants/enums/view_state.dart';
import '../constants/language/language_constants.dart';
import '../constants/size_config.dart';
import '../model/location/address_model.dart';
import '../model/location/location_model.dart';
import '../model/menu/menu_category_model.dart';
import '../model/menu/menu_model.dart';
import '../model/menu/sub_category_model.dart';
import '../model/profile/user_profile.dart';
import '../model/store_details/store_detail_model.dart';
import '../network/network_interfaces/end_points.dart';
import '../network/network_interfaces/i_dio_singleton.dart';
import '../network/network_utils/api_call.dart';
import '../routing/route_names.dart';
import '../ui/widgets/base_loading_widget.dart';
import 'extensions.dart';

class Utils {
  static FilteringTextInputFormatter numberFormatter =
      FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  static FilteringTextInputFormatter textFormatter =
      FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  static FilteringTextInputFormatter emailRules =
      FilteringTextInputFormatter.allow(RegExp(r'[+~/>*<!#$%^&()=?/;:,€]'));

  static int timeDuration = 300;
  static Duration duration300 = Duration(milliseconds: timeDuration);

  static Future<bool> checkInternetConnectionAndShowMessage() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showSuccessToast(LanguageConst.internetNotAvailable, true);
      return false;
    } else {
      return true;
    }
  }

  static getStringDateFromTime(String inputDate) {
    String inputDateString = inputDate;
    DateTime dateTime = DateTime.parse(inputDateString);

    String formattedDate = DateFormat.yMMMd().format(dateTime);
    return formattedDate;
  }

  static String padString(String input, int targetLength, String padChar) {
    if (input.length >= targetLength) {
      return input;
    } else {
      int padLength = targetLength - input.length;
      String padding = padChar * padLength;
      return input + padding;
    }
  }

  static showSuccessToast(String message, bool isError) {
    Fluttertoast.showToast(
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? AppColor.redColor : AppColor.blackTextColor,
      textColor: AppColor.whiteTextColor,
      msg: message.capitalizeFirst ?? message,
    );
  }

  static BoxBorder customBorderWidget() {
    return Border.all(
      color: AppColor.primaryColor,
      width: 1.5,
    );
  }

  static Widget emptyRefreshListWidget(
      {required String listEmptyMessage,
      Color? color,
      bool isLoading = false,
      required Function() onTap}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: isLoading
          ? const Center(child: BaseLoadingWidget()).paddingAll16()
          : GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh,
                      color: AppColor.blackColor,
                      size: 24,
                    ),
                    8.rVerticalSizedBox(),
                    Text(
                      listEmptyMessage,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ).paddingAll16(),
    );
  }

  static List<LocationModel> locationList = [
    LocationModel(
      latitude: 44.6488,
      longitude: -63.5752,
      address: "123 Waterfront Dr, Halifax",
      locationName: "Anjali Home",
    ),
    LocationModel(
      latitude: 44.6714,
      longitude: -63.5772,
      address: "456 Spring Garden Rd, Halifax",
      locationName: "Dalhousie library",
    ),
    LocationModel(
      latitude: 44.6351,
      longitude: -63.5753,
      address: "789 Citadel Hill, Halifax",
      locationName: "Nikul Office",
    ),
  ];

  static addLocation({
    required double latitude,
    required double longitude,
    required String address,
    required String locationName,
  }) {
    locationList.add(
      LocationModel(
        latitude: latitude,
        longitude: longitude,
        address: address,
        locationName: locationName,
      ),
    );
  }

  static StoreDetails? storeDetails = StoreDetails(
    email: 'md2Retro@gmail.com',
    mobile: '4564561230',
    firstName: 'Md\'s Retro',
    street: '2320 Brunswick St',
    city: 'Halifax',
    state: 'Nova Scotia',
    postalCode: 'B3K2Z2',
  );

  String getFoodTypeIcon(String type) {
    if (type.toLowerCase() == 'veg') {
      return AppIcons.vegIcon;
    }
    if (type.toLowerCase() == 'nonveg') {
      return AppIcons.nonVegIcon;
    }
    return AppIcons.eggIcon;
  }

  static getAddress() async {
    try {
      var response = await ApiCall().call<AddressModel>(
        method: RequestMethod.get,
        endPoint:
            "${EndPoints.addAddress}/${AppSingleton.loggedInUserProfile?.id}",
        obj: AddressModel(),
        apiCallType: ApiCallType.seller,
      );
      print("Response $response ");
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> login() async {
    try {
      String email = UserPreference.getValue(key: SharedPrefKey.email.name);
      String pass = UserPreference.getValue(key: SharedPrefKey.passcode.name);
      final UserProfile? userModel = await ApiCall().call<UserProfile>(
          method: RequestMethod.post,
          endPoint: EndPoints.login,
          obj: UserProfile(),
          apiCallType: ApiCallType.simple,
          parameters: {"username": email, "password": pass});
      if (userModel != null) {
        await UserPreference.setValue(
            key: SharedPrefKey.userProfileData.name,
            value: userModel.toRawJson());
        AppSingleton.loggedInUserProfile = userModel;
        Utils.showSuccessToast("Logged in successfully.", false);
        await UserPreference.setValue(
            key: SharedPrefKey.isLogin.name, value: true);
        await UserPreference.setValue(
            key: SharedPrefKey.email.name, value: email);
        await UserPreference.setValue(
            key: SharedPrefKey.passcode.name, value: pass);
        if (!AppSingleton.isBuyer() && userModel.sellerName.isNullOrEmpty) {
          Get.offAllNamed(storeDetailsViewRoute);
        } else {
          List<AddressModel> result = await Utils.getAddress();
          if (result.isNotNullOrEmpty) {
            AppSingleton.storeId =
                AppSingleton.loggedInUserProfile?.sellerId?.toInt() ?? 1;
            Get.offAllNamed(dashboardViewRoute);
          } else {
            Get.offAllNamed(
              editLocationViewRoute,
            );
          }
        }
      } else {
        Utils.showSuccessToast(
            "Issue while logging in. Please try again later.", true);
        Get.offAllNamed(loginViewRoute);
      }
      return false;
    } catch (e) {
      debugPrint('This is error $e');
      // Utils.showSuccessToast(e.toString(), true);
      Get.offAllNamed(loginViewRoute);
      return false;
    }
  }

  static fetchLatestProfileData() async {
    try {
      String email = UserPreference.getValue(key: SharedPrefKey.email.name);
      String pass = UserPreference.getValue(key: SharedPrefKey.passcode.name);
      final UserProfile? userModel = await ApiCall().call<UserProfile>(
          method: RequestMethod.post,
          endPoint: EndPoints.login,
          obj: UserProfile(),
          apiCallType: ApiCallType.simple,
          parameters: {"username": email, "password": pass});
      if (userModel != null) {
        await UserPreference.setValue(
            key: SharedPrefKey.userProfileData.name,
            value: userModel.toRawJson());
        AppSingleton.loggedInUserProfile = userModel;
      }
    } catch (e) {
      debugPrint('This is error $e');
    }
  }

  static List<MenuCategory> menuCategory = [];

  static List<MenuModel> menuItems = [];

  static formatMenuItemsToCategory() async {
    // Create categories and subcategories
    menuItems.forEach((menuItem) {
      // Find category by name or create new if not exists
      MenuCategory category = menuCategory.firstWhere(
          (cat) => cat.categoryName == menuItem.categoryName, orElse: () {
        MenuCategory newCategory = MenuCategory(
            categoryId: menuItem.categoryId ?? 0,
            categoryName: menuItem.categoryName ?? '',
            storeId: AppSingleton.storeId.toString());
        menuCategory.add(newCategory);
        return newCategory;
      });

      // Check if the item has a subcategory
      if (menuItem.subcategoryName != null) {
        // Find subcategory by name or create new if not exists
        SubCategoryModel subcategory = category.subcategories.firstWhere(
            (subcat) => subcat.subCategoryName == menuItem.subcategoryName,
            orElse: () {
          SubCategoryModel newSubcategory = SubCategoryModel(
              subCategoryId: menuItem.subcategoryId ?? 0,
              subCategoryName: menuItem.subcategoryName ?? '',
              categoryId: menuItem.categoryId);
          category.addSubCategory(newSubcategory);
          return newSubcategory;
        });

        // Add the menu item to the subcategory
        subcategory.addMenuItem(menuItem);
      } else {
        // Add the menu item to the category directly
//       category.addMenuItem(menuItem);
      }
    });

    // Print categories and subcategories
    menuCategory.forEach((category) {
      print("Category: ${category}");
      category.subcategories.forEach((subcategory) {
        print("  Subcategory: ${subcategory.subCategoryName}");
        subcategory.items.forEach((item) {
          print("    Item: ${item.itemName}");
        });
      });
    });
  }

  static fetchUpdatedMenuItemList(
      Function(ViewStateEnum state) setLoaderState) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call<MenuModel>(
      method: RequestMethod.get,
      endPoint: "${EndPoints.getMenuItem}/${AppSingleton.storeId}",
      obj: MenuModel(),
      apiCallType: ApiCallType.seller,
    );
    menuItems = response;
    menuCategory = [];
    await formatMenuItemsToCategory();
    setLoaderState(ViewStateEnum.idle);
  }

  static getRandomTimeLeft() {
    // Create an instance of Random class
    var random = Random();
    // Generate a random number between 0 and 10
    int randomNumber =
        random.nextInt(11); // Generates a random integer from 0 to 10
    return randomNumber;
  }

  static getRandomTimeLeftPrep() {
    // Create an instance of Random class
    var random = Random(10);
    // Generate a random number between 0 and 10
    int randomNumber =
        random.nextInt(40); // Generates a random integer from 0 to 10
    return randomNumber;
  }

  static List<MenuCategory> menuCategoryList = [];

  static fetchCategoryList(Function(ViewStateEnum state) setLoaderState) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call<MenuCategory>(
      method: RequestMethod.get,
      endPoint: EndPoints.getCategoriesByStore + "/${AppSingleton.storeId}",
      obj: MenuCategory(),
      apiCallType: ApiCallType.seller,
    );
    menuCategoryList = response;
    setLoaderState(ViewStateEnum.idle);
  }

  static List<SubCategoryModel> menuSubCategoryList = [];

  static fetchSubCategoryList(
      Function(ViewStateEnum state) setLoaderState, String categoryId) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call<SubCategoryModel>(
      method: RequestMethod.get,
      endPoint: "${EndPoints.getSubCategories}/${categoryId}",
      obj: SubCategoryModel(),
      apiCallType: ApiCallType.seller,
    );
    menuSubCategoryList = response;
    setLoaderState(ViewStateEnum.idle);
  }
}
