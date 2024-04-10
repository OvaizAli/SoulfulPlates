import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/model/profile/user_profile.dart';
import 'package:soulful_plates/network/network_interfaces/end_points.dart';
import 'package:soulful_plates/utils/shared_prefs.dart';

import '../../../app_singleton.dart';
import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../model/location/address_model.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../routing/route_names.dart';
import '../../../utils/extensions.dart';
import '../../../utils/utils.dart';

class LoginController extends BaseController {
  bool obscureText = true;

  TextEditingController emailEditingController =
      TextEditingController(text: '');
  TextEditingController passwordEditingController =
      TextEditingController(text: '');

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  void login() async {
    try {
      setLoaderState(ViewStateEnum.busy);
      final UserProfile? userModel = await ApiCall().call<UserProfile>(
          method: RequestMethod.post,
          endPoint: EndPoints.login,
          obj: UserProfile(),
          apiCallType: ApiCallType.simple,
          parameters: {
            "username": emailEditingController.text.trim(),
            "password": passwordEditingController.text.trim()
          });
      if (userModel != null) {
        await UserPreference.setValue(
            key: SharedPrefKey.userProfileData.name,
            value: userModel.toRawJson());
        AppSingleton.loggedInUserProfile = userModel;
        setLoaderState(ViewStateEnum.idle);
        Utils.showSuccessToast("Logged in successfully.", false);
        await UserPreference.setValue(
            key: SharedPrefKey.isLogin.name, value: true);
        await UserPreference.setValue(
            key: SharedPrefKey.email.name,
            value: emailEditingController.text.trim());
        await UserPreference.setValue(
            key: SharedPrefKey.passcode.name,
            value: passwordEditingController.text.trim());
        if (!AppSingleton.isBuyer() && userModel.sellerName.isNullOrEmpty) {
          onWidgetDidBuild(callback: () {
            Get.offAllNamed(storeDetailsViewRoute);
          });
        } else {
          List<AddressModel> result = await Utils.getAddress();
          if (result.isNotNullOrEmpty) {
            AppSingleton.storeId =
                AppSingleton.loggedInUserProfile?.sellerId?.toInt() ?? 1;
            Get.offAllNamed(dashboardViewRoute);
          } else {
            Get.offAllNamed(editLocationViewRoute);
          }
        }
      } else {
        setLoaderState(ViewStateEnum.idle);
        Utils.showSuccessToast(
            "Issue while logging in. Please try again later.", true);
      }
    } catch (e) {
      setLoaderState(ViewStateEnum.idle);
      debugPrint('This is error $e');
      Utils.showSuccessToast(e.toString(), true);
    }
  }
}
