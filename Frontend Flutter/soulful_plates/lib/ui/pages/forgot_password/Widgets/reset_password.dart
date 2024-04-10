import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/size_config.dart';

import '../../../../../../Utils/Extensions.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../constants/language/language_constants.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_common_widget.dart';
import '../forgot_password_controller.dart';
import 'otp_field.dart';

class ResetPassword extends GetView<ForgotPasswordController>
    with BaseCommonWidget {
  ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyOTP,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.rVerticalSizedBox(),
          Text(
            LanguageConst.otpPrompt,
            style: AppTextStyles.textStyleBlack22With700,
          ).paddingHorizontal8(),
          8.rVerticalSizedBox(),
          Text(
            LanguageConst.otpPrompt2,
            style: AppTextStyles.textStyleBlack16With400,
          ).paddingHorizontal8(),
          32.rVerticalSizedBox(),
          OTPInput(controller: controller),

          16.rVerticalSizedBox(),

          AppTextField(
            controller: controller.passwordController,
            focusNode: controller.passwordFocusNode,
            keyboardType: TextInputType.text,
            hintText: LanguageConst.newPassword,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            suffixWidget: InkWell(
              onTap: () {
                controller.isPasswordHide = !controller.isPasswordHide;
                controller.update();
              },
              child: Icon(
                controller.isPasswordHide
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 20,
                color: AppColor.blackTextColor,
              ),
            ),
            obscureText: controller.isPasswordHide,
            obscuringCharacter: '*',
            onTap: () {
              controller.update();
            },
            onChanged: (val) async {
              controller.isUppar = val.contains(RegExp(r'[A-Z]'));
              controller.isNumber = val.contains(RegExp(r'[0-9]'));
              controller.isLower = val.contains(RegExp(r'[a-z]'));
              controller.isSpecialCharacter =
                  val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
              controller.update();
            },
            onSubmitted: (val) async {
              FocusScope.of(context)
                  .requestFocus(controller.confirmPasswordFocusNode);
            },
          ),
          Wrap(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    size: SizeConfig.font14,
                    color: (controller.passwordController.text.length > 8)
                        ? AppColor.greenColor
                        : Colors.red,
                  ),
                  2.rHorizontalSizedBox(),
                  Text(
                    LanguageConst.atLeast8Char,
                    style: AppTextStyles.textStyle400(
                      textColor: (controller.passwordController.text.length > 8)
                          ? AppColor.greenColor
                          : Colors.red,
                      fontSize: SizeConfig.font12,
                    ),
                  ),
                ],
              ).paddingSideOnly(top: 2, right: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    size: SizeConfig.font14,
                    color:
                        controller.isUppar ? AppColor.greenColor : Colors.red,
                  ),
                  2.rHorizontalSizedBox(),
                  Text(
                    LanguageConst.upparCase,
                    style: AppTextStyles.textStyle400(
                      textColor:
                          controller.isUppar ? AppColor.greenColor : Colors.red,
                      fontSize: SizeConfig.font12,
                    ),
                  ),
                ],
              ).paddingSideOnly(top: 2, right: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    size: SizeConfig.font14,
                    color:
                        controller.isNumber ? AppColor.greenColor : Colors.red,
                  ),
                  2.rHorizontalSizedBox(),
                  Text(
                    LanguageConst.oneNumber,
                    style: AppTextStyles.textStyle400(
                      textColor: controller.isNumber
                          ? AppColor.greenColor
                          : Colors.red,
                      fontSize: SizeConfig.font12,
                    ),
                  ),
                ],
              ).paddingSideOnly(top: 2, right: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    size: SizeConfig.font14,
                    color:
                        controller.isLower ? AppColor.greenColor : Colors.red,
                  ),
                  2.rHorizontalSizedBox(),
                  Text(
                    LanguageConst.lowerCase,
                    style: AppTextStyles.textStyle400(
                      textColor:
                          controller.isLower ? AppColor.greenColor : Colors.red,
                      fontSize: SizeConfig.font12,
                    ),
                  ),
                ],
              ).paddingSideOnly(top: 2, right: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check,
                    size: SizeConfig.font14,
                    color: controller.isSpecialCharacter
                        ? AppColor.greenColor
                        : Colors.red,
                  ),
                  2.rHorizontalSizedBox(),
                  Text(
                    LanguageConst.specialCharacter,
                    style: AppTextStyles.textStyle400(
                      textColor: controller.isSpecialCharacter
                          ? AppColor.greenColor
                          : Colors.red,
                      fontSize: SizeConfig.font12,
                    ),
                  ),
                ],
              ).paddingSideOnly(top: 2, right: 8),
            ],
          ).visibleWhen(
              isVisible: controller.passwordController.text.isNotNullOrEmpty),
          10.rVerticalSizedBox(),
          AppTextField(
            controller: controller.confirmPasswordController,
            focusNode: controller.confirmPasswordFocusNode,
            keyboardType: TextInputType.text,
            hintText: LanguageConst.reEnterNewPassword,
            textCapitalization: TextCapitalization.none,
            validator: (val) {
              if (val?.isEmpty ?? true) {
                return "Please enter confirm password.";
              }
              if (val == controller.passwordController.text) {
                return null;
              } else {
                return LanguageConst.passwordDoNotMatch;
              }
            },
            textInputAction: TextInputAction.done,
            suffixWidget: InkWell(
              onTap: () {
                controller.isConfirmPasswordHide =
                    !controller.isConfirmPasswordHide;
                controller.update();
              },
              child: Icon(
                controller.isConfirmPasswordHide
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: AppColor.blackTextColor,
              ),
            ),
            obscureText: controller.isConfirmPasswordHide,
            obscuringCharacter: '*',
            onTap: () {
              controller.update();
            },
            onChanged: (val) {
              controller.update();
            },
          ),

          10.rVerticalSizedBox(),
          // AppTextField(
          //   controller: controller.verificationCodeController,
          //   focusNode: controller.verificationCodeFocusNode,
          //   keyboardType: TextInputType.number,
          //   hintText: "Enter verification code",
          //   textCapitalization: TextCapitalization.none,
          //   textInputAction: TextInputAction.done,
          //   onTap: () {
          //     controller.update();
          //   },
          //   onChanged: (val) {
          //     controller.update();
          //   },
          // ),
          20.rVerticalSizedBox(),
          BaseButton(
            text: LanguageConst.submit,
            enabled: controller.passwordController.text.length >= 8 &&
                controller.passwordController.text ==
                    controller.confirmPasswordController.text &&
                controller.verificationCodeController.text.length >= 4,
            onSubmit: () {
              if (controller.verificationCodeController.text.length < 4) {
                Utils.showSuccessToast(LanguageConst.fullOTPPrompt, true);
              } else {
                controller.validateAndResetPassword(data: {
                  "email": controller.emailController.text.trim(),
                  "captcha": controller.verificationCodeController.text,
                  "newPassword": controller.passwordController.text
                });
              }
              // Utils.showSuccessToast('Under development!', true);
            },
          ),
        ],
      ),
    );
  }
}
