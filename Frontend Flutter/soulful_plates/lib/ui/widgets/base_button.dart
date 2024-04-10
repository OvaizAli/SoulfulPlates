import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/size_config.dart';
import '../../utils/extensions.dart';

///[BaseButton] with [text] that will be shown, you can give its [textStyle[ or just [textColor]
///by default [isOutlined] is false, when it will given true then borderWidth will be 0 or else 1
///by default [textColor] is [ColorConstant.textColorTwo] when [isOutlined] = true, else it will be [ColorConstant.white]
///by default [buttonBorderColor] is Theme's primaryColor
///by default [isRounded] = true with default buttonBorderRadius [SizeConstant.borderRadius4]
///[onSubmit] will run whenever button is clicked
///
/// Example:
///                    BaseButton(
///                         widgetKey: 'Progress Bar show button',
///                         text: 'Show Progress Bar',
///                         onSubmit: () {
///                           setState(() {
///                             showProgressbar = !showProgressbar;
///                           });
///                         }),

class BaseButton extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final Function onSubmit;
  final double? height;
  final double? width;
  final bool isOutlined;
  final double? fontSize;
  final Color? buttonColor;
  final Color? buttonBorderColor;
  final double? buttonBorderRadius;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final bool isRounded;
  final bool enabled;
  final bool isWrapWidth;
  final String? key2;

  const BaseButton({
    Key? key,
    required this.text,
    required this.onSubmit,
    this.isOutlined = false,
    this.textColor,
    this.height,
    this.width,
    this.fontSize = 16,
    this.buttonColor,
    this.buttonBorderColor,
    this.buttonBorderRadius,
    this.textStyle,
    this.enabled = true,
    this.leadingIcon,
    this.leadingWidget,
    this.isRounded = true,
    this.isWrapWidth = false,
    this.key2,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BaseButtonState();
  }
}

class BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.enabled ? 1.0 : 0.2,
      child: Container(
        height: widget.height, //?? 40.rHeight(),
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.isOutlined
              ? AppColor.transparent
              : widget.buttonColor ?? Theme.of(context).primaryColor,
          borderRadius: widget.isRounded
              ? (widget.buttonBorderRadius != null)
                  ? BorderRadius.circular(widget.buttonBorderRadius!)
                  : BorderRadius.circular(50.rSize())
              : BorderRadius.circular(0),
          border: Border.all(
            width: widget.isOutlined ? 1 : 0,
            color: widget.buttonBorderColor ??
                (widget.isOutlined
                    ? Theme.of(context).primaryColor
                    : AppColor.transparent),
          ),
        ),
        child: InkWell(
          key: widget.key2 != null ? Key(widget.key2!) : UniqueKey(),
          onTap: () {
            if (widget.enabled) {
              widget.onSubmit();
            }
          },
          child: Row(
                  mainAxisSize:
                      widget.isWrapWidth ? MainAxisSize.min : MainAxisSize.max,
                  children: rowWidgetList())
              .paddingVertical12(),
        ),
      ),
    );
  }

  List<Widget> rowWidgetList() {
    List<Widget> widgetList = [];
    if (widget.leadingIcon != null) {
      widgetList.add(24.rHorizontalSizedBox());
      widgetList.add(Icon(
        widget.leadingIcon,
        size: 28.rWidth(),
        color: Theme.of(context).primaryColor,
      ));
      widgetList.add(8.rHorizontalSizedBox());
    } else if (widget.leadingWidget != null) {
      widgetList.add(24.rHorizontalSizedBox());
      widgetList.add(widget.leadingWidget!);
      widgetList.add(8.rHorizontalSizedBox());
    } else {
      widgetList.add(24.rHorizontalSizedBox());
    }

    if (widget.isWrapWidth) {
      widgetList.add(Text(
        widget.text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: widget.textStyle ??
            TextStyle(
                color: widget.textColor ??
                    (widget.isOutlined
                        ? Theme.of(context).primaryColor
                        : AppColor.whiteTextColor),
                fontSize: widget.fontSize,
                letterSpacing: 0.25,
                fontWeight: FontWeight.w700),
        overflow: TextOverflow.ellipsis,
      ));
      widgetList.add(24.rHorizontalSizedBox());
    } else {
      widgetList.add(Expanded(
        child: Text(
          widget.text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: widget.textStyle ??
              TextStyle(
                  color: widget.textColor ??
                      (widget.isOutlined
                          ? Theme.of(context).primaryColor
                          : AppColor.whiteTextColor),
                  fontSize: widget.fontSize,
                  letterSpacing: 0.25,
                  fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
        ),
      ));
    }

    return widgetList;
  }
}
