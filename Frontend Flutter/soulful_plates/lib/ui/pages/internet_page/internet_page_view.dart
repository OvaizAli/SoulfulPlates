import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/language/language_constants.dart';
import '../../../constants/size_config.dart';
import '../../../utils/connection_status.dart';
import '../../../utils/extensions.dart';
import '../../widgets/base_loading_widget.dart';

class InternetPageView extends StatefulWidget {
  const InternetPageView({Key? key}) : super(key: key);

  @override
  State<InternetPageView> createState() => _InternetPageViewState();
}

class _InternetPageViewState extends State<InternetPageView> {
  bool isLoading = false;

  @override
  void initState() {
    ConnectionStatus.isInternetPageVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await checkInternetConnection();
              },
              child: Icon(
                Icons.refresh,
                color: AppColor.blackColor,
                size: 24.rSize(),
              ).paddingAll16(),
            ).visibleWhen(
                isVisible: !isLoading,
                subWidget: const BaseLoadingWidget().paddingAll16()),
            8.rVerticalSizedBox(),
            Text(
              LanguageConst.internetNotAvailable,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyleBlack16With600,
            ),
          ],
        ).paddingScreen(),
      ),
    );
  }

  checkInternetConnection() async {
    bool hasInternetConnection =
        await ConnectionStatus().checkConnection(fromInternetScreen: true);
    debugPrint('This is the internet connection $hasInternetConnection');
    if (hasInternetConnection) {
      Get.back();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    ConnectionStatus.isInternetPageVisible = false;
    super.dispose();
  }
}
