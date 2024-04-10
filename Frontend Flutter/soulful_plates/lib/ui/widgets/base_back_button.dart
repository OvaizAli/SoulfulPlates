import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class BaseBackButton extends StatelessWidget {
  const BaseBackButton({Key? key, this.backCallback}) : super(key: key);
  final Function? backCallback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (backCallback == null) {
            Get.back();
          } else {
            backCallback!();
          }
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.primaryColor,
        ));
  }
}
