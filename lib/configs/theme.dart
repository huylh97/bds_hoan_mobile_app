import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeConfig {
  static ThemeData getTheme() {
    ColorScheme? colorScheme = const ColorScheme.light(
      // primary: Color(0xff9C8DEB),
      // secondary: Color(0xff9C8DEB),
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: Colors.white,
      background: Color(0xfffcfcfc),
      error: Colors.red,
    );

    final isDark = colorScheme.brightness == Brightness.dark;
    // final appBarColor = isDark ? colorScheme.surface : colorScheme.background;
    final indicatorColor = isDark ? colorScheme.onSurface : colorScheme.primary;

    return ThemeData(
      fontFamily: 'OpenSans',
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: AppColors.scaffoldBgColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      bottomAppBarColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.background,
      errorColor: colorScheme.error,
      indicatorColor: indicatorColor,
      applyElevationOverlayColor: isDark,
      colorScheme: colorScheme,
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        showUnselectedLabels: true,
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.8,
        space: 0,
      ),
    );
  }

  ///Singleton factory
  static final _instance = ThemeConfig._internal();

  factory ThemeConfig() {
    return _instance;
  }

  ThemeConfig._internal();
}
