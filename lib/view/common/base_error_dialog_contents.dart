/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/base_error_dialog_contents.dart
 * Created Date: 2021-10-23 17:18:38
 * Last Modified: 2021-11-19 07:58:27
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salesworxm/enums/image_type.dart';
import 'package:salesworxm/styles/app_image.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/styles/app_style.dart';
import 'package:salesworxm/styles/app_text_style.dart';

class BaseNetworkErrorDialogContents {
  static Widget build() {
    return Column(
      children: [
        AppImage.getImage(ImageType.INFO),
        Padding(padding: EdgeInsets.only(top: AppSize.defaultListItemSpacing)),
        Align(
          alignment: Alignment.center,
          child:
              AppStyles.text('${tr('check_network')}', AppTextStyle.default_16),
        )
      ],
    );
  }
}

class BaseServerErrorDialogContents {
  static Widget build() {
    return Column(
      children: [
        AppImage.getImage(ImageType.INFO),
        Padding(padding: EdgeInsets.only(top: AppSize.defaultListItemSpacing)),
        Align(
          alignment: Alignment.center,
          child:
              AppStyles.text('${tr('server_error')}', AppTextStyle.default_16),
        )
      ],
    );
  }
}
