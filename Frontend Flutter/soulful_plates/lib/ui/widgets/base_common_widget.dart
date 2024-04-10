import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/enums/view_state.dart';
import '../../constants/size_config.dart';
import '../../utils/extensions.dart';

/*
All common widgets through out the application is mentioned here.
 */
mixin BaseCommonWidget {
  Widget getProgressBar(ViewStateEnum viewState) {
    if (viewState == ViewStateEnum.busy) {
      return Container(
          color: AppColor.blackTextColor.withOpacity(.2),
          child: getLoadingWidget());
    } else {
      return Container();
    }
  }

  Widget getLoadingWidget() {
    return Container(
      color: AppColor.blackTextColor.withOpacity(.2),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget getPaginationProgressBar(ViewStateEnum viewState,
      {List? dataList, bool showAtTop = false}) {
    if (viewState == ViewStateEnum.busy) {
      return dataList.isNotNullOrEmpty
          ? Align(
              alignment:
                  showAtTop ? Alignment.topCenter : Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: AppColor.blackTextColor.withOpacity(.2),
                height: 80,
                child: const Center(
                        child:
                            CircularProgressIndicator()) // BaseLoadMoreWidget())
                    .paddingAllDefault(),
              ),
            )
          : getLoadingWidget();
    } else {
      return Container();
    }
  }

  Widget getBottomSheetHeader({String? title, required onBack}) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title ?? '',
          style: AppTextStyles.textStyleBlack22With700,
        ).visibleWhen(isVisible: title.isNotNullOrEmpty)),
        InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppIcons.iconClose,
              color: AppColor.blackColor,
              width: 24.rSize(),
              height: 24.rSize(),
            )),
      ],
    );
  }
}
