import 'package:flutter/material.dart';

import 'size_config.dart';

class AppPaddings {
  static EdgeInsets nonePadding = const EdgeInsets.all(0.0);
  static EdgeInsets defaultPadding = EdgeInsets.all(8.rSize());
  static EdgeInsets defaultPadding16 = EdgeInsets.all(16.0.rSize());
  static EdgeInsets defaultPadding4 = EdgeInsets.all(4.rSize());
  static EdgeInsets defaultPadding6 = EdgeInsets.all(6.rSize());
  static EdgeInsets defaultPadding2 = EdgeInsets.all(2.rSize());
  static EdgeInsets defaultPadding26 = EdgeInsets.all(26.rSize());
  static EdgeInsets defaultPadding12 = EdgeInsets.all(12.rSize());
  static EdgeInsets defaultPadding14 = EdgeInsets.all(14.rSize());
  static EdgeInsets defaultPadding36 = EdgeInsets.all(36.rSize());

  static EdgeInsets horizontal4 = EdgeInsets.symmetric(horizontal: 4.rWidth());
  static EdgeInsets horizontal16 =
      EdgeInsets.symmetric(horizontal: 16.rWidth());
  static EdgeInsets horizontal24 =
      EdgeInsets.symmetric(horizontal: 24.rWidth());
  static EdgeInsets horizontal28 =
      EdgeInsets.symmetric(horizontal: 28.rWidth());
  static EdgeInsets horizontal36 =
      EdgeInsets.symmetric(horizontal: 36.rWidth());
  static EdgeInsets horizontal12 =
      EdgeInsets.symmetric(horizontal: 12.rWidth());
  static EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: 8.rWidth());

  static EdgeInsets vertical4 = EdgeInsets.symmetric(vertical: 4.rHeight());
  static EdgeInsets vertical6 = EdgeInsets.symmetric(vertical: 6.rHeight());
  static EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: 8.rHeight());
  static EdgeInsets vertical28 = EdgeInsets.symmetric(vertical: 28.rHeight());
  static EdgeInsets vertical12 = EdgeInsets.symmetric(vertical: 12.rHeight());
  static EdgeInsets vertical16 = EdgeInsets.symmetric(vertical: 16.rHeight());
  static EdgeInsets vertical20 = EdgeInsets.symmetric(vertical: 20.rHeight());

  static EdgeInsets paddingUp4Side8 =
      EdgeInsets.symmetric(vertical: 4.rHeight(), horizontal: 8.rWidth());
  static EdgeInsets paddingUp2Side6 =
      EdgeInsets.symmetric(vertical: 2.rHeight(), horizontal: 6.rWidth());
  static EdgeInsets paddingUp2Side4 =
      EdgeInsets.symmetric(vertical: 2.rHeight(), horizontal: 4.rWidth());
  static EdgeInsets paddingUp8Side4 =
      EdgeInsets.symmetric(vertical: 8.rHeight(), horizontal: 4.rWidth());
  static EdgeInsets paddingUp12Side8 =
      EdgeInsets.symmetric(vertical: 12.rHeight(), horizontal: 8.rWidth());
  static EdgeInsets paddingUp12Side16 =
      EdgeInsets.symmetric(vertical: 12.rHeight(), horizontal: 16.rWidth());
  static EdgeInsets paddingUp8Side12 =
      EdgeInsets.symmetric(vertical: 8.rHeight(), horizontal: 12.rWidth());
  static EdgeInsets paddingUp8Side16 =
      EdgeInsets.symmetric(vertical: 8.rHeight(), horizontal: 16.rWidth());
  static EdgeInsets paddingUp12Side4 =
      EdgeInsets.symmetric(vertical: 12.rHeight(), horizontal: 4.rWidth());
  static EdgeInsets paddingUp4Side12 =
      EdgeInsets.symmetric(vertical: 4.rHeight(), horizontal: 12.rWidth());

  static EdgeInsets paddingRight4 = EdgeInsets.only(right: 4.rWidth());
  static EdgeInsets paddingLeft4 = EdgeInsets.only(left: 4.rWidth());
  static EdgeInsets paddingLeft10 = EdgeInsets.only(left: 10.rWidth());
  static EdgeInsets paddingUp4 = EdgeInsets.only(top: 4.rHeight());
  static EdgeInsets paddingUp2 = EdgeInsets.only(top: 2.rHeight());
  static EdgeInsets paddingDown4 = EdgeInsets.only(bottom: 4.rHeight());
  static EdgeInsets paddingRight8 = EdgeInsets.only(right: 8.rWidth());
  static EdgeInsets paddingLeft8 = EdgeInsets.only(left: 8.rWidth());
  static EdgeInsets paddingLeft90 = EdgeInsets.only(left: 90.rWidth());
  static EdgeInsets paddingRight90 = EdgeInsets.only(right: 90.rWidth());
  static EdgeInsets paddingUp8 = EdgeInsets.only(top: 8.rHeight());
  static EdgeInsets paddingDown8 = EdgeInsets.only(bottom: 8.rHeight());
  static EdgeInsets paddingDown10 = EdgeInsets.only(bottom: 10.rHeight());

  static getContentPadding(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.only(
      left: left.rWidth(),
      right: right.rWidth(),
      top: top.rHeight(),
      bottom: bottom.rHeight(),
    );
  }

  static getSymmetricPadding({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal.rWidth(),
      vertical: vertical.rHeight(),
    );
  }

  static getScreenPadding() {
    return defaultPadding16;
  }
}
