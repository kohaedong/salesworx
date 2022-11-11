import 'package:flutter/widgets.dart';
import 'app_colors.dart';
import 'app_size.dart';

class AppTextStyle {
  static TextStyle get default_12 => TextStyle(
      fontSize: AppSize.fontSize(12),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText);
  static TextStyle get sub_12 => TextStyle(
      fontSize: AppSize.fontSize(12),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.subText);
  static TextStyle get default_14 => TextStyle(
      fontSize: AppSize.fontSize(14),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText);
  static TextStyle color14(Color color) => TextStyle(
      fontSize: AppSize.fontSize(14),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color);
  static TextStyle get sub_14 => TextStyle(
      fontSize: AppSize.fontSize(14),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.subText);
  static TextStyle get w500_14 => TextStyle(
      fontSize: AppSize.fontSize(14),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.6,
      color: AppColors.subText);
  static TextStyle get w700_14 => TextStyle(
      fontSize: AppSize.fontSize(14),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.6,
      color: AppColors.subText);
  static TextStyle get spacing_14 => TextStyle(
      fontSize: AppSize.fontSize(14),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.subText,
      letterSpacing: -.5);
  static TextStyle get danger_14 => TextStyle(
        fontSize: AppSize.fontSize(14),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColors.dangerColor,
      );
  static TextStyle get w500_16 => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);
  static TextStyle get blod_16 => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);
  static TextStyle get default_16 => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -0.4);
  static TextStyle get spacing_16 => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);
  static TextStyle color_16(Color color) => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color);
  static TextStyle colorW500_16(Color color) => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.4,
      color: color);
  static TextStyle get hint_16 => TextStyle(
      fontSize: AppSize.fontSize(16),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.secondHintColor,
      letterSpacing: -0.3);
  static TextStyle get w500_18 => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -0.4);

  static TextStyle menu_18(Color color) => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color);
  static TextStyle get default_18 => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText);
  static TextStyle color_18(Color color) => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color);
  static TextStyle get hint_18 => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.secondHintColor,
      letterSpacing: -0.3);
  static TextStyle get bold_18 => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -0.4);
  static TextStyle get textField_18 => TextStyle(
      fontSize: AppSize.fontSize(18),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -0.4);
  static TextStyle get w500_20 => TextStyle(
      fontSize: AppSize.fontSize(20),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);

  static TextStyle get default_20 => TextStyle(
      fontSize: AppSize.fontSize(20),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText);
  static TextStyle get bold_20 => TextStyle(
      fontSize: AppSize.fontSize(20),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);
  static TextStyle get bold_22 => TextStyle(
      fontSize: AppSize.fontSize(22),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);
  static TextStyle get w500_22 => TextStyle(
      fontSize: AppSize.fontSize(22),
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.5);
  static TextStyle get blod30 => TextStyle(
      fontSize: AppSize.fontSize(30),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: AppColors.defaultText,
      letterSpacing: -.58);
  static TextStyle bold_20Color(Color color) => TextStyle(
      fontSize: AppSize.fontSize(20),
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      letterSpacing: -0.48,
      color: color);
}
