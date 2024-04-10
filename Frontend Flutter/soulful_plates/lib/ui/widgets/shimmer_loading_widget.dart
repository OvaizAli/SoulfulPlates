import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';

Widget baseShimmer(
    {required Widget child, Color? baseColor, Color? highlightColor}) {
  try {
    Color base = baseColor ?? AppColor.black4TextColor;
    Color highlight = highlightColor ?? AppColor.black5TextColor;
    return Shimmer.fromColors(
      enabled: true,
      baseColor: base,
      highlightColor: highlight,
      child: child,
    );
  } catch (e) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
