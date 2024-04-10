import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/app_sized_box.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_theme.dart';
import '../../../utils/utils.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/base_common_widget.dart';
import 'order_detail_controller.dart';

class OrderDetailScreen extends GetView<OrderDetailController>
    with BaseCommonWidget {
  // final String orderId;

  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Order Detail"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (OrderDetailController model) {
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.network(
              "https://img.freepik.com/free-vector/food-delivery-abstract-concept-illustration-products-shipping-coronavirus-safe-shopping-self-isolation-servies-online-order-stay-home-social-distancing_335657-76.jpg?t=st=1711567325~exp=1711570925~hmac=5c3b9a51bd1ec7fa4d1a74f6b0d27cc00844c4ce7eb2da79af4140d3fa5f351f&w=740",
              width: double.infinity,
              height: 220,
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(
            'Order ID: #${controller.orderDetailModel?.orderId}',
            style: AppTextStyles.textStyleBlack16With700,
          ),
          4.rVerticalSizedBox(),
          controller.orderDetailModel != null
              ? Row(
                  children: [
                    Text(
                      "Order Status:",
                      style: AppTextStyles.textStyleBlack14With700,
                    ),
                    8.rHorizontalSizedBox(),
                    Container(
                      decoration: AppTheme.getStatusBackgroundColor(
                          controller.orderDetailModel!.getOrderStatusType()),
                      child: Text(
                        controller.orderDetailModel
                                ?.getOrderStatusType()
                                .name
                                .capitalizeFirst ??
                            '',
                        style: AppTheme.getStatusColor(
                            controller.orderDetailModel!.getOrderStatusType()),
                      ).paddingUpSide816(),
                    ),
                  ],
                )
              : AppSizedBox.sizedBox0,
          8.rVerticalSizedBox(),
          Text(
            'Payment Status: #${controller.orderDetailModel?.paymentStatus}',
            style: AppTextStyles.textStyleBlack14With400,
          ),
          8.rVerticalSizedBox(),
          Text(
            'Total paid amount: \$${controller.orderDetailModel?.totalAmount}',
            style: AppTextStyles.textStyleBlack14With400,
          ),
          8.rVerticalSizedBox(),
          Text(
            'Instructions: ${controller.orderDetailModel?.instructions}',
            style: AppTextStyles.textStyleBlack14With400,
          ),
          8.rVerticalSizedBox(),
          Text(
            'Address: #${controller.orderDetailModel?.storeId}',
            style: AppTextStyles.textStyleBlack14With400,
          ),
          8.rVerticalSizedBox(),
          Text(
            'Order placed at: ${Utils.getStringDateFromTime(controller.orderDetailModel?.createdDate ?? '')}',
            style: AppTextStyles.textStyleBlack14With400,
          ),
          8.rVerticalSizedBox(),
          Row(
            children: [
              Text(
                'Preparation time ${Utils.getRandomTimeLeft()} mins left',
                style: AppTextStyles.textStyleBlack14With400,
              ),
              4.rHorizontalSizedBox(),
              Icon(
                Icons.hourglass_bottom,
                color: AppColor.black2TextColor,
                size: 18.rSize(),
              ),
            ],
          ),
          24.rVerticalSizedBox(),
          (controller.orderDetailModel?.rating ?? 0) <= 1 ||
                  controller.orderDetailModel?.feedback.isNullOrEmpty == true
              ? controller.orderDetailModel?.isSeller == true
                  ? AppSizedBox.sizedBox0
                  : getRatingCard()
              : getAlreadyRated(),
          150.rVerticalSizedBox()
        ],
      ),
    ).paddingHorizontal16();
  }

  getRatingCard() {
    return Container(
      decoration: AppTheme.boxDecorationCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rate now?',
            style: AppTextStyles.textStyleBlack14With700,
          ),
          8.rVerticalSizedBox(),
          Text(
            'Rate us from 1 to 5 Star...',
            style: AppTextStyles.textStyleBlack12With400,
          ),
          4.rVerticalSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  controller.orderDetailModel?.setRating(index + 1);
                  controller.update();
                },
                child: Icon(
                  index < (controller.orderDetailModel?.rating ?? 0)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                ),
              );
            }),
          ),
          12.rVerticalSizedBox(),
          Text(
            'Provide your valuable comments...',
            style: AppTextStyles.textStyleBlack12With400,
          ),
          4.rVerticalSizedBox(),
          AppTextField(
            controller: controller.feedbackController,
            keyboardType: TextInputType.number,
            hintText: "Feedback",
            prefixWidget: const Icon(
              Icons.favorite,
              color: AppColor.black2TextColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  controller.createRating(data: {
                    "userId": AppSingleton.loggedInUserProfile?.id,
                    "storeId": controller.orderDetailModel?.storeId,
                    "orderId": controller.orderDetailModel?.orderId,
                    "rating": controller.orderDetailModel?.rating ?? 5,
                    "feedback": controller.feedbackController.text.trim()
                  });
                },
                child: const Text('Submit Feedback')),
          ),
        ],
      ).paddingAll16(),
    ).paddingAllDefault();
  }

  getAlreadyRated() {
    return Container(
      decoration: AppTheme.boxDecorationCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rated us from 1 to 5 Star...',
            style: AppTextStyles.textStyleBlack12With400,
          ),
          4.rVerticalSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              return Icon(
                index < (controller.orderDetailModel?.rating ?? 0)
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.amber,
                size: 40,
              );
            }),
          ),
          12.rVerticalSizedBox(),
          Text(
            'Provided valuable feedback...',
            style: AppTextStyles.textStyleBlack12With400,
          ),
          4.rVerticalSizedBox(),
          AppTextField(
            controller: TextEditingController(
                text: controller.orderDetailModel?.feedback),
            keyboardType: TextInputType.number,
            readOnly: true,
            hintText: "Feedback",
            prefixWidget: const Icon(
              Icons.favorite,
              color: AppColor.black2TextColor,
            ),
          ),
        ],
      ).paddingAll16(),
    ).paddingAllDefault();
  }
}
