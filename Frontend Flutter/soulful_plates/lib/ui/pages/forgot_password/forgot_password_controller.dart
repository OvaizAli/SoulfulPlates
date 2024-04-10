import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/Utils/Extensions.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/end_points.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../routing/route_names.dart';
import '../../../utils/utils.dart';

class ForgotPasswordController extends BaseController {
  var formKey = GlobalKey<FormState>();
  var formKeyOTP = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode verificationCodeFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  bool isPasswordHide = true;
  bool isConfirmPasswordHide = true;

  bool isUppar = false,
      isLower = false,
      isSpecialCharacter = false,
      isNumber = false;

  ForgotPasswordStatus? forgotPasswordStatus =
      ForgotPasswordStatus.enterUsername;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.runtimeType == String) {
      emailController.text = Get.arguments;
    }
  }

  void navigateToNext() {
    forgotPasswordStatus = ForgotPasswordStatus.resetPassword;
    update();
  }

  void validateAndResetPassword({data}) async {
    if (!verificationCodeController.text.isNotNullOrEmpty) {
      Utils.showSuccessToast(
          "Please enter the 4 digit code sent to your email.", false);
      return;
    }
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.resetPassword,
        apiCallType: ApiCallType.simple,
        parameters: data);
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Password reset successfully.", true);
      onWidgetDidBuild(callback: () {
        Get.offAllNamed(loginViewRoute);
      });
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while fetching information. Please try again later.", false);
    }
  }

  void validateAndSendRequest({data}) async {
    setLoaderState(ViewStateEnum.busy);
    var response = await ApiCall().call(
        method: RequestMethod.post,
        endPoint: EndPoints.forgotPassword,
        apiCallType: ApiCallType.simple,
        parameters: data);
    if (response != null && response['code'] == 1) {
      Utils.showSuccessToast("Verification code sent successfully.", true);
      forgotPasswordStatus = ForgotPasswordStatus.resetPassword;
      setLoaderState(ViewStateEnum.idle);
      update();
    } else {
      setLoaderState(ViewStateEnum.idle);
      Utils.showSuccessToast(
          "Issue while fetching information. Please try again later.", false);
    }
  }
}

enum ForgotPasswordStatus { enterUsername, resetPassword }
