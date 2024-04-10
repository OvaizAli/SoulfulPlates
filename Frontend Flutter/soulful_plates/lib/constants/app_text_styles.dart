import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'size_config.dart';

class AppTextStyles {
  /// text style for font weight 400
  static textStyle400({
    double fontSize = 24,
    FontStyle fontStyle = FontStyle.normal,
    Color textColor = AppColor.whiteTextColor,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: FontWeight.w400,
      color: textColor,
    );
  }

  // Use below text style from now onwards.
  static final textStylePrimary16With600 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w500,
    color: AppColor.primaryColor,
  );

  // Use below text style from now onwards.
  static final textStyleBlue16With400 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    color: AppColor.linksColor,
  );
  static final textStyleBlue14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    color: AppColor.linksColor,
  );
  static final textStylePrimary15With400 = TextStyle(
    fontSize: SizeConfig.font15,
    fontWeight: FontWeight.w400,
    color: AppColor.primaryColor,
  );

  static final textStylePrimary14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.primaryColor,
  );
  static final textStylePrimary12With400 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w400,
    color: AppColor.primaryColor,
  );
  static final textStylePrimaryLight14With700 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w700,
    color: AppColor.primaryColorLight,
  );
  static final textStyleBlackThree14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.black3TextColor,
  );
  static final textStyleBlackTwo14With600 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.black2TextColor,
  );
  static final textStyleBlackThree12With400 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w400,
    color: AppColor.black3TextColor,
  );
  static final textStylePrimary14With600 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w500,
    color: AppColor.primaryColor,
  );
  static final textStylePrimary15With600 = TextStyle(
    fontSize: SizeConfig.font15,
    fontWeight: FontWeight.w500,
    color: AppColor.primaryColor,
  );

  static final textStyleBlackTwo14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.black2TextColor,
  );

  static final textStyleBlackTwo5_14With400 = TextStyle(
      fontSize: SizeConfig.font14,
      fontWeight: FontWeight.w400,
      color: AppColor.black2TextColor,
      letterSpacing: .5);

  static final textStyleBlackTwo12With600 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w500,
    color: AppColor.black2TextColor,
  );

  static final textStyleWhite13With400 = TextStyle(
    fontSize: SizeConfig.font13,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlack13With400 = TextStyle(
    fontSize: SizeConfig.font13,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );

  static final textStyleWhite16With700 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteTextColor,
  );

  static final textStyleWhite15With400 = TextStyle(
    fontSize: SizeConfig.font15,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlack16With600 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );
  static final textStyleBlackTwo16With600 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w500,
    color: AppColor.black2TextColor,
  );

  static final textStyleBlack15With400 = TextStyle(
    fontSize: SizeConfig.font15,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack16With500 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack16With400 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );
  static final textStyleBlackTwo16With400 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w400,
    color: AppColor.black2TextColor,
  );

  static final textStyleBlack40With700 = TextStyle(
    fontSize: SizeConfig.font40,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlackThree40with700 = TextStyle(
    fontSize: SizeConfig.font40,
    fontWeight: FontWeight.w700,
    color: AppColor.black3TextColor,
  );

  static final textStylePrimary36With700 = TextStyle(
    fontSize: SizeConfig.font36,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryColor,
  );
  static final textStylePrimary22With700 = TextStyle(
    fontSize: SizeConfig.font22,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryColor,
  );
  static final textStyleBlack36With700 = TextStyle(
    fontSize: SizeConfig.font36,
    fontWeight: FontWeight.bold,
    color: AppColor.blackColor,
  );

  static final textStyleWhite18With600 = TextStyle(
    fontSize: SizeConfig.font18,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlack18With700 = TextStyle(
    fontSize: SizeConfig.font18,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );
  static final textStyleBlack18With400 = TextStyle(
    fontSize: SizeConfig.font18,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );

  static final textStylePrimary18With400 = TextStyle(
    fontSize: SizeConfig.font18,
    fontWeight: FontWeight.w400,
    color: AppColor.primaryColor,
  );

  static const textStyleAppbar = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack22With700 = TextStyle(
    fontSize: SizeConfig.font22,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );
  static final textStyleBlack12With700 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );

  static final textStyleWhite22With700 = TextStyle(
    fontSize: SizeConfig.font18,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteTextColor,
  );
  static final textStyleWhite32With700 = TextStyle(
    fontSize: SizeConfig.font32,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteTextColor,
  );
  static final textStyleProfileInitials = TextStyle(
    fontSize: SizeConfig.font28,
    fontWeight: FontWeight.w500,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlack14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );

  static final textStyleUnderLineBlack14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlackOTP = TextStyle(
    fontSize: SizeConfig.font22,
    fontWeight: FontWeight.bold,
    color: AppColor.blackTextColor,
  );
  static final textStyleGreyOTP = TextStyle(
    fontSize: SizeConfig.font22,
    fontWeight: FontWeight.bold,
    color: AppColor.black4TextColor,
  );

  static final textStyleGreen14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.greenColor,
  );
  static final textStyleRed14With400 = TextStyle(
      fontSize: SizeConfig.font14,
      fontWeight: FontWeight.w400,
      color: AppColor.redColor);
  static final textStyleRed12With400 = TextStyle(
      fontSize: SizeConfig.font12,
      fontWeight: FontWeight.w400,
      color: AppColor.redColor);

  static final textStyleBlack14With800 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w800,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack12With400 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack14With700 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack16With700 = TextStyle(
    fontSize: SizeConfig.font16,
    fontWeight: FontWeight.w700,
    color: AppColor.blackTextColor,
  );

  static final textStyleBlack14With500 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );
  static final textStyleWhite14With500 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w500,
    color: AppColor.whiteTextColor,
  );
  static final textStyleWhite14With400 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );
  static final textStyleWhite14With700 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlack14With600 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );
  static final textStyleWhite14With600 = TextStyle(
    fontSize: SizeConfig.font14,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlack12With600 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );

  static final textStyleWhite12With400 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );

  static final textStyleWhite12With700 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w700,
    color: AppColor.whiteTextColor,
  );

  static final textStyleBlackTwo12With400 = TextStyle(
    fontSize: SizeConfig.font12,
    fontWeight: FontWeight.w400,
    color: AppColor.black2TextColor,
  );

  static final textStyleBlack10With400 = TextStyle(
    fontSize: SizeConfig.font10,
    fontWeight: FontWeight.w400,
    color: AppColor.blackTextColor,
  );
  static final textStyleBlackTwo10With400 = TextStyle(
    fontSize: SizeConfig.font10,
    fontWeight: FontWeight.w400,
    color: AppColor.black2TextColor,
  );
  static final textStyleBlackTwo10With500 = TextStyle(
    fontSize: SizeConfig.font10,
    fontWeight: FontWeight.w500,
    color: AppColor.black2TextColor,
  );
  static final textStyleBlack10With600 = TextStyle(
    fontSize: SizeConfig.font10,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );

  static final textStyleWhite10With400 = TextStyle(
    fontSize: SizeConfig.font10,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );
  static final textStyleWhite8With400 = TextStyle(
    fontSize: SizeConfig.font8,
    fontWeight: FontWeight.w400,
    color: AppColor.whiteTextColor,
  );
  static final textStyleRed10With400 = TextStyle(
    fontSize: SizeConfig.font10,
    fontWeight: FontWeight.w400,
    color: AppColor.redColor,
  );

  static final textStyleBlack60With500 = TextStyle(
    fontSize: SizeConfig.font60,
    fontWeight: FontWeight.w500,
    color: AppColor.blackTextColor,
  );

  static final TextStyle titleStyle = TextStyle(
    fontSize: SizeConfig.font20, // Choose an appropriate size for titles
    fontWeight: FontWeight.bold, // Common for titles
    color: AppColor.primaryColor, // Assuming you have a primary color defined
  );
}
