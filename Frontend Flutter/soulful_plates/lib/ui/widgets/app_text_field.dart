import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_paddings.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_theme.dart';
import '../../utils/extensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autoFocus;
  final String? obscuringCharacter;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final String? hintText;
  final List<TextInputFormatter> inputFormatters;
  final Widget? suffixWidget;
  final bool obscureText;
  final bool hasErrorAvailable;
  final String? errorMessage;
  final String? counterText;
  final Widget? prefixWidget;
  final bool? isTextFieldDisable;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final bool showLabel;
  final int? maxLength;
  final TextStyle? style;

  const AppTextField(
      {Key? key,
      this.controller,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.sentences,
      this.onChanged,
      this.validator,
      this.maxLength,
      this.style,
      this.obscuringCharacter,
      this.onTap,
      this.onSubmitted,
      this.focusNode,
      this.hintText,
      this.inputFormatters = const [],
      this.suffixWidget,
      this.obscureText = false,
      this.prefixWidget,
      this.errorMessage = '',
      this.isTextFieldDisable = true,
      this.maxLines = 1,
      this.minLines = 1,
      this.counterText,
      this.hasErrorAvailable = true,
      this.readOnly = false,
      this.showLabel = true,
      this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          obscuringCharacter: obscuringCharacter ?? '•',
          controller: controller,
          readOnly: readOnly ?? false,
          autofocus: autoFocus,
          validator: validator,
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: style ?? AppTextStyles.textStyleBlack14With400,
          cursorColor: AppColor.blackTextColor,
          textAlign: TextAlign.start,
          keyboardType: keyboardType == TextInputType.number
              ? GetPlatform.isIOS
                  ? const TextInputType.numberWithOptions(
                      decimal: true, signed: true)
                  : keyboardType
              : keyboardType,
          selectionControls: Platform.isIOS
              ? CupertinoTextSelectionControls()
              : MaterialTextSelectionControls(),
          enableInteractiveSelection: true,
          onFieldSubmitted: onSubmitted,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onTap: onTap,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          obscureText: obscureText,
          enabled: isTextFieldDisable,
          decoration: InputDecoration(
            prefixIcon: prefixWidget,
            filled: true,
            fillColor: AppColor.black5TextColor,
            hintText: hintText,
            hintMaxLines: 4,
            alignLabelWithHint: showLabel ? true : null,
            contentPadding: contentPadding ?? AppPaddings.defaultPadding12,
            labelStyle: AppTextStyles.textStyleBlack16With400,
            hintStyle: AppTextStyles.textStyleBlackTwo14With400,
            focusColor: AppColor.black5TextColor,
            counterText: counterText,
            labelText:
                null, //showLabel ? (controller?.text     .isNotNullOrEmpty??false)? hintText:null : null,
            focusedBorder: readOnly != null && readOnly == true
                ? const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.black2TextColor,
                      width: 1,
                    ),
                  )
                : AppTheme.borderWidget(borderWidth: 1),
            focusedErrorBorder: AppTheme.errorBorderWidget(borderWidth: 2),
            border: AppTheme.borderWidget(),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.red,
                )),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.transparent,
                width: 1,
              ),
            ),
            suffixIcon: suffixWidget,
          ),
        ),
        Text(errorMessage ?? '',
                textAlign: TextAlign.start,
                style: AppTextStyles.textStyleRed10With400)
            .paddingSideOnly(top: 2)
            .visibleWhen(isVisible: hasErrorAvailable),
      ],
    );
  }
}
