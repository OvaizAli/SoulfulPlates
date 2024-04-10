import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/app_theme.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/model/menu/menu_category_model.dart';
import 'package:soulful_plates/model/menu/menu_model.dart';
import 'package:soulful_plates/model/menu/sub_category_model.dart';
import 'package:soulful_plates/routing/route_names.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/utils.dart';
import '../../widgets/base_common_widget.dart';
import 'restaurant_detail_controller.dart';

class RestaurantDetailScreen extends GetView<RestaurantDetailController>
    with BaseCommonWidget {
  RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: const Text("Restaurant Detail"),
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
        floatingActionButton: FloatingActionButton(
            tooltip: "Go to cart",
            onPressed: () {
              Get.toNamed(viewCartViewRoute,
                  arguments: controller.selectedItems);
            },
            child: const Icon(
              Icons.shopping_cart,
              size: 24,
              color: AppColor.whiteColor,
            )),
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (RestaurantDetailController model) {
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
          getRestaurantCard(),
          16.rVerticalSizedBox(),
          ListView.builder(
              itemCount: Utils.menuCategory.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return getCategoryItem(context, Utils.menuCategory[index]);
              }),
          // Text(
          //   "Quick bites",
          //   style: AppTextStyles.textStyleBlack16With700,
          // ).paddingHorizontal16(),
          // 8.rVerticalSizedBox(),
          // ListView.builder(
          //     itemCount: controller.menuItems.length,
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemBuilder: (BuildContext context, int index) {
          //       return getItemCard(context, controller.menuItems[index]);
          //     }),
          120.rVerticalSizedBox()
        ],
      ),
    ).paddingAllDefault();
  }

  Widget getCategoryItem(BuildContext context, MenuCategory menuCategory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menuCategory.categoryName ?? '',
          style: AppTextStyles.textStyleBlack18With700,
        ).paddingHorizontal16(),
        4.rVerticalSizedBox(),
        ListView.builder(
            itemCount: menuCategory.subcategories.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return getSubCategoryItem(
                      context, menuCategory.subcategories[index])
                  .paddingSideOnly(left: 8);
            }),
        8.rVerticalSizedBox(),
      ],
    );
  }

  Widget getSubCategoryItem(
      BuildContext context, SubCategoryModel subCategoryModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subCategoryModel.subCategoryName ?? '',
          style: AppTextStyles.textStyleBlack14With700,
        ).paddingHorizontal16(),
        ListView.builder(
            itemCount: subCategoryModel.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return getItemCard(context, subCategoryModel.items[index]);
            }),
        8.rVerticalSizedBox(),
      ],
    );
  }

  Widget getItemCard(BuildContext context, MenuModel menuItemModel) {
    return GestureDetector(
        onTap: () {
          _showItemDetailBottomSheet(context, menuItemModel);
        },
        child: Container(
          decoration: AppTheme.boxItemDecorationCard,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              12.rHorizontalSizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: menuItemModel.itemImage.isNotNullOrEmpty
                          ? menuItemModel.itemImage.toString()
                          : "https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit.fill,
                      color: AppColor.blackTextColor.withOpacity(0.1),
                      colorBlendMode: BlendMode.color,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  4.rVerticalSizedBox(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Utils().getFoodTypeIcon(menuItemModel.type ?? 'Veg'),
                        width: 18.rSize(),
                        height: 18.rSize(),
                      ),
                      2.rHorizontalSizedBox(),
                      Text(
                        menuItemModel.type ?? 'Veg',
                        style: AppTextStyles.textStyleBlackTwo10With400,
                      ),
                    ],
                  ),
                ],
              ),
              4.rHorizontalSizedBox(),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.rVerticalSizedBox(),
                  Text(
                    menuItemModel.itemName?.capitalizeFirst ?? '',
                    maxLines: 2,
                    style: AppTextStyles.textStyleBlack14With700,
                  ),
                  Text(
                    "\$ ${menuItemModel.itemPrice}",
                    style: AppTextStyles.textStyleBlack12With400,
                  ),
                  Text(
                    menuItemModel.description ?? '',
                    style: AppTextStyles.textStyleBlackTwo12With400,
                  ),
                  4.rVerticalSizedBox(),
                  Row(
                      // alignment: Alignment.centerRight,
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              controller.addToWishList(menuItemModel);
                            },
                            child: Icon(
                              Icons.favorite_outline_rounded,
                              size: 24.rSize(),
                            ),
                          ),
                        )),
                        CartStepperInt(
                          value: menuItemModel.quantity,
                          style: CartStepperTheme.of(context).copyWith(
                            activeForegroundColor: AppColor.greenColor,
                            activeBackgroundColor: AppColor.greenColorCode,
                          ),
                          didChangeCount: (int value) {
                            if (menuItemModel.quantity == value) {
                            } else if (menuItemModel.quantity > value) {
                              controller.removeFromCart(
                                  menuItemModel.itemId?.toInt() ?? 0,
                                  menuItemModel.itemName ?? '',
                                  value);
                            } else {
                              controller.addToCart(
                                  menuItemModel.itemId?.toInt() ?? 0,
                                  menuItemModel.itemName ?? '',
                                  menuItemModel.itemPrice ?? '',
                                  value);
                            }
                            menuItemModel.quantity = value;
                            controller.update();
                          },
                        )
                      ]).paddingAll4(),
                  4.rVerticalSizedBox(),
                ],
              ).paddingAllDefault()),
            ],
          ),
        ).paddingUpSide812());
  }

  Widget getRestaurantCard() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.rHorizontalSizedBox(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.restaurantModel?.storeName ?? '',
                style: AppTextStyles.textStyleBlack18With700,
              ),
              2.rVerticalSizedBox(),
              Text(
                controller.restaurantModel?.storeDescription ?? '',
                style: AppTextStyles.textStyleBlack12With400,
              ),
              6.rVerticalSizedBox(),
              Text(
                "Call: ${controller.restaurantModel?.storeContactNumber}",
                style: AppTextStyles.textStyleBlackTwo10With400,
              ),
              Text(
                "Email: ${controller.restaurantModel?.storeEmail}",
                style: AppTextStyles.textStyleBlackTwo10With400,
              ),
              Text(
                "Distance: ${controller.restaurantModel?.distance?.toInt()} kms away...",
                style: AppTextStyles.textStyleBlackTwo10With400,
              ),
            ],
          ).paddingAllDefault()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://media.istockphoto.com/id/1457979959/photo/snack-junk-fast-food-on-table-in-restaurant-soup-sauce-ornament-grill-hamburger-french-fries.webp?b=1&s=170667a&w=0&k=20&c=A_MdmsSdkTspk9Mum_bDVB2ko0RKoyjB7ZXQUnSOHl0=",
                  fit: BoxFit.fill,
                  color: AppColor.blackTextColor.withOpacity(0.1),
                  colorBlendMode: BlendMode.color,
                  width: 110,
                  height: 80,
                ),
              ),
              8.rVerticalSizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "${Utils.getRandomTimeLeftPrep()} Min",
                      style: AppTextStyles.textStyleWhite14With400,
                    ).paddingUpSide412(),
                  ),
                  8.rHorizontalSizedBox(),
                  const Icon(
                    Icons.star_border,
                    color: AppColor.primaryColorLight,
                    size: 24,
                  ),
                  4.rHorizontalSizedBox(),
                  Text(
                    controller.ratingCount.toString(),
                    style: AppTextStyles.textStylePrimaryLight14With700,
                  )
                ],
              ),
              4.rVerticalSizedBox(),
            ],
          ).paddingUpSide412(),
        ],
      ),
    );
  }

  void _showItemDetailBottomSheet(
      BuildContext context, MenuModel menuItemModel) {
    Get.bottomSheet(GetBuilder(
      init: controller,
      initState: (state) async {},
      builder: (RestaurantDetailController model) {
        return Container(
          height: Get.height / 2, // Cover half of the screen
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                child: Image.network(
                  "https://media.istockphoto.com/id/1457979959/photo/snack-junk-fast-food-on-table-in-restaurant-soup-sauce-ornament-grill-hamburger-french-fries.webp?b=1&s=170667a&w=0&k=20&c=A_MdmsSdkTspk9Mum_bDVB2ko0RKoyjB7ZXQUnSOHl0=",
                  width: double.infinity,
                  height: Get.height / 4,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Utils().getFoodTypeIcon(menuItemModel.type ?? 'Veg'),
                          width: 18.rSize(),
                          height: 18.rSize(),
                        ),
                        2.rHorizontalSizedBox(),
                        Text(
                          menuItemModel.type ?? 'Veg',
                          style: AppTextStyles.textStyleBlackTwo10With400,
                        ),
                      ],
                    ),
                    2.rVerticalSizedBox(),
                    Text(
                      menuItemModel.itemName?.capitalizeFirst ?? '',
                      maxLines: 2,
                      style: AppTextStyles.textStyleBlack14With700,
                    ),
                    Text(
                      "\$ ${menuItemModel.itemPrice}",
                      style: AppTextStyles.textStyleBlack12With400,
                    ),
                    Text(
                      menuItemModel.description ?? '',
                      style: AppTextStyles.textStyleBlackTwo12With400,
                    ),
                    Text(
                      'Serve: ${menuItemModel.servingType} People',
                      style: AppTextStyles.textStyleBlackTwo12With400,
                    ),
                    8.rVerticalSizedBox(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CartStepperInt(
                        value: menuItemModel.quantity,
                        style: CartStepperTheme.of(context).copyWith(
                          activeForegroundColor: AppColor.greenColor,
                          activeBackgroundColor: AppColor.greenColorCode,
                        ),
                        didChangeCount: (int value) {
                          if (menuItemModel.quantity == value) {
                          } else if (menuItemModel.quantity > value) {
                            controller.removeFromCart(
                                menuItemModel.itemId?.toInt() ?? 0,
                                menuItemModel.itemName ?? '',
                                value);
                          } else {
                            controller.addToCart(
                                menuItemModel.itemId?.toInt() ?? 0,
                                menuItemModel.itemName ?? '',
                                menuItemModel.itemPrice ?? '',
                                value);
                          }
                          menuItemModel.quantity = value;
                          controller.update();
                        },
                      ).paddingAll4(),
                    ),
                    4.rVerticalSizedBox(),
                    Text(
                      menuItemModel.recommended == true
                          ? "Recommended by Store"
                          : '',
                      style: AppTextStyles.textStyleBlue14With400,
                    ),
                    8.rVerticalSizedBox(),
                  ],
                ).paddingUpSide816(),
              ),
            ],
          ),
        );
      },
    ));
  }
}

void main() {
  runApp(GetMaterialApp(
    home: RestaurantDetailScreen(),
  ));
}
