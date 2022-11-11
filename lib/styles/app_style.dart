/*
 * Project Name:  [mKolon3.0] - SalesPortal
 * File: /Users/bakbeom/work/sm/si/salesworxm/lib/styles/app_style.dart
 * Created Date: 2021-11-19 07:54:57
 * Last Modified: 2021-11-19 07:56:03
 * Author: bakbeom
 * Modified By: bakbeom
 * copyright @ 2021  KOLON GROUP. ALL RIGHTS RESERVED. 
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 * 												Discription													
 * ---	---	---	---	---	---	---	---	---	---	---	---	---	---	---	---
 */

import 'package:flutter/material.dart';
import 'package:salesworxm/enums/string_fomate_type.dart';
import 'package:salesworxm/styles/app_size.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text_style.dart';

typedef InstaSize = double Function(double);

class AppStyles {
  static OutlineInputBorder get textfieldBorder => OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 1),
      borderRadius: BorderRadius.circular(AppSize.radius5));
  static InputDecoration textfieldDescription(
          Widget? iconButton, String hint, double hintSize) =>
      InputDecoration(
          enabledBorder: textfieldBorder,
          focusedBorder: textfieldBorder,
          suffixIcon: iconButton,
          hintText: hint,
          isDense: true,
          hintStyle: TextStyle(fontSize: hintSize, color: AppColors.hintText),
          contentPadding: EdgeInsets.fromLTRB(12.w, 15.w, 13.w, 12.w),
          suffixStyle: TextStyle(color: AppColors.primary));

  static text(String data, TextStyle style,
          {int? maxLines,
          TextOverflow? overflow,
          TextAlign? textAlign,
          StringFormateType? type}) =>
      Text(
        type != null ? type.formate(data) : data,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      );
  static ButtonStyle getButtonStyle(Color backgroundColor, Color forgroundColor,
      TextStyle textStyle, double radius,
      {MaterialStateProperty<EdgeInsetsGeometry?>? padding}) {
    return ButtonStyle(
      padding: padding,
      backgroundColor: MaterialStateProperty.all(backgroundColor),
      foregroundColor: MaterialStateProperty.all(forgroundColor),
      textStyle: MaterialStateProperty.all(textStyle),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
    );
  }

  static Widget buildSearchButton(
      BuildContext context, String buttonText, Function callback) {
    return Padding(
        padding: AppSize.customerManagerPageSearchButtonPadding,
        child: AppStyles.buildButton(
            context,
            '$buttonText',
            AppSize.realWith * .55,
            AppColors.lightBlueColor,
            AppTextStyle.color_16(AppColors.blueTextColor),
            AppSize.radius5,
            () => callback.call(),
            isWithBorder: true,
            borderColor: AppColors.blueBorderColor,
            selfHeight: AppSize.secondButtonHeight));
  }

  static Widget buildButton(BuildContext context, String text, double width,
      Color bgColor, TextStyle style, double radius, VoidCallback callback,
      {bool? isLeft,
      bool? isWithBottomRadius,
      double? selfHeight,
      bool? isWithBorder,
      Color? borderColor,
      bool? isOnlyTopBorder}) {
    return InkWell(
      onTap: callback.call,
      child: Container(
          alignment: Alignment.center,
          height: selfHeight ?? AppSize.buttonHeight,
          width: width,
          decoration: BoxDecoration(
              color: bgColor,
              border: isWithBorder != null
                  ? Border.all(
                      color: borderColor!, width: AppSize.defaultBorderWidth)
                  : isOnlyTopBorder != null
                      ? Border(top: BorderSide(color: AppColors.textGrey))
                      : null,
              borderRadius: isLeft != null
                  ? isLeft
                      ? BorderRadius.only(bottomLeft: Radius.circular(radius))
                      : BorderRadius.only(bottomRight: Radius.circular(radius))
                  : isWithBottomRadius != null
                      ? isWithBottomRadius
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(radius),
                              bottomRight: Radius.circular(radius))
                          : null
                      : BorderRadius.all(Radius.circular(radius))),
          child: AppStyles.text('$text', style)),
    );
  }

  static Widget buildPipe(double height) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppSize.defaultListItemSpacing,
          right: AppSize.defaultListItemSpacing),
      child: Container(
          height: height,
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(color: AppColors.tableBorderColor)))),
    );
  }
}
