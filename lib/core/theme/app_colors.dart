import 'package:flutter/material.dart';

class AppColors {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF257889),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xFFA9EDFF),
    onPrimaryContainer: Color(0xFF004E5B),
    secondary: Color(0xFF8DB5CD),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xFFE6F0F4),
    onSecondaryContainer: Color(0xFF334A50),
    tertiary: Color(0xFF23B1C7),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xFFC9E9FD),
    onTertiaryContainer: Color(0xFF187282),
    error: Color(0xFFBA1A1A),
    onError: Color(0xffffffff),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    surfaceDim: Color(0xFFD5DBDD),
    surface: Color(0xFFF7FBFD),
    surfaceBright: Color(0xFFF7FBFD),
    onSurface: Color(0xFF171D1E),
    onSurfaceVariant: Color(0xFF334A50),
    outline: Color(0xFF6F797B),
    outlineVariant: Color(0xFFBFC8CB),
    inverseSurface: Color(0xFF2B3133),
    onInverseSurface: Color(0xFFECF2F4),
    inversePrimary: Color(0xFF84D2E5),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF84D2E5),
    onPrimary: Color(0xFF003640),
    primaryContainer: Color(0xFF004E5B),
    onPrimaryContainer: Color(0xFFA9EDFF),
    secondary: Color(0xFF84AEBE),
    onSecondary: Color(0xFF1C343A),
    secondaryContainer: Color(0xFF1E343D),
    onSecondaryContainer: Color(0xFFCEE7EE),
    tertiary: Color(0xFF71F3FF),
    onTertiary: Color(0xFF282F4D),
    tertiaryContainer: Color(0xFF17545F),
    onTertiaryContainer: Color(0xFFCBEBF5),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surfaceDim: Color(0xFF0E2734),
    surface: Color(0xFF091921),
    surfaceBright: Color(0xFF123242),
    onSurface: Color(0xFFDEE3E5),
    onSurfaceVariant: Color(0xFFBFC8CB),
    outline: Color(0xFF899295),
    outlineVariant: Color(0xFF3F484B),
    inverseSurface: Color(0xFFDEE3E5),
    onInverseSurface: Color(0xFF2B3133),
    inversePrimary: Color(0xFF006879),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static const Color safe = Color(0xFF009933);
  static const Color warning = Color(0xFFFEB600);
  static const Color danger = Color(0xFFE83A3A);

  // Open Button Gradient
  static const darkTealGradient = [Color(0xFF00A8C2), Color(0xFF0F6575)];
  // Close Button Gradient
  static const redGradient = [Color(0xFFE05959), Color(0xFF993939)];
  // Light Slider Gradient
  static const yellowGradient = [Color(0xFFEDDB93), Color(0xFFEDC835)];
  static const greyGradient = [Color(0xFFE0E0E0), Color(0xFFBDBDBD)];
  // Secutiry On
  static const greenGradient = [Color(0xFF4AAA6D), Color(0xFF19722F)];

  static const Color off = Color(0xFF8DB5CD);
}
