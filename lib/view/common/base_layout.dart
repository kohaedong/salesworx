/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/SalesPortal/lib/view/common/base_widget.dart
 * Created Date: 2021-08-19 11:37:50
 * Last Modified: 2021-12-17 15:59:53
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'dart:io';

import 'package:salesworxm/styles/app_size.dart';
import 'package:salesworxm/view/common/provider/water_marke_provider.dart';
import 'package:flutter/material.dart';
import 'package:salesworxm/styles/app_colors.dart';
import 'package:salesworxm/util/hiden_keybord.dart';
import 'package:provider/provider.dart';

class BaseLayout extends StatelessWidget {
  BaseLayout(
      {required this.child,
      required this.hasForm,
      required this.appBar,
      this.isWithWillPopScope,
      this.isWithBottomSafeArea,
      this.isResizeToAvoidBottomInset,
      this.bgColog,
      Key? key})
      : super(key: key);
  final Widget child;
  final bool hasForm;
  final AppBar? appBar;
  final bool? isWithBottomSafeArea;
  final bool? isResizeToAvoidBottomInset;
  final Color? bgColog;
  final bool? isWithWillPopScope;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: isResizeToAvoidBottomInset ?? true,
        backgroundColor: bgColog ?? AppColors.whiteText,
        appBar: appBar,
        body: isWithWillPopScope != null
            ? WillPopScope(
                child: Stack(
                  children: [
                    SafeArea(
                        bottom: isWithBottomSafeArea ?? false,
                        child: GestureDetector(
                            onTap: () {
                              hasForm
                                  ? Platform.isIOS
                                      ? hideKeyboard(context)
                                      : hideKeyboardForAndroid(context)
                                  : DoNothingAction();
                            },
                            child: child)),
                    Consumer<WaterMarkeProvider>(
                        builder: (context, provider, _) {
                      return provider.isShowWaterMarke
                          ? Positioned(
                              bottom: AppSize.buttonHeight,
                              right: 0,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  child: Text('user Name :  bakboem'),
                                ),
                              ))
                          : Container();
                    })
                  ],
                ),
                onWillPop: () async => false)
            : Stack(
                children: [
                  SafeArea(
                      bottom: isWithBottomSafeArea ?? false,
                      child: GestureDetector(
                          onTap: () {
                            hasForm
                                ? Platform.isIOS
                                    ? hideKeyboard(context)
                                    : hideKeyboardForAndroid(context)
                                : DoNothingAction();
                          },
                          child: child)),
                  Consumer<WaterMarkeProvider>(builder: (context, provider, _) {
                    return provider.isShowWaterMarke
                        ? Positioned(
                            bottom: AppSize.buttonHeight,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                child: Text('user Name :  bakboem'),
                              ),
                            ))
                        : Container();
                  })
                ],
              ));
  }
}
