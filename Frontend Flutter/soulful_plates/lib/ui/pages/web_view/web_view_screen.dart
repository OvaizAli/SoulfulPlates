import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/extensions.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double progress = 0;
  WebViewModel? webViewModel;

  @override
  void initState() {
    webViewModel = Get.arguments as WebViewModel;
    _controller = WebViewController();
    _controller.loadFlutterAsset(webViewModel?.url ?? '');
    super.initState();
  }

  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(webViewModel?.title ?? ''),
      ),
      backgroundColor: AppColor.whiteTextColor,
      body: SafeArea(child: _getBody(context: context)),
    );
  }

  Widget _getBody({required BuildContext context}) {
    return Stack(
      children: [WebViewWidget(controller: _controller)],
    ).paddingAll4();
  }
}

class WebViewModel {
  String url;
  String title;

  WebViewModel(this.url, this.title);
}
