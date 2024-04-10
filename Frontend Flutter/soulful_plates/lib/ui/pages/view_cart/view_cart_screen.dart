import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/app_paddings.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/app_theme.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/model/selected_item_model.dart';
import 'package:soulful_plates/ui/pages/view_cart/view_cart_controller.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_common_widget.dart';

class ViewCartScreen extends GetView<ViewCartController> with BaseCommonWidget {
  ViewCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Cart"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (ViewCartController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lemon's Tree Hotel",
                  style: AppTextStyles.textStyleBlack16With400,
                ),
                16.rVerticalSizedBox(),
                ListView.builder(
                    itemCount: controller.selectedItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return cartItemCard(
                          context, controller.selectedItems[index]);
                    }),
              ],
            ).paddingHorizontal16(),
          ),
        )),
        Container(
          child: Column(
            children: [
              AppTextField(
                controller: controller.instructionController,
                hintText: "Instructions/ Notes",
                prefixWidget: const Icon(
                  Icons.note_alt,
                  color: AppColor.black2TextColor,
                ),
                // decoration: InputDecoration(hintText: "Card number"),
              ).paddingHorizontal16(),
              getCheckoutCard()
            ],
          ),
        )
      ],
    );
  }

  Widget cartItemCard(
      BuildContext context, SelectedItemModel selectedItemModel) {
    return Container(
      decoration: AppTheme.boxDecorationCard,
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    fit: BoxFit.fill,
                    color: AppColor.blackTextColor.withOpacity(0.1),
                    colorBlendMode: BlendMode.color,
                  ),
                ),
              ),
            ),
          ),
          16.rHorizontalSizedBox(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedItemModel.itemName.capitalizeFirst ?? '',
                  style: AppTextStyles.textStyleBlack16With700,
                  maxLines: 2,
                ),
                Text.rich(
                  TextSpan(
                    text: "\$ ${selectedItemModel.price}",
                    style: AppTextStyles.textStyleBlack14With400,
                    children: [
                      TextSpan(
                          text: " x${selectedItemModel.quantity}",
                          style: AppTextStyles.textStyleBlackTwo12With400),
                    ],
                  ),
                ),
                4.rVerticalSizedBox(),
                CartStepperInt(
                  value: selectedItemModel.quantity,
                  axis: Axis.horizontal,
                  style: CartStepperTheme.of(context).copyWith(
                    activeForegroundColor: AppColor.greenColor,
                    activeBackgroundColor: AppColor.greenColorCode,
                  ),
                  didChangeCount: (int value) {
                    if (selectedItemModel.quantity == value) {
                    } else if (selectedItemModel.quantity > value) {
                      controller.removeFromCart(selectedItemModel.menuItemId,
                          selectedItemModel.itemName);
                    } else {
                      controller.addToCart(selectedItemModel.menuItemId,
                          selectedItemModel.itemName, selectedItemModel.price);
                    }
                    controller.update();
                  },
                )
              ],
            ),
          ),
          8.rHorizontalSizedBox(),
          // Container(
          //   padding: AppPaddings.defaultPadding4,
          //   height: 42,
          //   width: 42,
          //   decoration: BoxDecoration(
          //     color: AppColor.redColor.withOpacity(.1),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Icon(
          //     Icons.delete_outline,
          //     color: AppColor.redColor,
          //     size: 24.rSize(),
          //   ),
          // ),
          8.rHorizontalSizedBox(),
        ],
      ).paddingAll12(),
    ).paddingVertical8();
  }

  Widget getCheckoutCard() {
    return Container(
      padding: AppPaddings.defaultPadding16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColor.black4TextColor,
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColor.black5TextColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.receipt,
                    color: AppColor.redColor,
                    size: 20.rSize(),
                  ),
                ),
                8.rHorizontalSizedBox(),
                Text(
                  "Billing Details",
                  style: AppTextStyles.textStyleBlackTwo16With400,
                ),
                8.rHorizontalSizedBox(),
              ],
            ),
            16.rVerticalSizedBox(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Sub total:",
                    style: AppTextStyles.textStyleBlackThree14With400,
                  ),
                ),
                8.rHorizontalSizedBox(),
                Text(
                  "\$ ${controller.subtotal}",
                  style: AppTextStyles.textStyleBlackTwo14With400,
                ),
              ],
            ),
            4.rVerticalSizedBox(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Delivery:",
                    style: AppTextStyles.textStyleBlackThree14With400,
                  ),
                ),
                8.rHorizontalSizedBox(),
                Text(
                  "\$ ${controller.deliveryCharges}",
                  style: AppTextStyles.textStyleBlackTwo14With400,
                ),
              ],
            ),
            4.rVerticalSizedBox(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Tax(5%):",
                    style: AppTextStyles.textStyleBlackThree14With400,
                  ),
                ),
                8.rHorizontalSizedBox(),
                Text(
                  "\$ ${controller.tax}",
                  style: AppTextStyles.textStyleBlackTwo14With400,
                ),
              ],
            ),
            16.rVerticalSizedBox(),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$ ${controller.total}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColor.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.createOrder(data: {
                        "userId": AppSingleton.loggedInUserProfile?.id,
                        "storeId": AppSingleton.storeId,
                        "instructions":
                            controller.instructionController.text.trim(),
                        "selectedItems": controller.selectedItems
                            .map((model) => model.toJson())
                            .toList()
                      });
                    },
                    child: controller.state == ViewStateEnum.busy
                        ? const CircularProgressIndicator()
                        : const Text("Check Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ).paddingAllDefault(),
    ).paddingAllDefault();
  }
}
