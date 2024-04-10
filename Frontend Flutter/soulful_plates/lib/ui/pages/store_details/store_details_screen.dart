import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../Utils/Validator.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_button.dart';
import '../../widgets/base_common_widget.dart';
import 'store_details_controller.dart';

class StoreDetailsScreen extends GetView<StoreDetailsController>
    with BaseCommonWidget {
  StoreDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Store Details"),
          actions: [
            InkWell(
              onTap: () {
                controller.isEditable = !controller.isEditable;
                controller.update();
              },
              child: const Icon(
                Icons.edit,
                color: AppColor.blackColor,
                size: 24,
              ).paddingHorizontal16(),
            ).visibleWhen(isVisible: !controller.isEditable)
          ],
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (StoreDetailsController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.rVerticalSizedBox(),
          // Center(
          //   child: ClipOval(
          //     child: SizedBox.fromSize(
          //       size: const Size.fromRadius(24), // Image radius
          //       child: CachedNetworkImage(
          //           imageUrl: '${controller.userProfile?.image}',
          //           height: 48.rSize(),
          //           width: 48.rSize(),
          //           fit: BoxFit.cover),
          //     ),
          //   ).visibleWhen(
          //       isVisible: controller.userProfile != null &&
          //           controller.userProfile!.image.isNotNullOrEmpty),
          // ),
          Center(
              child: CircleAvatar(
            backgroundColor: AppColor.profileBackground,
            radius: 48.rSize(),
            child: Text(
              controller.firstNameEditingController.text.length > 1
                  ? controller.firstNameEditingController.text
                          .toString()
                          .substring(0, 1)
                          .capitalizeFirst ??
                      ''
                  : '-',
              style: AppTextStyles.textStyleWhite22With700,
            ),
          )),
          // .visibleWhen(
          //       isVisible: !(controller.storeDetails != null &&
          //           controller.storeDetails!.image.isNotNullOrEmpty)),
          // ),
          16.rVerticalSizedBox(),
          Text(
            'Store name',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          controller.isEditable
              ? AppTextField(
                  focusNode: controller.firstNameFocusNode,
                  controller: controller.firstNameEditingController,
                  validator: (val) => Validations.emptyValidator(
                      val, "Please enter store name!"),
                  onSubmitted: (val) {
                    controller.emailFocusNode.requestFocus();
                  },
                  hintText: 'Store name',
                )
              : Text(
                  controller.firstNameEditingController.text ?? 'Cloud Kitchen',
                  style: AppTextStyles.textStyleBlack16With700,
                ).paddingOnly(bottom: 8),
          16.rVerticalSizedBox(),
          Text(
            'Email address',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          controller.isEditable
              ? AppTextField(
                  controller: controller.emailEditingController,
                  focusNode: controller.emailFocusNode,
                  validator: Validations.emailValidator,
                  onSubmitted: (val) {
                    controller.mobileFocusNode.requestFocus();
                  },
                  hintText: 'Email address',
                )
              : Text(
                  controller.emailEditingController.text ??
                      'cloudKitchen@cloudKitchen.ca',
                  style: AppTextStyles.textStyleBlack14With400,
                ).paddingOnly(bottom: 8),
          16.rVerticalSizedBox(),
          Text(
            'Mobile number',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          controller.isEditable
              ? AppTextField(
                  focusNode: controller.mobileFocusNode,
                  onSubmitted: (val) {
                    controller.descriptionFocusNode.requestFocus();
                  },
                  controller: controller.mobileEditingController,
                  validator: Validations.mobileValidator,
                  hintText: 'Mobile number',
                )
              : Text(
                  controller.mobileEditingController.text ?? '+1 1234567890',
                  style: AppTextStyles.textStyleBlack14With400,
                ).paddingOnly(bottom: 8),
          16.rVerticalSizedBox(),
          Text(
            'Store Description',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          controller.isEditable
              ? AppTextField(
                  focusNode: controller.descriptionFocusNode,
                  onSubmitted: (val) {
                    controller.streetFocusNode.requestFocus();
                  },
                  controller: controller.descriptionEditingController,
                  validator: Validations.isNotEmpty,
                  hintText: 'Store Description',
                )
              : Text(
                  controller.descriptionEditingController.text ??
                      '+1 1234567890',
                  style: AppTextStyles.textStyleBlack14With400,
                ).paddingOnly(bottom: 8),
          16.rVerticalSizedBox(),
          // Text(
          //   'Street Address',
          //   style: AppTextStyles.textStyleBlackTwo12With400,
          // ),
          // 8.rVerticalSizedBox(),
          // controller.isEditable
          //     ? AppTextField(
          //         focusNode: controller.stateFocusNode,
          //         onSubmitted: (val) {
          //           controller.stateFocusNode.requestFocus();
          //         },
          //         controller: controller.streetEditingController,
          //         validator: Validations.mobileValidator,
          //         hintText: 'Street Address',
          //       )
          //     : Text(
          //         controller.storeDetails?.street ?? '1414 Barrington str',
          //         style: AppTextStyles.textStyleBlack14With400,
          //       ).paddingOnly(bottom: 8),
          // 16.rVerticalSizedBox(),
          // Text(
          //   'Province',
          //   style: AppTextStyles.textStyleBlackTwo12With400,
          // ),
          // 8.rVerticalSizedBox(),
          // controller.isEditable
          //     ? AppTextField(
          //         focusNode: controller.stateFocusNode,
          //         onSubmitted: (val) {
          //           controller.cityFocusNode.requestFocus();
          //         },
          //         controller: controller.stateEditingController,
          //         validator: Validations.mobileValidator,
          //         hintText: 'Province',
          //       )
          //     : Text(
          //         controller.storeDetails?.state ?? 'Nova Scotia',
          //         style: AppTextStyles.textStyleBlack14With400,
          //       ).paddingOnly(bottom: 8),
          // 16.rVerticalSizedBox(),
          // Text(
          //   'City',
          //   style: AppTextStyles.textStyleBlackTwo12With400,
          // ),
          // 8.rVerticalSizedBox(),
          // controller.isEditable
          //     ? AppTextField(
          //         focusNode: controller.cityFocusNode,
          //         onSubmitted: (val) {
          //           controller.postalCodeFocusNode.requestFocus();
          //         },
          //         controller: controller.cityEditingController,
          //         validator: Validations.mobileValidator,
          //         hintText: 'City',
          //       )
          //     : Text(
          //         controller.storeDetails?.city ?? 'Halifax',
          //         style: AppTextStyles.textStyleBlack14With400,
          //       ).paddingOnly(bottom: 8),
          // 16.rVerticalSizedBox(),
          // Text(
          //   'Postal Code',
          //   style: AppTextStyles.textStyleBlackTwo12With400,
          // ),
          // 8.rVerticalSizedBox(),
          // controller.isEditable
          //     ? AppTextField(
          //         focusNode: controller.postalCodeFocusNode,
          //         onSubmitted: (val) {},
          //         controller: controller.postalCodeEditingController,
          //         validator: Validations.mobileValidator,
          //         hintText: 'Postal Code',
          //       )
          //     : Text(
          //         controller.storeDetails?.postalCode ?? 'B3K2Z2',
          //         style: AppTextStyles.textStyleBlack14With400,
          //       ).paddingOnly(bottom: 8),
          16.rVerticalSizedBox(),
          BaseButton(
              text: "Save",
              onSubmit: () async {
                await controller.updateData();
                controller.isEditable = !controller.isEditable;
                controller.update();
              }).visibleWhen(isVisible: controller.isEditable),
          16.rVerticalSizedBox(),
        ],
      ).paddingHorizontal24(),
    );
  }
}
