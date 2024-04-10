import 'package:flutter/cupertino.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/location/address_model.dart';
import '../../../model/store_details/store_detail_model.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class StoreDetailsController extends BaseController {
  bool isEditable = false;
  StoreDetails? storeDetails; // = Utils.storeDetails;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController streetEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController stateEditingController = TextEditingController();
  TextEditingController postalCodeEditingController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode streetFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode postalCodeFocusNode = FocusNode();

  // Function to update data
  updateData() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint:
            "${EndPoints.sellerUpdateDetails}/${AppSingleton.loggedInUserProfile?.id}",
        apiCallType: ApiCallType.seller,
        parameters: {
          "storeName": firstNameEditingController.text.trim(),
          "storeEmail": emailEditingController.text.trim(),
          "storeDescription": descriptionEditingController.text.trim(),
          "storeContactNumber": mobileEditingController.text.trim()
        });
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Store details updated successfully.", false);
    } else {
      Utils.showSuccessToast("Error while updating store details.", true);
    }
    Utils.fetchLatestProfileData();
  }

  getAddress() async {
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

  void initData() {
    if (AppSingleton.loggedInUserProfile?.sellerName.isNullOrEmpty == true) {
      isEditable = true;
    }
    emailEditingController.text =
        AppSingleton.loggedInUserProfile?.sellerEmail ?? '';
    mobileEditingController.text =
        AppSingleton.loggedInUserProfile?.sellerContactNumber ?? '';
    firstNameEditingController.text =
        AppSingleton.loggedInUserProfile?.sellerName ?? '';
    descriptionEditingController.text =
        AppSingleton.loggedInUserProfile?.storeDescription ?? '';
  }
}
