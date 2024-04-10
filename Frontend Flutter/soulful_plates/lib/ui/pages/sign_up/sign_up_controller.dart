import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/network/network_interfaces/end_points.dart';
import 'package:soulful_plates/utils/utils.dart';

import '../../../constants/enums/view_state.dart';
import '../../../controller/base_controller.dart';
import '../../../network/network_interfaces/i_dio_singleton.dart';
import '../../../network/network_utils/api_call.dart';
import '../../../routing/route_names.dart';
import '../../../utils/extensions.dart';

class SignUpController extends BaseController {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  bool obscureTwoText = true;
  bool obscureText = true;

  final formKey = GlobalKey<FormState>();

  Future<void> signUpUser({data}) async {
    try {
      setLoaderState(ViewStateEnum.busy);
      var response = await ApiCall().call(
          method: RequestMethod.post,
          endPoint: EndPoints.signup,
          apiCallType: ApiCallType.simple,
          parameters: data);
      if (response != null && response['code'] == 1) {
        Utils.showSuccessToast("Account created successfully.", true);
        onWidgetDidBuild(callback: () {
          Get.offAllNamed(loginViewRoute);
        });
      } else {
        setLoaderState(ViewStateEnum.idle);
        Utils.showSuccessToast(
            "Issue while creating user. Please try again later.", false);
      }
    } catch (e) {
      setLoaderState(ViewStateEnum.idle);
      debugPrint('This is error $e');
      Utils.showSuccessToast(e.toString(), false);
    }
  }
}
