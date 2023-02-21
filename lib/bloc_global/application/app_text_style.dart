import 'package:flutter/material.dart';
import 'package:bds_hoan_mobile/configs/app_colors.dart';

class AppTextStyle {
  static double smallFontSize = 14.0;
  static double normalFontSize = 16.0;
  static double mediumFontSize = 18.0;
  static double largeFontSize = 20.0;
  static double extraLargeFontSize = 23.0;

  /// Specific
  TextStyle appBarTitle = TextStyle(
    color: AppColors.kTextColor,
    fontSize: largeFontSize,
    fontWeight: FontWeight.w700,
  );

  /// Smalll text
  TextStyle small = TextStyle(
      color: AppColors.kTextColor,
      fontSize: smallFontSize,
      fontWeight: FontWeight.normal);
  TextStyle smallBold = TextStyle(
      color: AppColors.kTextColor,
      fontSize: smallFontSize,
      fontWeight: FontWeight.bold);

  /// Nomal text
  TextStyle normal = TextStyle(
      color: AppColors.kTextColor,
      fontSize: normalFontSize,
      fontWeight: FontWeight.w400);
  TextStyle normalItalic = TextStyle(
      color: AppColors.kTextColor,
      fontSize: normalFontSize,
      fontStyle: FontStyle.italic);
  TextStyle normalBold = TextStyle(
      color: AppColors.kTextColor,
      fontSize: normalFontSize,
      fontWeight: FontWeight.w700);
  TextStyle normalWhite = TextStyle(
      color: Colors.white,
      fontSize: normalFontSize,
      fontWeight: FontWeight.normal);
  TextStyle normalPlus1 = TextStyle(
      color: AppColors.kTextColor,
      fontSize: (normalFontSize + 1),
      fontWeight: FontWeight.normal);
  TextStyle normalBoldPlus1 = TextStyle(
      color: AppColors.kTextColor,
      fontSize: (normalFontSize + 1),
      fontWeight: FontWeight.bold);

  /// Medium text
  TextStyle medium = TextStyle(
      color: AppColors.kTextColor,
      fontSize: mediumFontSize,
      fontWeight: FontWeight.normal);
  TextStyle mediumBold = TextStyle(
      color: AppColors.kTextColor,
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold);
  TextStyle mediumWhite = TextStyle(
      color: AppColors.white,
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold);
  TextStyle mediumWhiteWeightNormal = TextStyle(
      color: AppColors.white,
      fontSize: mediumFontSize,
      fontWeight: FontWeight.normal);
  TextStyle mediumBoldPrimaryColor = TextStyle(
      color: AppColors.primary,
      fontSize: mediumFontSize,
      fontWeight: FontWeight.bold);

  /// Large text
  TextStyle large = TextStyle(
      color: AppColors.kTextColor,
      fontSize: largeFontSize,
      fontWeight: FontWeight.normal);
  TextStyle largeBold = TextStyle(
    color: AppColors.kTextColor,
    fontSize: largeFontSize,
    fontWeight: FontWeight.w700,
  );

  TextStyle extraBoldBlack = TextStyle(
      color: Colors.black,
      fontSize: extraLargeFontSize,
      fontWeight: FontWeight.bold);

  TextStyle extraBoldPrimaryColor = TextStyle(
      color: AppColors.primary,
      fontSize: extraLargeFontSize,
      fontWeight: FontWeight.bold);

  /// Specifict widget font size

  static final AppTextStyle _instance = AppTextStyle._internal();

  factory AppTextStyle() {
    return _instance;
  }

  AppTextStyle._internal();
}
