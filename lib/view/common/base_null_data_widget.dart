/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/base_null_data_widget.dart
 * Created Date: 2021-09-18 18:25:35
 * Last Modified: 2022-01-21 21:09:08
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2022  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salesworxm/styles/app_style.dart';
import 'package:salesworxm/styles/app_text_style.dart';

class BaseNullDataWidget {
  static Widget build({String? message}) {
    return Center(
        child: message != null
            ? Container(
                alignment: Alignment.center,
                child: AppStyles.text('$message', AppTextStyle.bold_18),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppStyles.text('${tr('no_data')}', AppTextStyle.bold_18),
                  // AppStyles.text(
                  //    '${tr('plz_check_condition')}', AppTextStyle.default_14),
                ],
              ));
  }
}
