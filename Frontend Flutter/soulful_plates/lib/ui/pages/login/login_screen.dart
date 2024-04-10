import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/ui/widgets/app_text_field.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/size_config.dart';
import '../../../routing/route_names.dart';
import '../../../utils/extensions.dart';
import '../../../utils/validator.dart';
import '../../widgets/base_button.dart';
import '../../widgets/base_common_widget.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> with BaseCommonWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (LoginController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AppIcons.logo,
                  width: 150,
                ),
              ),
              24.rVerticalSizedBox(),
              Text(
                'Sign In to\nyour Account',
                style: AppTextStyles.textStyleBlack22With700,
              ),
              16.rVerticalSizedBox(),
              Text(
                'Username',
                style: AppTextStyles.textStyleBlackTwo12With400,
              ),
              8.rVerticalSizedBox(),
              AppTextField(
                controller: controller.emailEditingController,
                focusNode: controller.emailFocusNode,
                validator: Validations.isNotEmpty,
                onSubmitted: (val) {
                  controller.passwordFocusNode.requestFocus();
                },
                hintText: 'Username',
              ),
              Text(
                'Password',
                style: AppTextStyles.textStyleBlackTwo12With400,
              ),
              8.rVerticalSizedBox(),
              AppTextField(
                controller: controller.passwordEditingController,
                focusNode: controller.passwordFocusNode,
                validator: Validations.passwordValidator,
                onSubmitted: (val) {
                  if (controller.formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
                obscureText: controller.obscureText,
                hintText: 'Password',
                prefixWidget: const Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: AppColor.blackTextColor,
                ),
                suffixWidget: InkWell(
                  onTap: () {
                    controller.obscureText = !controller.obscureText;
                    controller.update();
                  },
                  child: Icon(
                    controller.obscureText
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    size: 20,
                    color: AppColor.blackTextColor,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      child: Text(
                        'Forgot password?',
                        style: AppTextStyles.textStyleBlue14With400,
                      ),
                      onTap: () async {
                        Get.toNamed(forgotPasswordPageViewRoute);
                      })
                ],
              ),
              40.rVerticalSizedBox(),
              getSignInButton(),
              20.rVerticalSizedBox(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(signUpViewRoute);
                    },
                    child: Text(
                      'Don\'t have account? Sign up',
                      style: AppTextStyles.textStylePrimary14With400,
                    ),
                  ),
                ],
              ),
              16.rVerticalSizedBox(),
            ],
          ).paddingAll16(),
        ),
      ),
    );
  }

  getSignInButton() {
    if (controller.state == ViewStateEnum.busy) {
      return const Center(child: CircularProgressIndicator());
    }
    return BaseButton(
        text: 'Sign In',
        onSubmit: () async {
          // Get.offAllNamed(dashboardViewRoute);
          // return;
          if (controller.formKey.currentState!.validate()) {
            controller.login();
          }
        });
    // });
  }
}
