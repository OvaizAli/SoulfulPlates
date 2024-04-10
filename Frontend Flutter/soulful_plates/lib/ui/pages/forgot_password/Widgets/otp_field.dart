import 'package:flutter/material.dart';
import 'package:soulful_plates/Utils/Extensions.dart';
import 'package:soulful_plates/constants/size_config.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_paddings.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../utils/utils.dart';
import '../forgot_password_controller.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({
    super.key,
    required this.controller,
  });

  final ForgotPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Builder(builder: (context) {
        String input = controller.verificationCodeController.text.trim();
        String display =
            input.isNotNullOrEmpty ? Utils.padString(input, 4, '-') : '0000';
        List digits = display.split('');
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.rWidth()),
              color: AppColor.black5TextColor,
            ),
            padding: AppPaddings.defaultPadding16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  digits.length,
                  (index) => Expanded(
                          child: Text(
                        digits[index],
                        textAlign: TextAlign.center,
                        style: input.isNotNullOrEmpty
                            ? AppTextStyles.textStyleBlackOTP
                            : AppTextStyles.textStyleGreyOTP,
                      ))),
            ));
      }),
      Visibility(
        visible: false,
        maintainState: true,
        maintainAnimation: true,
        maintainInteractivity: true,
        maintainSize: true,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          focusNode: controller.verificationCodeFocusNode,
          enableInteractiveSelection: false,
          style: AppTextStyles.textStyleBlack22With700,
          controller: controller.verificationCodeController,
          onChanged: (val) {
            controller.update();
          },
          maxLength: 6,
          keyboardType: TextInputType.number,
        ),
      )
    ]);
  }
}
