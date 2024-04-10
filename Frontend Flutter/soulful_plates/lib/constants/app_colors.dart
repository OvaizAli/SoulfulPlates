// import 'package:config/config.dart' as c;
import 'package:config/config.dart' as c;
import 'package:flutter/material.dart';

class AppColor {
  ///basic theme colors
  static const Color primaryColor = c.primaryColor;
  static const Color profileBackground = Color(0xFFC4C201);
  // Seller color = #242F34
  // buyer color = #02690B
  static const Color gradientSecondColor = Color(0xffE47E07);
  static const Color primaryColorLight = Color(0xffE43C08);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color linksColor = Color(0xff3F69FF);
  static const Color redColor = Color(0xffcf0f22);
  static const Color purpleColor = Color(0xFF9C27B0);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color orangeColor = Color(0xffE47E07);

  static const Color greenColorCode = Color(0xFFF3FFF9);
  static const Color greenStart = Color(0xff078a03);
  static const Color greenEnd = Color(0xff62c528);

  /// Only below text colors and combinations used for icons and most of the ui screens
  /// took nearly equal color rather than adding other colors
  static const Color lightBackgroundColor = Color(0xFFF1FAFF);
  static const Color blackTextColor = Color(0xFF000000);
  static const Color black2TextColor = Color(0xff676C72);
  static const Color black3TextColor = Color(0xFFA2A7AB);
  static const Color black4TextColor = Color(0xFFC1C4C7);
  static const Color black5TextColor = Color(0xFFF6F6F6);
  static const Color whiteTextColor = Color(0xFFFFFFFF);

  /// this is the custom class for color which can be use in all over the app
  static const Color transparent = Colors.transparent;
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color greenColor = Color(0xFF31D0AA);
  static const Color emeraldGreen = Color(0xFF183D3D);
}

class ColorThemeModel {
  Color primaryColor;
  Color primaryColorDark;
  Color secondaryColor;
  Color backgroundColor;
  Color bottomAppBarColor;
  Color? buttonThemeColor;
  Color textFieldLabelTextColor;
  Color textFieldHelperTextColor;
  Color errorColor;
  Brightness brightness;
  String? fontFamily;

  ColorThemeModel({
    required this.primaryColor,
    required this.primaryColorDark,
    required this.secondaryColor,
    this.backgroundColor = AppColor.backgroundColor,
    this.bottomAppBarColor = AppColor.backgroundColor,
    this.textFieldLabelTextColor = AppColor.blackTextColor,
    this.textFieldHelperTextColor = AppColor.black3TextColor,
    this.errorColor = Colors.red,
    this.brightness = Brightness.light,
    this.buttonThemeColor,
    this.fontFamily,
  });
}
