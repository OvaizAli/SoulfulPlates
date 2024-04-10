import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sized_box.dart';
import '../../../constants/app_theme.dart';
import '../../../constants/enums/view_state.dart';
import '../../../constants/size_config.dart';
import '../../../utils/extensions.dart';
import '../../widgets/base_common_widget.dart';
import '../../widgets/payment_item_widget.dart';
import 'transaction_seller_controller.dart';

class TransactionSellerScreen extends GetView<TransactionSellerController>
    with BaseCommonWidget {
  TransactionSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Transaction"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (TransactionSellerController model) {
              return getBody(context);
            },
          ),
        ));
  }

  Widget getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.rVerticalSizedBox(),
        Text(
          "Filter by Payment Status:",
          style: AppTextStyles.textStyleBlack14With400,
        ).paddingHorizontal16(),
        4.rVerticalSizedBox(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: PaymentStatus.values.map(
              (PaymentStatus option) {
                return ChoiceChip(
                  label: Text(
                    option.name,
                    style: TextStyle(
                        color: controller.paymentStatus == option
                            ? Colors.white
                            : Colors.green.shade900),
                  ),
                  selected: controller.paymentStatus == option,
                  selectedColor: Colors.green.shade900,
                  backgroundColor: Colors.green.shade50,
                  onSelected: (bool selected) {
                    controller.paymentStatus =
                        option ?? PaymentStatus.Completed;
                    controller.resetPagination();
                  },
                ).paddingHorizontal8();
              },
            ).toList(),
          ),
        ).paddingHorizontal8(),
        Expanded(
          child: Stack(children: [
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
                                child: PaymentItemWidget(
                                  paymentModel: controller.dataList[index],
                                  showUser: false,
                                ).paddingUpSide812(),
                              );
                            } else if (controller.moreLoading ==
                                ViewStateEnum.busy) {
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
          ]).paddingAllDefault(),
        )
      ],
    );
  }
}
