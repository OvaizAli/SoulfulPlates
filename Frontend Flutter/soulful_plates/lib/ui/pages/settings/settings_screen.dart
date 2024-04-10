import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/app_icons.dart';
import 'package:soulful_plates/routing/route_names.dart';
import 'package:soulful_plates/utils/extensions.dart';
import 'package:soulful_plates/utils/shared_prefs.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/size_config.dart';
import '../../widgets/base_common_widget.dart';
import '../web_view/web_view_screen.dart';
import 'settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> with BaseCommonWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (SettingsController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              surfaceTintColor: AppColor.whiteColor,
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User preferences",
                    style: AppTextStyles.textStylePrimary14With600,
                  ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  Container(
                    color: AppColor.primaryColor,
                    height: (SizeConfig.safeBlockVertical ?? 0) *
                        (0.5 * 100 / SizeConfig.uiHeightPx),
                  ),
                  ...(AppSingleton.isBuyer()
                      ? buyersMenuItems()
                      : sellersMenuItems()),
                  InkWell(
                    onTap: () {
                      controller.isNotificationEnabled =
                          !controller.isNotificationEnabled;
                      controller.updateNotificationStatus();
                      controller.update();
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'In app Notification',
                            style: AppTextStyles.textStyleBlack16With400,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          child: Transform.scale(
                              scale: .75,
                              child: Switch(
                                  inactiveTrackColor: AppColor.black4TextColor,
                                  activeColor: AppColor.primaryColor,
                                  thumbColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  value: controller.isNotificationEnabled,
                                  onChanged: (val) {
                                    controller.isNotificationEnabled = val;
                                    controller.update();
                                  })),
                        )
                      ],
                    ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  ),
                  1.rVerticalGreySizedBox(),
                  InkWell(
                    onTap: () {
                      UserPreference.clear();
                      AppSingleton.loggedInUserProfile = null;
                      Get.offAllNamed(loginViewRoute);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Logout',
                            style: AppTextStyles.textStyleBlack16With400,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  ),
                ],
              )),
          16.rVerticalSizedBox(),
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              surfaceTintColor: AppColor.whiteColor,
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Information",
                    style: AppTextStyles.textStylePrimary14With600,
                  ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  Container(
                    color: AppColor.primaryColor,
                    height: (SizeConfig.safeBlockVertical ?? 0) *
                        (0.5 * 100 / SizeConfig.uiHeightPx),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(webViewRoute,
                          arguments: WebViewModel(
                              AppIcons.aboutUs, // Load the local HTML file
                              "About"));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'About',
                            style: AppTextStyles.textStyleBlack16With400,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  ),
                  1.rVerticalGreySizedBox(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(webViewRoute,
                          arguments: WebViewModel(
                            AppIcons.termsAndConditions,
                            'Terms and Conditions',
                          ));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Terms and Conditions',
                            style: AppTextStyles.textStyleBlack16With400,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  ),
                  1.rVerticalGreySizedBox(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(webViewRoute,
                          arguments: WebViewModel(
                            AppIcons.cookiePolicy,
                            'Cookie policy',
                          ));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cookie policy',
                            style: AppTextStyles.textStyleBlack16With400,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  ),
                  1.rVerticalGreySizedBox(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(webViewRoute,
                          arguments: WebViewModel(
                              AppIcons.privacyPolicy, 'Privacy Policy'));
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Privacy Policy',
                            style: AppTextStyles.textStyleBlack16With400,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColor.primaryColor,
                        )
                      ],
                    ).paddingSymmetricSide(vertical: 16, horizontal: 12),
                  ),
                ],
              )),
        ],
      ).paddingAll16(),
    );
  }

  List<Widget> buyersMenuItems() {
    return [
      InkWell(
        onTap: () {
          Get.toNamed(locationListViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Saved Locations',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
      InkWell(
        onTap: () {
          Get.toNamed(transactionHistoryViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Transactions',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
      InkWell(
        onTap: () {
          Get.toNamed(profileViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'User Profile',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
    ];
  }

  List<Widget> sellersMenuItems() {
    return [
      InkWell(
        onTap: () {
          Get.toNamed(storeDetailsViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Store Details',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
      InkWell(
        onTap: () {
          Get.toNamed(orderHistorySellerViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Order History',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
      InkWell(
        onTap: () {
          Get.toNamed(transactionHistorySellerViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Order Transactions',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
      InkWell(
        onTap: () {
          Get.toNamed(payoutHistoryViewRoute);
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                'My Payouts',
                style: AppTextStyles.textStyleBlack16With400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetricSide(vertical: 16, horizontal: 12),
      ),
      1.rVerticalGreySizedBox(),
    ];
  }
}
