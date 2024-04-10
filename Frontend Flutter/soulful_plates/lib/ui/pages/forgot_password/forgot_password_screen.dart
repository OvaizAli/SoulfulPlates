import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/size_config.dart';
import '../../widgets/base_back_button.dart';
import '../../widgets/base_common_widget.dart';
import 'Widgets/email_username_widget.dart';
import 'Widgets/reset_password.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController>
    with BaseCommonWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) {},
      builder: (ForgotPasswordController model) {
        return Stack(
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                leading: const BaseBackButton(),
                backgroundColor: AppColor.whiteColor,
              ),
              backgroundColor: AppColor.whiteColor,
              body: _getBody(model, context),
            ),
            getProgressBar(controller.state),
          ],
        );
      },
    );
  }

  Widget _getBody(ForgotPasswordController model, BuildContext context) {
    return _getBaseContainer(model, context);
  }

  Widget _getBaseContainer(
    ForgotPasswordController model,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      padding: AppPaddings.getContentPadding(
        left: 20.rWidth(),
        right: 20.rWidth(),
        top: 10.rHeight(),
        bottom: 55.rHeight(),
      ),
      child: switchCaseOfForgotPasswordStatus(),
    );
  }

  Widget switchCaseOfForgotPasswordStatus() {
    switch (controller.forgotPasswordStatus!) {
      case ForgotPasswordStatus.enterUsername:
        return EnterEmailOrUsername();
      case ForgotPasswordStatus.resetPassword:
        return ResetPassword();
    }
  }
}
