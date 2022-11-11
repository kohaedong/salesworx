/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/base_loading_view_on_stack_widget.dart
 * Created Date: 2021-10-20 22:21:27
 * Last Modified: 2021-11-19 08:04:01
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:flutter/material.dart';
import 'package:salesworxm/styles/app_colors.dart';
import 'package:salesworxm/styles/app_size.dart';

class BaseLoadingViewOnStackWidget {
  static build(BuildContext context, bool isLoadData,
      {double? height, double? width, Color? color}) {
    return isLoadData
        ? Builder(builder: (context) {
            return Container(
                height: height ?? AppSize.realHeight,
                width: width ?? AppSize.realWith,
                color: color ?? AppColors.defaultText.withOpacity(.4),
                child: Column(
                  mainAxisAlignment: height != null
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    height != null
                        ? Padding(padding: EdgeInsets.only(top: height * .3))
                        : Container(),
                    SizedBox(
                      height: AppSize.defaultIconWidth * 1.5,
                      width: AppSize.defaultIconWidth * 1.5,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  ],
                ));
          })
        : Container();
  }
}
