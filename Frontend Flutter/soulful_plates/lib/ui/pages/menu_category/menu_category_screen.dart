import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_sized_box.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/model/menu/sub_category_model.dart';
import 'package:soulful_plates/ui/widgets/app_text_field.dart';
import 'package:soulful_plates/ui/widgets/base_button.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../model/menu/menu_category_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/base_common_widget.dart';
import 'menu_category_controller.dart';

class MenuCategoryScreen extends GetView<MenuCategoryController>
    with BaseCommonWidget {
  MenuCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Menu Category"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (MenuCategoryController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Category List",
            style: AppTextStyles.textStyleBlack16With700,
          ),
          ListView.separated(
            itemCount: Utils.menuCategoryList.length,
            shrinkWrap: true,
            itemBuilder: (context, categoryIndex) {
              MenuCategory category = Utils.menuCategoryList[categoryIndex];
              return ListTile(
                title: Text(category.categoryName ?? ''),
                trailing: InkWell(
                  onTap: () {
                    updateCategoryDialog(context, category);
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    size: 24.rSize(),
                  ),
                ),
                onTap: () async {
                  controller.selectedCategory = category;
                  // controller.categoryController.text = category.name;
                  await controller.fetchSubCategory();
                  controller.update();
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return 1.rVerticalGreySizedBox();
            },
          ),
          AppTextField(
            controller: controller.categoryController,
            hintText: 'Add New Category Name',
          ).visibleWhen(isVisible: controller.selectedCategory == null),
          16
              .rVerticalSizedBox()
              .visibleWhen(isVisible: controller.selectedCategory == null),
          (controller.state == ViewStateEnum.busy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : BaseButton(
                      onSubmit: () {
                        controller.addCategory();
                      },
                      text: 'Add Category',
                    ))
              .visibleWhen(isVisible: controller.selectedCategory == null),
          16.rVerticalSizedBox(),
          ...getSubcategoryWidget(),
        ],
      ).paddingAll16(),
    );
  }

  List<Widget> getSubcategoryWidget() {
    if (controller.selectedCategory == null) {
      return [AppSizedBox.sizedBox0];
    }

    return [
      Row(
        children: [
          Expanded(
            child: Text(
              'Selected Categories for: ${controller.selectedCategory?.categoryName}',
              style: AppTextStyles.textStyleBlack14With700,
            ),
          ),
          InkWell(
              onTap: () {
                controller.selectedCategory = null;
                controller.update();
              },
              child: Icon(
                Icons.close_outlined,
                size: 24.rSize(),
                color: AppColor.blackColor,
              ))
        ],
      ),
      16.rVerticalSizedBox(),
      ListView.separated(
        shrinkWrap: true,
        itemCount: Utils.menuSubCategoryList.length ?? 0,
        separatorBuilder: (BuildContext context, int index) {
          return 1.rVerticalGreySizedBox();
        },
        itemBuilder: (context, subcategoryIndex) {
          SubCategoryModel subcategory =
              Utils.menuSubCategoryList[subcategoryIndex];
          return ListTile(
            title: Text(subcategory.subCategoryName ?? ''),
            trailing: InkWell(
              onTap: () {
                updateSubCategoryDialog(context, subcategory);
              },
              child: Icon(
                Icons.edit_outlined,
                size: 24.rSize(),
              ),
            ),
            // You can add more details or functionality here
          );
        },
      ),
      32.rVerticalSizedBox(),
      AppTextField(
        controller: controller.subCategoryController,
        hintText: 'Add New Subcategory Name',
      ),
      controller.state == ViewStateEnum.busy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BaseButton(
              onSubmit: () {
                controller.addSubCategory();
              },
              text: 'Add Sub Category',
            ),
      16.rVerticalSizedBox(),
    ];
  }

  Future<void> updateCategoryDialog(
      BuildContext context, MenuCategory menuCategory) async {
    // Controllers for text fields
    TextEditingController nameController =
        TextEditingController(text: menuCategory.categoryName);

    // Show dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: AppPaddings.defaultPadding16,
          backgroundColor: AppColor.whiteColor,
          title: const Text('Edit Category Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await controller.updateCategoryName(
                    menuCategory, nameController.text);
                controller.update();
                Get.back();
              },
              child: controller.state == ViewStateEnum.busy
                  ? const CircularProgressIndicator()
                  : const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateSubCategoryDialog(
      BuildContext context, SubCategoryModel subCategoryModel) async {
    // Controllers for text fields
    TextEditingController nameController =
        TextEditingController(text: subCategoryModel.subCategoryName);

    // Show dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: AppPaddings.defaultPadding16,
          backgroundColor: AppColor.whiteColor,
          title: const Text('Edit SubCategory Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'SubCategory Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await controller.updateSubCategoryName(
                    subCategoryModel, nameController.text);
                controller.update();
                Get.back();
              },
              child: controller.state == ViewStateEnum.busy
                  ? const CircularProgressIndicator()
                  : const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
