import 'package:flutter/material.dart';

import '../constants/app_paddings.dart';
import '../constants/app_sized_box.dart';
import '../constants/size_config.dart';

extension StringChecks on String? {
  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;

  bool get isNullOrEmpty =>
      this == null || (this != null && this!.trim().isEmpty);
}

extension ListChecks on List? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

extension CustomWidget on Widget {
  /// Padding extension example
  /// Text("Value of the counter is $value").paddingAll16()
  Widget paddingAllSide(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetricHorizontal(double padding) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: this,
      );

  Widget paddingSymmetricVertical(double padding) => Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: this,
      );

  Widget paddingSymmetricSide(
          {required double vertical, required double horizontal}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this,
      );

  Widget paddingSideOnly(
          {double left = 0,
          double top = 0,
          double right = 0,
          double bottom = 0}) =>
      Padding(
        padding: AppPaddings.getContentPadding(
            left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  Widget paddingScreen() => Padding(
        padding: AppPaddings.getScreenPadding(),
        child: this,
      );

  Widget paddingScreenHorizontal() => Padding(
        padding: AppPaddings.horizontal16,
        child: this,
      );

  Widget paddingAll4() => Padding(
        padding: AppPaddings.defaultPadding4,
        child: this,
      );
  Widget paddingAll6() => Padding(
        padding: AppPaddings.defaultPadding6,
        child: this,
      );

  Widget paddingAll12() => Padding(
        padding: AppPaddings.defaultPadding12,
        child: this,
      );

  Widget paddingAll14() => Padding(
        padding: AppPaddings.defaultPadding14,
        child: this,
      );

  Widget paddingAllDefault() => Padding(
        padding: AppPaddings.defaultPadding,
        child: this,
      );

  Widget paddingAll16() => Padding(
        padding: AppPaddings.defaultPadding16,
        child: this,
      );

  Widget paddingAll26() => Padding(
        padding: AppPaddings.defaultPadding26,
        child: this,
      );

  Widget paddingAll36() => Padding(
        padding: AppPaddings.defaultPadding36,
        child: this,
      );

  Widget paddingAll2() => Padding(
        padding: AppPaddings.defaultPadding2,
        child: this,
      );

  Widget paddingHorizontal8() => Padding(
        padding: AppPaddings.horizontal8,
        child: this,
      );

  Widget paddingHorizontal4() {
    return Padding(
      padding: AppPaddings.horizontal4,
      child: this,
    );
  }

  Widget paddingHorizontal12() => Padding(
        padding: AppPaddings.horizontal12,
        child: this,
      );

  Widget paddingHorizontal16() => Padding(
        padding: AppPaddings.horizontal16,
        child: this,
      );

  Widget paddingHorizontal24() => Padding(
        padding: AppPaddings.horizontal24,
        child: this,
      );

  Widget paddingHorizontal28() => Padding(
        padding: AppPaddings.horizontal28,
        child: this,
      );

  Widget paddingHorizontal36() => Padding(
        padding: AppPaddings.horizontal36,
        child: this,
      );

  Widget paddingVertical8() => Padding(
        padding: AppPaddings.vertical8,
        child: this,
      );

  Widget paddingVertical4() => Padding(
        padding: AppPaddings.vertical4,
        child: this,
      );

  Widget paddingVertical6() => Padding(
        padding: AppPaddings.vertical6,
        child: this,
      );

  Widget paddingVertical28() => Padding(
        padding: AppPaddings.vertical28,
        child: this,
      );

  Widget paddingVertical12() => Padding(
        padding: AppPaddings.vertical12,
        child: this,
      );

  Widget paddingVertical16() => Padding(
        padding: AppPaddings.vertical16,
        child: this,
      );

  Widget paddingVertical20() => Padding(
        padding: AppPaddings.vertical20,
        child: this,
      );

  Widget paddingUpSide48() => Padding(
        padding: AppPaddings.paddingUp4Side8,
        child: this,
      );
  Widget paddingUpSide26() => Padding(
        padding: AppPaddings.paddingUp2Side6,
        child: this,
      );

  Widget paddingUpSide24() => Padding(
        padding: AppPaddings.paddingUp2Side4,
        child: this,
      );

  Widget paddingUpSide412() => Padding(
        padding: AppPaddings.paddingUp4Side12,
        child: this,
      );

  Widget paddingUpSide84() => Padding(
        padding: AppPaddings.paddingUp8Side4,
        child: this,
      );

  Widget paddingUpSide812() => Padding(
        padding: AppPaddings.paddingUp8Side12,
        child: this,
      );

  Widget paddingUpSide816() => Padding(
        padding: AppPaddings.paddingUp8Side16,
        child: this,
      );

  Widget paddingUpSide124() => Padding(
        padding: AppPaddings.paddingUp12Side4,
        child: this,
      );

  Widget paddingUpSide128() => Padding(
        padding: AppPaddings.paddingUp12Side8,
        child: this,
      );

  Widget paddingUpSide1216() => Padding(
        padding: AppPaddings.paddingUp12Side16,
        child: this,
      );

  Widget visibleWhen({required bool isVisible, Widget? subWidget}) =>
      isVisible ? this : subWidget ?? AppSizedBox.sizedBox0;

  Widget addCustomAppBarStyle({Color? backgroundColor}) => SizedBox(
        width: double.infinity,
        // color: backgroundColor ?? AppColor.backgroundWhiteColor,
        child: this,
      );

  // Initialized in splash view because whole application is comes from splash
  // so we get the size and screen details then we use other functions like
  // responsive height, width and vertical, horizontal size boxes.
  Widget addSizeConfigInitialization() => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        SizeConfig().init(context, constraints);
        return this;
      });

  // Used for adding the pull down to refresh indicator
  Widget addRefreshIndicator({required RefreshCallback onRefresh}) {
    return RefreshIndicator(onRefresh: onRefresh, child: this);
  }
}

void onWidgetDidBuild({required Function callback}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
