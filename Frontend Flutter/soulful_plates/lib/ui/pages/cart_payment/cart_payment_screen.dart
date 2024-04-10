import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/ui/widgets/app_text_field.dart';
import 'package:soulful_plates/ui/widgets/base_button.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/size_config.dart';
import '../../../routing/route_names.dart';
import '../../../utils/validator.dart';
import '../../widgets/base_common_widget.dart';
import 'cart_payment_controller.dart';

class CartPaymentScreen extends GetView<CartPaymentController>
    with BaseCommonWidget {
  CartPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (CartPaymentController model) {
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
          getPaymentInfo(),
          36.rVerticalSizedBox(),
          Text(
            "Please enter credit card details to pay.",
            style: AppTextStyles.textStyleBlack14With400,
          ).paddingHorizontal8(),
          16.rVerticalSizedBox(),
          Form(
            child: Column(
              children: [
                AppTextField(
                  controller: controller.cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter(),
                  ],
                  hintText: "Card number",
                  prefixWidget: const Icon(
                    Icons.credit_card,
                    color: AppColor.black2TextColor,
                  ),
                ),
                AppTextField(
                  controller: controller.fullNameController,
                  hintText: "Full name",
                  prefixWidget: const Icon(
                    Icons.person_3_outlined,
                    color: AppColor.black2TextColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: controller.cvvController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Limit the input
                          LengthLimitingTextInputFormatter(4),
                        ],
                        hintText: "CVV",
                        prefixWidget: const Icon(
                          Icons.password,
                          color: AppColor.black2TextColor,
                        ),
                      ),
                    ),
                    16.rHorizontalSizedBox(),
                    Expanded(
                      child: AppTextField(
                        controller: controller.dateController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                        ],
                        hintText: "MM/YY",
                        prefixWidget: const Icon(
                          Icons.date_range,
                          color: AppColor.black2TextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingUpSide48(),
          ),
          controller.state == ViewStateEnum.busy
              ? const Center(child: CircularProgressIndicator())
              : BaseButton(
                  onSubmit: () async {
                    await controller.createPayment(data: {
                      "userId": AppSingleton.loggedInUserProfile?.id,
                      "storeId": AppSingleton.storeId,
                      "amount": controller.total,
                      "orderId": controller.orderId,
                      "cardNumber": controller.cardNumberController.text.trim(),
                      "cardExpiry": controller.dateController.text,
                      "cvv": controller.cvvController.text
                    });
                    Get.toNamed(orderSuccessViewRoute,
                        arguments: controller.orderId);
                  },
                  buttonBorderRadius: 8,
                  text: "Confirm Payment",
                ).paddingHorizontal8(),
          36.rVerticalSizedBox(),
        ],
      ).paddingHorizontal16(),
    );
  }

  Widget getPaymentInfo() {
    return Container(
      padding: AppPaddings.defaultPadding16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
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
                  "\$${controller.subtotal}",
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
                  "\$${controller.deliveryCharges}",
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
                  "\$${controller.deliveryCharges}",
                  style: AppTextStyles.textStyleBlackTwo14With400,
                ),
              ],
            ),
            16.rVerticalSizedBox(),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Total:",
                  ),
                ),
                8.rHorizontalSizedBox(),
                Text(
                  "\$${controller.tax}",
                  style: AppTextStyles.textStyleBlack16With700,
                ),
              ],
            ),
          ],
        ),
      ).paddingAllDefault(),
    );
  }
}
