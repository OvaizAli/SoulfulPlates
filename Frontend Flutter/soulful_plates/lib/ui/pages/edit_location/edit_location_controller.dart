import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:soulful_plates/model/location/address_model.dart';
import 'package:soulful_plates/routing/route_names.dart';

import '../../../app_singleton.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/data_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class EditLocationController extends BaseController {
  DataModel? dataModel;
// Controllers for text fields
  TextEditingController nameController = TextEditingController();
  Prediction? initialValue;
  String address = "";

  String lat = "";
  String long = "";

  AddressModel? addressModel;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    addressModel = Get.arguments;
    if (addressModel != null) {
      nameController.text = addressModel?.label ?? '';
      lat = addressModel?.latitude?.toString() ?? '';
      long = addressModel?.longitude?.toString() ?? '';
      address = addressModel?.street ?? '';
      isEdit = true;
    } else {
      isEdit = false;
    }
  }

  void addAddress() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint:
            "${EndPoints.addAddress}/${AppSingleton.loggedInUserProfile?.id}",
        apiCallType: ApiCallType.seller,
        parameters: {
          "street": address,
          "city": "Halifax",
          "state": "Halifax",
          "postalCode": "B3k 2Z2",
          "country": "Canada",
          "latitude": lat,
          "longitude": long,
          "label": nameController.text.trim()
        });
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Address created successfully.", true);
      if (isEdit) {
        Get.back();
      } else {
        AppSingleton.storeId =
            AppSingleton.loggedInUserProfile?.sellerId?.toInt() ?? 1;
        Get.offAllNamed(dashboardViewRoute);
      }
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while creating Address. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }

  void editAddress() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint:
            "${EndPoints.addAddress}/${AppSingleton.loggedInUserProfile?.id}/${addressModel?.addressId}",
        apiCallType: ApiCallType.seller,
        parameters: {
          "street": address,
          "city": "Halifax",
          "state": "Halifax",
          "postalCode": "B3k 2Z2",
          "country": "Canada",
          "latitude": lat,
          "longitude": long,
          "label": nameController.text.trim()
        });
    print("Response $response ");
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Address created successfully.", true);
      if (isEdit) {
        Get.back();
      } else {
        AppSingleton.storeId =
            AppSingleton.loggedInUserProfile?.sellerId?.toInt() ?? 1;
        Get.offAllNamed(dashboardViewRoute);
      }
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while creating Address. Please try again later.", false);
    }
    setLoaderState(ViewStateEnum.idle);
    update();
  }
}
