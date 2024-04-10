import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/Utils/Extensions.dart';
import 'package:soulful_plates/routing/route_names.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/selected_item_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';

class ViewCartController extends BaseController {
  List<SelectedItemModel> selectedItems = [];
  double subtotal = 0;
  double deliveryCharges = 0;
  double tax = 0;
  double total = 0;

  final instructionController = TextEditingController();

  void getCount() {
    // Calculate subtotal
    subtotal = selectedItems.fold(
        0, (total, item) => total + item.calculateSubtotal());

    // Calculate delivery charges (10% of subtotal)
    deliveryCharges = (subtotal * 0.1).roundToDouble();

    // Calculate tax (7% of subtotal including delivery charges)
    tax = ((subtotal + deliveryCharges) * 0.07).roundToDouble();

    // Calculate total
    total = (subtotal + deliveryCharges + tax).roundToDouble();
  }

  void addToCart(int itemId, String itemName, String price) {
    bool found = false;
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].menuItemId == itemId) {
        selectedItems[i].quantity += 1;
        found = true;
        break;
      }
    }
    if (!found) {
      selectedItems.add(SelectedItemModel(
          menuItemId: itemId, itemName: itemName, quantity: 1, price: price));
    }
    getCount();
    update();
  }

  void removeFromCart(int itemId, String itemName) {
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].menuItemId == itemId) {
        selectedItems[i].quantity -= 1;
        if (selectedItems[i].quantity == 0) {
          selectedItems.removeAt(i);
        }
        break;
      }
    }
    getCount();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    selectedItems = Get.arguments;
    getCount();
    onWidgetDidBuild(callback: () {
      update();
    });
  }

  createOrder({data}) async {
    print("THis is data ${jsonEncode(data)}");
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.createOrder,
        apiCallType: ApiCallType.user,
        parameters: data);
    // {"code":1,"description":"Order Created.","data":{"orderId":5}}
    print("Response $response ");
    print("Response ${response["data"]["orderId"]} ");
    setLoaderState(ViewStateEnum.idle);
    update();
    data["orderId"] = response["data"]["orderId"];
    data["subtotal"] = subtotal;
    data["tax"] = tax;
    data["deliveryCharges"] = deliveryCharges;
    data["total"] = total;
    Get.toNamed(cartPaymentViewRoute, arguments: data);
  }
}
