import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/ui/widgets/base_button.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../Utils/Validator.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_common_widget.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> with BaseCommonWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      initState: (state) async {},
      builder: (ProfileController model) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Profile"),
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
            body: SafeArea(child: getBody(context)));
      },
    );
  }

  Widget getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.rVerticalSizedBox(),
        Center(
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(24), // Image radius
              child: CachedNetworkImage(
                  imageUrl: '${controller.userProfile?.image}',
                  height: 48.rSize(),
                  width: 48.rSize(),
                  fit: BoxFit.cover),
            ),
          ).visibleWhen(
              isVisible: controller.userProfile != null &&
                  controller.userProfile!.image.isNotNullOrEmpty),
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: AppColor.profileBackground,
            radius: 48.rSize(),
            child: Text(
              controller.userProfile?.shortName() ?? 'NK',
              style: AppTextStyles.textStyleWhite22With700,
            ),
          ).visibleWhen(
              isVisible: !(controller.userProfile != null &&
                  controller.userProfile!.image.isNotNullOrEmpty)),
        ),
        16.rVerticalSizedBox(),
        Text(
          'Username',
          style: AppTextStyles.textStyleBlackTwo12With400,
        ),
        8.rVerticalSizedBox(),
        controller.isEditable
            ? AppTextField(
                focusNode: controller.firstNameFocusNode,
                controller: controller.firstNameEditingController,
                validator: (val) =>
                    Validations.emptyValidator(val, "Please enter first name!"),
                onSubmitted: (val) {
                  controller.emailFocusNode.requestFocus();
                },
                hintText: 'Username',
              )
            : Text(
                controller.userProfile?.username ?? 'Nikul Kukadiya',
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
                controller.userProfile?.email ?? 'Nikul@dal.ca',
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
                onSubmitted: (val) {},
                controller: controller.mobileEditingController,
                validator: Validations.mobileValidator,
                hintText: 'Mobile number',
              )
            : Text(
                controller.userProfile?.contactNumber ?? '+1 7828828273',
                style: AppTextStyles.textStyleBlack14With400,
              ).paddingOnly(bottom: 8),
        16.rVerticalSizedBox(),
        BaseButton(
            text: "Save",
            onSubmit: () {
              controller.updateData();
            }).visibleWhen(isVisible: controller.isEditable),
        16.rVerticalSizedBox(),
      ],
    ).paddingHorizontal24();
  }
}
