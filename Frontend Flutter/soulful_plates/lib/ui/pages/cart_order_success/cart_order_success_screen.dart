import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/size_config.dart';
import '../../../routing/route_names.dart';
import '../../widgets/base_common_widget.dart';
import 'cart_order_success_controller.dart';

class CartOrderSuccessScreen extends GetView<CartOrderSuccessController>
    with BaseCommonWidget {
  CartOrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (CartOrderSuccessController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          "https://img.freepik.com/free-vector/taking-orders-by-phone-store-contact-center-customers-support-easy-order-fast-delivery-trade-service-call-center-operator-cartoon-character_335657-2564.jpg?w=740&t=st=1711471986~exp=1711472586~hmac=f50024a5e3a753cb81b008ab42ef233d55c45e052582e75c43b397f6ddb7245f",
          width: double.infinity,
          height: 240,
        ),
        Text(
          "Thank You !",
          style: AppTextStyles.textStyleBlack18With400,
        ),
        4.rVerticalSizedBox(),
        Text(
          "Your Order is Placed Successfully.",
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyleBlack18With700,
        ),
        12.rVerticalSizedBox(),
        ElevatedButton(
            onPressed: () {
              Get.offAllNamed(dashboardViewRoute);
            },
            child: Text("Explore more items").paddingHorizontal16())
      ],
    ).paddingHorizontal16();
  }
}
