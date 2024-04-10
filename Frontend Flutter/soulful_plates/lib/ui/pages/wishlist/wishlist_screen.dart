import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/model/wishlist_model.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sized_box.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_theme.dart';
import '../../../constants/enums/view_state.dart';
import '../../../constants/size_config.dart';
import '../../widgets/base_common_widget.dart';
import 'wishlist_controller.dart';

class WishlistScreen extends GetView<WishlistController> with BaseCommonWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Wish list"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (WishlistController model) {
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
                            // Get.toNamed(orderDetailViewRoute,
                            //     arguments: controller.dataList[index]);
                          },
                          child: getWishListWidget(
                            controller.dataList[index],
                          ),
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

  Widget getWishListWidget(WishlistModel wishlistModel) {
    return Container(
      decoration: AppTheme.boxDecorationCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wishlistModel.storeName ?? 'Niks Store',
                      maxLines: 1,
                      style: AppTextStyles.textStyleBlack16With700,
                    ),
                    Text(
                      wishlistModel.storeEmail ?? "Dungidum@dd.ca",
                      style: AppTextStyles.textStyleBlack12With400,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  controller.deleteWishlist(wishlistModel.wishId?.toInt() ?? 1);
                },
                child: const Icon(
                  Icons.heart_broken,
                  size: 24,
                  color: AppColor.redColor,
                ),
              ),
              4.rHorizontalSizedBox()
            ],
          ),
          16.rVerticalSizedBox(),
          Container(
            decoration: BoxDecoration(
              color: AppColor.orangeColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(wishlistModel.itemName ?? '',
                      maxLines: 1,
                      style: AppTheme.getTransactionStatusColor(
                              PaymentStatus.Completed)
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                4.rHorizontalSizedBox(),
                Text(
                  "\$${wishlistModel.itemPrice}",
                  style: AppTextStyles.textStyleBlack14With400,
                ),
                4.rVerticalSizedBox(),
              ],
            ).paddingUpSide1216(),
          ),
          8.rVerticalSizedBox(),
        ],
      ).paddingAll16(),
    ).paddingUpSide816();
  }
}
