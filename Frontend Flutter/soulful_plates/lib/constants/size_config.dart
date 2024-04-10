import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  // static double? _blockSizeHorizontal;
  // static double? _blockSizeVertical;

  static double? _safeAreaWidth;
  static double? _safeAreaHeight;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  // Define the height and width multipliers
  static double? heightMultiplier;
  static double? widthMultiplier;

  void init(BuildContext context, BoxConstraints safeAreaBox) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;

    // _blockSizeHorizontal = screenWidth! / 100;
    // _blockSizeVertical = screenHeight! / 100;

    // Calculate the multipliers
    heightMultiplier = screenHeight! / 100;
    widthMultiplier = screenWidth! / 100;

    _safeAreaWidth = safeAreaBox.maxWidth;
    _safeAreaHeight = safeAreaBox.maxHeight;
    safeBlockHorizontal = _safeAreaWidth! / 100;
    safeBlockVertical = _safeAreaHeight! / 100;

    // debugPrint(
    //     'This is the size configurations screen width/height $screenWidth/$screenHeight');
    // debugPrint(
    //     'This is the size configurations safe area width/height $_safeAreaWidth/$_safeAreaHeight');
    // debugPrint(
    //     'This is the size configurations safe block area width/height $safeBlockHorizontal/$safeBlockVertical');
    // debugPrint(
    //     'This is the size configurations safe block area scaleWidth/scaleHeight ${screenWidth! / uiWidthPx}/${screenHeight! / uiHeightPx} ');
    // debugPrint(
    //     'This is text scale factor for headers $_textScaleFactor so ${font14}  ');
    // debugPrint('This is vertical size of button 50  ${relativeHeight(6.1)}  ');
  }

  static num uiWidthPx = 375;
  static num uiHeightPx = 812;

  static double scaleWidth = screenWidth! / uiWidthPx;

  static double scaleHeight = screenHeight! / uiHeightPx;

  static double scaleText = 1; //scaleWidth;

  static getWidthPercentage(double percentage,
      {double? elseWidthPercentage, double? elseWidth}) {
    double width = Get.width * percentage;
    return Get.width > 720
        ? width
        : (elseWidth ?? Get.width * (elseWidthPercentage ?? 1));
  }

  static getWidth() {
    return Get.width;
  }

  static isTablet() {
    return Get.width > 720;
  }

  //Needs to remove the appTextWidget
  static double setSp(num fontSize) => (fontSize * scaleText);

  static final double font8 = _mediaQueryData?.textScaler.scale(8) ?? 8;
  static final double font10 = _mediaQueryData?.textScaler.scale(10) ?? 10;
  static final double font12 = _mediaQueryData?.textScaler.scale(12) ?? 12;
  static final double font13 = _mediaQueryData?.textScaler.scale(13) ?? 13;
  static final double font14 = _mediaQueryData?.textScaler.scale(14) ?? 14;
  static final double font15 = _mediaQueryData?.textScaler.scale(15) ?? 15;
  static final double font16 = _mediaQueryData?.textScaler.scale(16) ?? 16;
  static final double font17 = _mediaQueryData?.textScaler.scale(17) ?? 17;
  static final double font18 = _mediaQueryData?.textScaler.scale(18) ?? 18;
  static final double font20 = _mediaQueryData?.textScaler.scale(20) ?? 20;
  static final double font22 = _mediaQueryData?.textScaler.scale(22) ?? 22;
  static final double font25 = _mediaQueryData?.textScaler.scale(25) ?? 25;
  static final double font28 = _mediaQueryData?.textScaler.scale(28) ?? 28;
  static final double font32 = _mediaQueryData?.textScaler.scale(32) ?? 32;
  static final double font36 = _mediaQueryData?.textScaler.scale(36) ?? 36;
  static final double font40 = _mediaQueryData?.textScaler.scale(40) ?? 40;
  static final double font48 = _mediaQueryData?.textScaler.scale(48) ?? 48;
  static final double font60 = _mediaQueryData?.textScaler.scale(60) ?? 60;
}

extension ResponsiveIntExtension on int {
  double rHeight() {
    return toDouble();
  }

  Widget rVerticalSizedBox() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget rVerticalGreySizedBox() {
    return Container(
      color: AppColor.black5TextColor,
      height: toDouble(),
    );
  }

  Widget rVerticalDarkGreySizedBox() {
    return Container(
      color: AppColor.black4TextColor,
      height: toDouble(),
    );
  }

  Widget rHorizontalSizedBox() {
    return SizedBox(
      width: toDouble(),
    );
  }

  double rWidth() {
    return toDouble();
  }

  double rSize() {
    return toDouble();
  }
}

extension ResponsiveDoubleExtension on double {
  double rHeight() {
    return toDouble();
  }

  double rWidth() {
    return toDouble();
  }

  double rSize() {
    return toDouble();
  }
}
