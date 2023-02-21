import 'package:flutter/material.dart';

class AppColors {
  // Commmon
  // static const Color primary = Color(0xFF9C8DEB);
  static const Color primary = Color(0xFFFFA300);
  static const Color secondary = Color(0xFFFFA300);
  static const Color third = Color(0xFF1F4761);
  static const Color scaffoldBgColor = Color(0xFFF8F9FD);
  static const Color kTextColor = Color.fromARGB(255, 29, 31, 33);
  static const Color white = Colors.white;
  static const Color redPink = Color.fromRGBO(255, 6, 86, 1);

  // Specific element
  static const Color unSelectedBottomTab = Color(0xFF333333);
  static const Color btnDisableBgColor = Color(0xFFE7E7E7);
  static const Color btnDisableTextColor = Color(0xFFC5C5C5);
  static const Color boxBorder = Color(0xFFE5E9ED);

  // Grey
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyText = Color(0xFF606060);
  static const Color greyAccountIcon = Color(0xFFC5C5C5);

  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();
}
