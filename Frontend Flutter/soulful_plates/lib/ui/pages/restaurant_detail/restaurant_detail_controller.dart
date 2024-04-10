import 'package:get/get.dart';
import 'package:soulful_plates/model/selected_item_model.dart';
import 'package:soulful_plates/model/store_details/restaurant_model.dart';

import '../../../app_singleton.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/menu/menu_model.dart';
import '../../../model/profile/user_profile.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class RestaurantDetailController extends BaseController {
  UserProfile? userProfile;
  RestaurantModel? restaurantModel;
  bool isEditable = true;
  double ratingCount = 4.5;

  @override
  void onInit() {
    super.onInit();
    userProfile = AppSingleton.loggedInUserProfile;
    restaurantModel = Get.arguments;
    getMenuItems();
    getAverageRating();
  }

  List<SelectedItemModel> selectedItems = [];

  void addToCart(int itemId, String itemName, String price, int count) {
    bool found = false;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].menuItemId == itemId) {
        selectedItems[i].quantity = count;
        found = true;
        break;
      }
    }
    if (!found) {
      selectedItems.add(SelectedItemModel(
          menuItemId: itemId,
          itemName: itemName,
          quantity: count,
          price: price));
    }
    update();
  }

  void removeFromCart(int itemId, String itemName, int count) {
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].menuItemId == itemId) {
        selectedItems[i].quantity = count;
        if (selectedItems[i].quantity == 0) {
          selectedItems.removeAt(i);
        }
        break;
      }
    }
    update();
  }

  int getSelectedItemQuantity(String itemId) {
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].menuItemId.toString() == itemId) {
        return selectedItems[i].quantity;
      }
    }
    return 0; // Return 0 if item not found
  }

  List<MenuModel> menuItems = [];

  void getMenuItems() async {
    setLoaderState(ViewStateEnum.busy);
    await Utils.fetchUpdatedMenuItemList(setLoaderState);
    menuItems = Utils.menuItems;
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  void getAverageRating() async {
    var response = await ApiCall().call(
      method: RequestMethod.get,
      endPoint: "${EndPoints.getAverageRating}/${restaurantModel?.storeId}",
      apiCallType: ApiCallType.user,
    );
    print("Response $response ");
    ratingCount = response['data'] ?? 4.5;
    if (ratingCount == 0.0) {
      ratingCount = 5;
    }
    update();
  }

  void addToWishList(MenuModel menuModel) async {
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.addWishList,
        apiCallType: ApiCallType.user,
        parameters: {
          "userId": AppSingleton.loggedInUserProfile?.id,
          "storeId": AppSingleton.storeId,
          "menuItemId": menuModel.itemId,
          "itemName": menuModel.itemName,
          "itemPrice": menuModel.itemPrice,
          "storeName": restaurantModel?.storeName,
          "storeEmail": restaurantModel?.storeEmail,
        });
    Utils.showSuccessToast("Item Added to WishList", false);
    update();
  }
}
