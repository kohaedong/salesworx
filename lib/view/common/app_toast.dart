/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/app_toast.dart
 * Created Date: 2021-10-01 14:02:55
 * Last Modified: 2021-12-10 00:06:02
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:salesworxm/styles/app_colors.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/styles/app_style.dart';
import 'package:salesworxm/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  final FToast? fToast;
  factory AppToast() => _sharedInstance();
  static AppToast? _instance;
  AppToast._(this.fToast);
  static AppToast _sharedInstance() {
    if (_instance == null) {
      _instance = AppToast._(FToast());
    }
    return _instance!;
  }

  show(BuildContext context, String str) {
    fToast!.init(context);
    Widget toast = Container(
        alignment: Alignment.center,
        width: AppSize.defaultContentsWidth,
        height: AppSize.buttonHeight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.shadowColor,
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: -6)
            ],
            color: AppColors.textFieldUnfoucsColor,
            borderRadius: BorderRadius.all(Radius.circular(AppSize.radius8))),
        child:
            AppStyles.text('$str', AppTextStyle.color14(AppColors.whiteText)));
    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }
}
