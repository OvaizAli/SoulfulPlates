import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/app_theme.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/model/payment_model.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sized_box.dart';
import '../../../constants/enums/view_state.dart';
import '../../../utils/utils.dart';
import '../../widgets/base_common_widget.dart';
import 'payout_seller_controller.dart';

class PayoutSellerScreen extends GetView<PayoutSellerController>
    with BaseCommonWidget {
  PayoutSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Payout Seller"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (PayoutSellerController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return Stack(children: [
      controller.dataList.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                controller.resetPagination();
              },
              child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels >=
                            scrollNotification.metrics.maxScrollExtent &&
                        !controller.hasReachedMax &&
                        !controller.isLoading()) {
                      controller.pageNo = (controller.pageNo + 1);
                      controller.loadMore();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.dataList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.dataList.length) {
                        return InkWell(
                          onTap: () async {
                            //todo tap on the item
                          },
                          child: getPayoutCard(
                            controller.dataList[index],
                          ).paddingUpSide812(),
                        );
                      } else if (controller.moreLoading == ViewStateEnum.busy) {
                        return controller.loadMoreLoader(
                            color: AppColor.blackColor);
                      } else {
                        return AppSizedBox.sizedBox0;
                      }
                    },
                  )),
            )
          : Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.resetPagination();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh_outlined,
                      size: 24.rSize(),
                      color: AppColor.primaryColor,
                    ),
                    Text(
                      'No data available!',
                      style: AppTextStyles.textStyleBlack16With400,
                    ),
                  ],
                ).paddingAll12(),
              ),
            ),
      controller.state == ViewStateEnum.busy
          ? const Center(child: CircularProgressIndicator())
          : AppSizedBox.sizedBox0
    ]).paddingAllDefault();
  }

  Widget getPayoutCard(PaymentModel paymentModel) {
    return Container(
            decoration: AppTheme.boxItemDecorationCard,
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount: \$${(paymentModel.amount?.toDouble() ?? 10 * 0.9)}",
                      style: AppTextStyles.textStyleBlack16With600,
                    ),
                    Text(
                      Utils.getStringDateFromTime(
                          paymentModel.updatedDate ?? ''),
                      style: AppTextStyles.textStyleBlackTwo12With400,
                    ),
                  ],
                )),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.successGreen.withOpacity(.1),
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    paymentModel.paymentStatus ?? 'Paid',
                    style: AppTextStyles.textStyleGreen14With400,
                  ).paddingUpSide816(),
                )
              ],
            ).paddingUpSide812())
        .paddingUpSide26();
  }
}
