import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/app_singleton.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/model/store_details/restaurant_model.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_paddings.dart';
import '../../../constants/app_sized_box.dart';
import '../../../constants/app_theme.dart';
import '../../../constants/enums/view_state.dart';
import '../../../constants/size_config.dart';
import '../../../routing/route_names.dart';
import '../../../utils/utils.dart';
import '../../widgets/base_common_widget.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> with BaseCommonWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        backgroundColor: AppColor.whiteColor,
        body: SafeArea(
          child: GetBuilder(
            init: controller,
            initState: (state) async {},
            builder: (HomeController model) {
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
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: .9,
              aspectRatio: 16 / 9,
              initialPage: 0,
              onPageChanged: (index, reason) {
                controller.currentIndex = index;
              },
            ),
            items: controller.imagesList
                .map(
                  (item) => Card(
                    margin: AppPaddings.defaultPadding,
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: item.name,
                          fit: BoxFit.fill,
                          color: AppColor.blackTextColor.withOpacity(0.1),
                          colorBlendMode: BlendMode.color,
                          width: double.infinity,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.blackTextColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            item.image,
                            style: AppTextStyles.textStyleWhite18With600,
                          ).paddingAllDefault().paddingHorizontal8(),
                        ).paddingAllDefault(),
                      )
                    ]),
                  ),
                )
                .toList(),
          ),
          16.rVerticalSizedBox(),
          Text(
            "Restaurants near you",
            style: AppTextStyles.textStyleBlack22With700,
          ).paddingHorizontal16(),
          16.rVerticalSizedBox(),
          Stack(children: [
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
                                  AppSingleton.storeId = controller
                                          .dataList[index].storeId
                                          ?.toInt() ??
                                      1;
                                  Get.toNamed(restaurantDetailViewRoute,
                                      arguments: controller.dataList[index]);
                                },
                                child: getRestaurantCard(
                                        controller.dataList[index])
                                    .paddingVertical8(),
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
          ]),
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: controller.dataList,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //           onTap: () {
          //             Get.toNamed(restaurantDetailViewRoute);
          //           },
          //           child: getRestaurantCard(index));
          //     })
        ],
      ),
    );
  }

  static Widget getRestaurantCard(RestaurantModel restaurantModel) {
    return Container(
      decoration: AppTheme.boxDecorationCard,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          8.rHorizontalSizedBox(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.rVerticalSizedBox(),
              Text(
                restaurantModel.storeName ?? '',
                style: AppTextStyles.textStyleBlack16With700,
              ),
              4.rVerticalSizedBox(),
              Text(
                restaurantModel.storeDescription ?? '',
                style: AppTextStyles.textStyleBlack14With400,
                maxLines: 2,
              ),
              Text(
                "${restaurantModel.distance?.toInt()} kms away",
                style: AppTextStyles.textStyleBlackTwo14With400,
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
                      "Prep Time ${Utils.getRandomTimeLeftPrep()} Min",
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
                    "4.5",
                    style: AppTextStyles.textStylePrimaryLight14With700,
                  )
                ],
              ),
              8.rVerticalSizedBox()
            ],
          ).paddingAll12()),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  // index % 2 != 0
                  //     ?
                  "https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              // : "https://static.toiimg.com/photo/62601713.cms",
              fit: BoxFit.fill,
              color: AppColor.blackTextColor.withOpacity(0.1),
              colorBlendMode: BlendMode.color,
              width: 80,
              height: 80,
            ),
          ),
          16.rHorizontalSizedBox()
        ],
      ),
    ).paddingUpSide816();
  }
}
