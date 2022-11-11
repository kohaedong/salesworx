/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/base_shimmer.dart
 * Created Date: 2021-09-18 18:29:48
 * Last Modified: 2021-12-10 00:07:25
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:async';

import 'package:salesworxm/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer {
  BaseShimmer({required this.child});
  Widget child;
  static shimmerBox(double height, double width) {
    return Container(
      width: width,
      height: height,
      color: AppColors.whiteText,
    );
  }

  Widget build() {
    var shimmerSwich = ValueNotifier(true);
    Timer(Duration(seconds: 15), () => shimmerSwich.value = false);
    return ValueListenableBuilder<bool>(
        valueListenable: shimmerSwich,
        builder: (context, swich, _) {
          return Shimmer.fromColors(
            enabled: swich,
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: child,
          );
        });
  }
}
