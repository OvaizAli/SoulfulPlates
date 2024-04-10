import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/language/language_constants.dart';
import '../../constants/size_config.dart';
import '../../routing/route_names.dart';
import '../../utils/extensions.dart';
import '../widgets/base_button.dart';

class IntroductionViewPage extends StatefulWidget {
  const IntroductionViewPage({super.key});

  @override
  State<IntroductionViewPage> createState() => _IntroductionViewPageState();
}

class _IntroductionViewPageState extends State<IntroductionViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppIcons.logoWhite,
                  width: 200,
                ),
              ],
            )),
            8.rVerticalSizedBox(),
            BaseButton(
                text: LanguageConst.continueText,
                onSubmit: () async {
                  Get.offAllNamed(loginViewRoute);
                }).paddingHorizontal16(),
            24.rVerticalSizedBox(),
            Text(
              'Copyright 2023',
              style: AppTextStyles.textStyleBlackTwo12With400,
            ),
            16.rVerticalSizedBox(),
          ],
        ).paddingScreen(),
      ),
    );
  }
}
