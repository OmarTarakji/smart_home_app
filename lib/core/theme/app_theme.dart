import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  ThemeData get lightTheme => ThemeData(
    colorScheme: AppColors.lightColorScheme,
    brightness: Brightness.light,
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
    textTheme: textTheme.apply(
      bodyColor: AppColors.lightColorScheme.onSurface,
      displayColor: AppColors.lightColorScheme.onSurface,
    ),

    // appBarTheme: AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.dark,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     systemNavigationBarColor: AppColors.lightColorScheme.surface,
    //   ),
    // ),
    popupMenuTheme: PopupMenuThemeData(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      menuPadding: const EdgeInsets.all(0),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme: AppColors.darkColorScheme,
    brightness: Brightness.dark,
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
    textTheme: textTheme.apply(
      bodyColor: AppColors.darkColorScheme.onSurface,
      displayColor: AppColors.darkColorScheme.onSurface,
    ),

    // appBarTheme: AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.light,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //     systemNavigationBarColor: AppColors.darkColorScheme.surface,
    //   ),
    // ),
    popupMenuTheme: PopupMenuThemeData(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      menuPadding: const EdgeInsets.all(0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
