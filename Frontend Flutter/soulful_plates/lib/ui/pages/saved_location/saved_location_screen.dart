import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulful_plates/constants/app_colors.dart';
import 'package:soulful_plates/constants/app_sized_box.dart';
import 'package:soulful_plates/constants/app_text_styles.dart';
import 'package:soulful_plates/constants/enums/view_state.dart';
import 'package:soulful_plates/constants/size_config.dart';
import 'package:soulful_plates/routing/route_names.dart';
import 'package:soulful_plates/ui/pages/saved_location/saved_location_controller.dart';
import 'package:soulful_plates/ui/widgets/base_common_widget.dart';
import 'package:soulful_plates/utils/extensions.dart';
import 'package:soulful_plates/utils/utils.dart';

class SavedLocationScreen extends GetView<SavedLocationController>
    with BaseCommonWidget {
  SavedLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Location"),
      ),
      backgroundColor: AppColor.whiteColor,
      floatingActionButton: FloatingActionButton(
        tooltip: "Go to add location",
        child: const Icon(
          Icons.add_location_alt_outlined,
          size: 24,
          color: AppColor.whiteColor,
        ),
        onPressed: () {
          Get.toNamed(editLocationViewRoute);
        },
      ),
      body: SafeArea(
        child: GetBuilder(
          init: controller,
          initState: (state) async {},
          builder: (SavedLocationController model) {
            return getBody(context);
          },
        ),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return Column(
      children: [
        12.rVerticalSizedBox(),
        Expanded(
          child: Stack(
            children: [
              Utils.locationList.isNotEmpty
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
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.dataList.length,
                          separatorBuilder: (context, index) {
                            return 2.rVerticalGreySizedBox();
                          },
                          itemBuilder: (context, index) {
                            if (index < controller.dataList.length) {
                              return ListTile(
                                title: Text(
                                    controller.dataList[index].label ?? ''),
                                subtitle: Text(
                                    controller.dataList[index].street ??
                                        ''), // Display address
                                onTap: () async {
                                  var response = await Get.toNamed(
                                      editLocationViewRoute,
                                      arguments: controller.dataList[index]);
                                  controller.resetPagination();
                                  if (response) {
                                    print(response);
                                  }
                                },
                              );
                            } else if (controller.moreLoading ==
                                ViewStateEnum.busy) {
                              return controller.loadMoreLoader(
                                  color: AppColor.blackColor);
                            } else {
                              return AppSizedBox.sizedBox0;
                            }
                          },
                        ),
                      ),
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
            ],
          ).paddingSymmetricSide(vertical: 8, horizontal: 16),
        ),
      ],
    );
  }
}
