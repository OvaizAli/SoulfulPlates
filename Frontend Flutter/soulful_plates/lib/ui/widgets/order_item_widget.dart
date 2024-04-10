import 'package:flutter/material.dart';
import 'package:soulful_plates/Utils/Extensions.dart';
import 'package:soulful_plates/constants/app_sized_box.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_theme.dart';
import '../../model/order_detail_model.dart';
import '../../utils/utils.dart';
import '../pages/order_detail/order_detail_screen.dart';

class OrderItemWidget extends StatefulWidget {
  OrderDetailModel orderDetailModel;
  bool isSeller = false;

  Function(OrderStatus? status) orderStatusChange;

  OrderItemWidget(
      {Key? key,
      required this.orderDetailModel,
      required this.isSeller,
      required this.orderStatusChange})
      : super(key: key);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: AppTheme.boxDecorationCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.isSeller
                ? AppSizedBox.sizedBox0
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: AppTheme.getStatusBackgroundColor(
                                widget.orderDetailModel.getOrderStatusType()),
                            child: Text(
                              widget.orderDetailModel.getOrderStatusType().name,
                              style: AppTheme.getStatusColor(
                                  widget.orderDetailModel.getOrderStatusType()),
                            ).paddingUpSide816(),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${Utils.getRandomTimeLeft()} mins left',
                                    style:
                                        AppTextStyles.textStyleBlack16With400,
                                  ),
                                  4.rHorizontalSizedBox(),
                                  Icon(
                                    Icons.hourglass_bottom,
                                    color: AppColor.black2TextColor,
                                    size: 24.rSize(),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      18.rVerticalSizedBox(),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID',
                      style: AppTextStyles.textStyleBlack14With700,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(),
                          ),
                        );
                      },
                      child: Text(
                        '${widget.orderDetailModel.orderId}',
                        style: AppTextStyles.textStyleBlack16With400,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: AppTextStyles.textStyleBlack14With700,
                    ),
                    Text(
                      '123 Main St, City, Country',
                      style: AppTextStyles.textStyleBlack16With400,
                    ),
                  ],
                ),
              ],
            ),
            18.rVerticalSizedBox(),
            widget.isSeller
                ? Row(
                    children: [
                      Text(
                        "Change Order Status",
                        style: AppTextStyles.textStyleBlack14With400,
                      ),
                      const Spacer(),
                      PopupMenuButton<OrderStatus>(
                        enabled: widget.orderDetailModel.getOrderStatusType() !=
                            OrderStatus.Completed,
                        initialValue:
                            widget.orderDetailModel.getOrderStatusType(),
                        onSelected: (OrderStatus newValue) {
                          setState(() {
                            widget.orderDetailModel.setOrderStatus(newValue);
                            widget.orderStatusChange(newValue);
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return List.generate(OrderStatus.values.length,
                              (index) {
                            return PopupMenuItem<OrderStatus>(
                              value: OrderStatus.values[index],
                              child: Row(
                                children: [
                                  Text(OrderStatus.values[index].name)
                                ],
                              ),
                            );
                          });
                        },
                        child: Container(
                          decoration: AppTheme.getStatusBackgroundColor(
                              widget.orderDetailModel.getOrderStatusType()),
                          child: Text(
                            widget.orderDetailModel.getOrderStatusType().name,
                            style: AppTheme.getStatusColor(
                                widget.orderDetailModel.getOrderStatusType()),
                          ).paddingUpSide816(),
                        ),
                      ),
                    ],
                  ).paddingSideOnly(bottom: 16)
                : AppSizedBox.sizedBox0,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          if (widget.isSeller) {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: widget.orderDetailModel.userPhone,
                            );
                            await launchUrl(launchUri);
                          } else {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: widget.orderDetailModel.storePhone,
                            );
                            await launchUrl(launchUri);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenColorCode),
                        icon: const Icon(
                          Icons.call,
                          size: 16,
                        ),
                        label: Text(
                          widget.isSeller ? "Call User" : "Call Restaurant",
                          style: AppTextStyles.textStyleBlack12With400
                              .copyWith(color: AppColor.primaryColor),
                        ))),
                12.rHorizontalSizedBox(),
                Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          String url =
                              "https://www.google.com/maps/search/?api=1&query=44.651916,-63.584507";
                          final uri = Uri(
                              scheme: 'geo',
                              host: '0,0',
                              queryParameters: {'q': '44.651916,-63.584507'});
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenColorCode),
                        icon: const Icon(
                          Icons.my_location,
                          size: 16,
                        ),
                        label: Text(
                          'Track Order',
                          style: AppTextStyles.textStyleBlack12With400
                              .copyWith(color: AppColor.primaryColor),
                        ))),
              ],
            ),
          ],
        ).paddingAll16(),
      ).paddingHorizontal12(),
    );
  }
}
