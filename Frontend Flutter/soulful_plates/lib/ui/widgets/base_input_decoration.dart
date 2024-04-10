import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_text_styles.dart';

///[baseInputDecoration] returns Custom Snackbar whose by default [fillColor] is Theme's inputDecorationTheme.fillColor
///by default [focusesBorderColor] is of Theme's primaryColor
///by default [enabledBorderColor] is of Theme's primaryTextTheme.headline1.color
///
/// Example:
///        baseInputDecoration(
///                 context: context,
///                 labelText: 'Base text form field'),

InputDecoration baseInputDecoration(
    {required BuildContext context,
    String? hintText,
    Widget? suffixIcon,
    String? helperText,
    TextStyle? hintTextStyle,
    String? labelText,
    TextStyle? labelTextStyle,
    Widget? prefixIcon,
    double borderRadius = 8,
    Color? focusedBorderColor,
    Color? enabledBorderColor,
    EdgeInsetsGeometry? padding,
    Color? fillColor,
    bool isRequired = false}) {
  return InputDecoration(
    fillColor: fillColor ?? AppColor.black5TextColor,
    hintText: hintText,
    labelText: labelText,
    filled: true,
    enabled: false,
    hintStyle: hintTextStyle ?? AppTextStyles.textStyleBlack14With400,
    labelStyle: labelTextStyle ?? AppTextStyles.textStyleBlack14With400,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
            color: focusedBorderColor ?? Theme.of(context).primaryColor)),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: padding ?? AppPaddings.paddingUp4Side12,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: AppColor.redColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: AppColor.redColor),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide:
            BorderSide(color: enabledBorderColor ?? AppColor.black4TextColor)),
    helperText: helperText,
  );
}
