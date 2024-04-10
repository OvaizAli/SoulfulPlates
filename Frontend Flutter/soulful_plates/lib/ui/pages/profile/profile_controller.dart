import 'package:flutter/cupertino.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/model/profile/user_profile.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../utils/utils.dart';

class ProfileController extends BaseController {
  UserProfile? userProfile;

  bool isEditable = false;

  @override
  void onInit() {
    super.onInit();
    userProfile = AppSingleton.loggedInUserProfile;
    emailEditingController.text = userProfile?.email ?? '';
    mobileEditingController.text = userProfile?.contactNumber ?? '';
    firstNameEditingController.text = userProfile?.username ?? '';
  }

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController firstNameEditingController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();

  // onSave() async {
  //   UserProfile userModel = UserProfile(
  //       username: firstNameEditingController.text,
  //       email: emailEditingController.text,
  //       contactNumber: mobileEditingController.text);
  //
  //   await UserPreference.setValue(
  //       key: SharedPrefKey.userProfileData.name, value: userModel.toJson());
  //   // await UserPreference.setValue(
  //   //     key: SharedPrefKey.token.name, value: userModel.token);
  //   AppSingleton.loggedInUserProfile = userModel;
  //
  //   Utils.fetchLatestProfileData();
  //   userProfile = userModel;
  //   isEditable = !isEditable;
  //
  //   update();
  // }

  // Function to update data
  updateData() async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.put,
        endPoint:
            "${EndPoints.updateUser}/${AppSingleton.loggedInUserProfile?.id}",
        apiCallType: ApiCallType.seller,
        parameters: {
          "username": firstNameEditingController.text.trim(),
          "email": emailEditingController.text.trim(),
          "contactNumber": mobileEditingController.text.trim(),
        });
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("User details updated successfully.", false);
    } else {
      Utils.showSuccessToast("Error while updating user details.", true);
    }
    Utils.fetchLatestProfileData();
    update();
  }
}
