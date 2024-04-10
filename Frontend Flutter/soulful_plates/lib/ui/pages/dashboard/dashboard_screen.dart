import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/app_singleton.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/base_common_widget.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController>
    with BaseCommonWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        initState: (state) async {},
        autoRemove: false,
        dispose: (state) {},
        builder: (DashboardController model) {
          return Scaffold(
            body: controller.pages[controller.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) => controller.changeTab(index),
                selectedItemColor: AppColor.primaryColor,
                unselectedItemColor: AppColor.blackTextColor,
                currentIndex: controller.currentIndex,
                items: AppSingleton.isBuyer()
                    ? controller.buyersItem
                    : controller.items),
          );
        });
  }
}
