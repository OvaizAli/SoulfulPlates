import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_colors.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/utils/extensions.dart';

import '../../../constants/app_icons.dart';
import '../../../constants/app_sized_box.dart';
import '../../../constants/app_theme.dart';
import '../../../constants/enums/view_state.dart';
import '../../../routing/route_names.dart';
import '../../widgets/base_common_widget.dart';
import '../../widgets/order_item_widget.dart';
import 'home_seller_controller.dart';

class HomeSellerScreen extends GetView<HomeSellerController>
    with BaseCommonWidget {
  const HomeSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: GetBuilder(
          init: controller,
          initState: (state) async {},
          builder: (HomeSellerController model) {
            return getBody(context);
          },
        ),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(AppIcons.appIcon, width: 36.rWidth()),
              8.rHorizontalSizedBox(),
              Text(
                'Welcome to Soulful Plates!',
                style: AppTextStyles.textStyleBlack16With700,
              ),
            ],
          ).paddingAll12(),
          12.rVerticalSizedBox(),
          StatisticWidget(
            controller: controller,
          ),
          20.rVerticalSizedBox(),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              10.rHorizontalSizedBox(),
              Text(
                'ORDERS',
                style: AppTextStyles.textStyleBlack22With700,
              ),
              10.rHorizontalSizedBox(),
              const Expanded(
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
            ],
          ).paddingHorizontal8(),
          20.rVerticalSizedBox(),
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
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.dataList.length + 1,
                          itemBuilder: (context, index) {
                            if (index < controller.dataList.length) {
                              return InkWell(
                                onTap: () async {
                                  controller.dataList[index].setIsSeller(true);
                                  Get.toNamed(orderDetailViewRoute,
                                      arguments: controller.dataList[index]);
                                },
                                child: OrderItemWidget(
                                    orderDetailModel:
                                        controller.dataList[index],
                                    isSeller: true,
                                    orderStatusChange: (OrderStatus? status) {
                                      controller.changeOrderStatus(
                                          controller.dataList[index], status);
                                      print("This is order status ${status}");
                                      // controller.changeOrderStatus(status);
                                    }).paddingVertical8(),
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
          ])
        ],
      ).paddingAll16(),
    );
  }
}

class StatisticWidget extends StatefulWidget {
  HomeSellerController controller;

  StatisticWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatisticWidget> createState() => _StatisticWidgetState();
}

class _StatisticWidgetState extends State<StatisticWidget> {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int _selectedMonth = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppColor.greenStart, AppColor.greenEnd],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(12.rSize())),
      child: GetBuilder(
        init: widget.controller,
        initState: (state) async {},
        builder: (HomeSellerController model) {
          return Flex(
            direction: Axis.vertical,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          'Earnings Statistics',
                          style: AppTextStyles.textStyleWhite18With600,
                        ),
                      ),
                      PopupMenuButton<int>(
                        initialValue: _selectedMonth,
                        itemBuilder: (BuildContext context) {
                          return List<PopupMenuEntry<int>>.generate(
                            12,
                            (int index) {
                              return PopupMenuItem<int>(
                                value: index + 1,
                                child: Text(months[index]),
                              );
                            },
                          );
                        },
                        onSelected: (int value) {
                          setState(() {
                            _selectedMonth = value;
                          });
                          widget.controller.fetchStatistics(_selectedMonth);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.greenStart,
                              borderRadius: BorderRadius.circular(16)),
                          child: Text(
                            months[_selectedMonth - 1],
                            style: AppTextStyles.textStyleWhite14With400,
                          ).paddingUpSide412(),
                        ),
                      )
                    ],
                  ),
                  36.rVerticalSizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('Amount',
                                      style: AppTextStyles
                                          .textStyleWhite14With500),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('\$${widget.controller.amount} CAD',
                                      style: AppTextStyles
                                          .textStyleWhite22With700),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Orders',
                                    style:
                                        AppTextStyles.textStyleWhite14With500,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('#${widget.controller.orderCount}',
                                      style: AppTextStyles
                                          .textStyleWhite22With700),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ).paddingAll16();
        },
      ),
    ).paddingHorizontal8();
  }
}
