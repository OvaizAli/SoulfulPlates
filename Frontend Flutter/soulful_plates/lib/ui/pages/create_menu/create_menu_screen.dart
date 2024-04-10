import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/Utils/Extensions.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/model/menu/menu_category_model.dart';
import 'package:soulful_plates/model/menu/sub_category_model.dart';
import 'package:soulful_plates/ui/widgets/base_button.dart';

import '../../../Utils/Validator.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../routing/route_names.dart';
import '../../../utils/utils.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_common_widget.dart';
import 'create_menu_controller.dart';

class CreateMenuScreen extends GetView<CreateMenuController>
    with BaseCommonWidget {
  CreateMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Menu Items"),
          actions: [
            InkWell(
                onTap: () async {
                  var response = await Get.toNamed(menuCategoryViewRoute);
                  controller.update();
                },
                child: const Icon(
                  Icons.add_circle_outline,
                  size: 24,
                  color: AppColor.blackColor,
                )).paddingHorizontal8()
          ],
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (CreateMenuController model) {
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
          Text(
            'Item name',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          AppTextField(
            controller: controller.itemName,
            focusNode: controller.itemNameFocus,
            validator: Validations.isNotEmpty,
            onSubmitted: (val) {
              controller.itemPriceFocus.requestFocus();
            },
            hintText: 'Item name',
          ),
          Text(
            'Item price',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          AppTextField(
            controller: controller.itemPrice,
            focusNode: controller.itemPriceFocus,
            validator: Validations.isNotEmpty,
            onSubmitted: (val) {
              controller.descriptionFocus.requestFocus();
            },
            hintText: 'Item price',
          ),
          Text(
            'Description',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          AppTextField(
            controller: controller.description,
            focusNode: controller.descriptionFocus,
            validator: Validations.isNotEmpty,
            onSubmitted: (val) {
              controller.serviceTypeFocus.requestFocus();
            },
            hintText: 'Description',
          ),
          DropdownSearch<MenuCategory>(
            popupProps: const PopupProps.bottomSheet(),
            items: Utils.menuCategoryList,
            dropdownBuilder: (context, dataModel) {
              return Text(
                dataModel?.categoryName ?? '',
                style: AppTextStyles.textStyleBlack14With400,
              );
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
              hintText: 'Select Category',
              labelText: 'Select Category',
            )),
            itemAsString: (MenuCategory u) => u.categoryName ?? '',
            onChanged: (MenuCategory? data) async {
              controller.selectCategory = data;
              await Utils.fetchSubCategoryList(
                  (state) => controller.setLoaderState,
                  data?.categoryId?.toString() ?? '');
              controller.selectSubCategory = null;
              controller.update();
            },
          ),
          DropdownSearch<SubCategoryModel>(
            popupProps: const PopupProps.bottomSheet(),
            items: Utils.menuSubCategoryList,
            dropdownBuilder: (context, dataModel) {
              return Text(
                dataModel?.subCategoryName ?? '',
                style: AppTextStyles.textStyleBlack14With400,
              );
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
              hintText: 'Select Sub Category',
              labelText: 'Select Sub Category',
            )),
            itemAsString: (SubCategoryModel u) => u.subCategoryName ?? '',
            onChanged: (SubCategoryModel? data) {
              controller.selectSubCategory = data;
              controller.update();
            },
          ),
          DropdownSearch<String>(
            popupProps: const PopupProps.bottomSheet(),
            items: controller.type,
            dropdownBuilder: (context, dataModel) {
              return Text(
                dataModel ?? '',
                style: AppTextStyles.textStyleBlack14With400,
              );
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
              hintText: 'Select Food Type',
              labelText: 'Select Food Type',
            )),
            itemAsString: (String u) => u,
            onChanged: (String? data) {
              controller.selectType = data ?? '';
              controller.update();
            },
          ),
          Text(
            'Serving type',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          AppTextField(
            controller: controller.serviceType,
            focusNode: controller.serviceTypeFocus,
            validator: Validations.isNotEmpty,
            onSubmitted: (val) {
              controller.portionFocus.requestFocus();
            },
            hintText: 'Serving type',
          ),
          Text(
            'Portion',
            style: AppTextStyles.textStyleBlackTwo12With400,
          ),
          8.rVerticalSizedBox(),
          AppTextField(
            controller: controller.portion,
            focusNode: controller.portionFocus,
            validator: Validations.isNotEmpty,
            onSubmitted: (val) {
              controller.portionFocus.requestFocus();
            },
            hintText: 'Portion',
          ),
          GestureDetector(
            onTap: () {
              controller.inStock = !controller.inStock;

              controller.update();
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'In stock',
                    style: AppTextStyles.textStyleBlackTwo12With400,
                  ),
                ),
                SizedBox(
                  width: 36,
                  height: 18,
                  child: Transform.scale(
                      scale: .75,
                      child: Switch(
                          inactiveTrackColor: AppColor.black4TextColor,
                          activeColor: AppColor.primaryColor,
                          thumbColor: const MaterialStatePropertyAll<Color>(
                              Colors.black),
                          value: controller.inStock,
                          onChanged: (val) {
                            controller.inStock = !controller.inStock;
                            controller.update();
                          })),
                )
              ],
            ).paddingVertical8(),
          ),
          GestureDetector(
            onTap: () {
              controller.isRecommended = !controller.isRecommended;
              controller.update();
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Recommended",
                    style: AppTextStyles.textStyleBlackTwo12With400,
                  ),
                ),
                4.rHorizontalSizedBox(),
                Icon(
                  controller.isRecommended
                      ? Icons.thumb_up_sharp
                      : Icons.thumb_up_off_alt,
                  color: AppColor.primaryColor,
                  size: 24,
                ),
              ],
            ).paddingVertical16(),
          ),
          8.rVerticalSizedBox(),
          saveButton()
        ],
      ).paddingUpSide1216().paddingHorizontal8(),
    );
  }

  Widget saveButton() {
    if (controller.state == ViewStateEnum.busy) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return BaseButton(
        text: 'Save Item',
        onSubmit: () {
          controller.onSave();
        });
  }
}
