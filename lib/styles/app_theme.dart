/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesworxm/lib/styles/app_theme.dart
 * Created Date: 2021-11-19 07:47:53
 * Last Modified: 2022-01-14 14:52:17
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:salesworxm/styles/app_size.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Apptheme {
  factory Apptheme() => _sharedInstance();
  static Apptheme? _instance;
  Apptheme._();
  static Apptheme _sharedInstance() {
    if (_instance == null) {
      _instance = Apptheme._();
    }

    return _instance!;
  }

  setScale() {
    appTheme = appTheme.copyWith(
        textTheme: TextTheme(
      headline1: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 40.sp, color: Colors.white, fontWeight: FontWeight.w400),
    ));
  }

  ThemeData appTheme = ThemeData(
      colorScheme: ColorScheme(
          primary: AppColors.primary,
          primaryVariant: AppColors.primary,
          secondary: AppColors.defaultText,
          secondaryVariant: AppColors.secondGreyColor,
          surface: AppColors.defaultText,
          background: AppColors.whiteText,
          error: AppColors.dangerColor,
          onPrimary: AppColors.whiteText,
          onSecondary: AppColors.primary,
          onSurface: AppColors.defaultText,
          onBackground: AppColors.whiteText,
          onError: AppColors.primary,
          brightness: Brightness.light),
      dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSize.radius8)))));
}
