import 'package:flutter/material.dart';
import 'package:soulful_plates/constants/size_config.dart';

import '../../../../constants/app_text_styles.dart';
import '../../../widgets/base_common_widget.dart';

class ForgotPasswordTitleWidget extends StatelessWidget with BaseCommonWidget {
  final String? mainTitle;
  final String? subTitle;

  ForgotPasswordTitleWidget({Key? key, this.mainTitle, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainTitle!,
          style: AppTextStyles.textStyleBlack22With700,
        ),
        12.rVerticalSizedBox(),
        Text(
          subTitle!,
          style: AppTextStyles.textStyleBlackThree14With400,
          maxLines: 2,
        ),
        24.rVerticalSizedBox(),
      ],
    );
  }
}
