import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/Utils/Extensions.dart';
import 'package:soulful_plates/constants/size_config.dart';

import '../../../../Utils/Validator.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/language/language_constants.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_common_widget.dart';
import '../forgot_password_controller.dart';

class EnterEmailOrUsername extends GetView<ForgotPasswordController>
    with BaseCommonWidget {
  EnterEmailOrUsername({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.rVerticalSizedBox(),
          Text(
            LanguageConst.loginPrompt,
            style: AppTextStyles.textStyleBlack22With700,
          ).paddingHorizontal8(),
          32.rVerticalSizedBox(),
          AppTextField(
            controller: controller.emailController,
            focusNode: controller.emailFocusNode,
            validator: Validations.emailValidator,
            onSubmitted: (val) {
              controller.passwordFocusNode.requestFocus();
            },
            onChanged: (val) {
              controller.update();
            },
            hintText: "Email address",
          ),
          32.rVerticalSizedBox(),
          BaseButton(
            enabled: controller.emailController.text.trim().isNotNullOrEmpty,
            text: LanguageConst.submit,
            onSubmit: () {
              if (controller.formKey.currentState?.validate() ?? false) {
                controller.validateAndSendRequest(
                    data: {"email": controller.emailController.text.trim()});
              }
            },
          ),
        ],
      ),
    );
  }
}
