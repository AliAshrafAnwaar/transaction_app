import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E88E5);
  static const Color onPrimary = Colors.white;
  static const Color secondary = Color(0xFF00897B);
  static const Color onSecondary = Colors.white;
  static const Color background = Color(0xFFF5F5F5);
  static const Color onBackground = Color(0xFF212121);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF0D0D26); // Primary text color
  static const Color secondaryText = Color.fromARGB(102, 13, 13, 38);
  static const Color subText = Color(0xFF95969D); // Subtitle text color
  static const Color hintColor = Color.fromARGB(255, 175, 176, 182);
  static const Color onSurface = Color(0xFF212121);
  static const Color myRed = Color(0xFFD32F2F);
  static const Color onError = Colors.white;
  static const Color primaryContainer = Color(0xFF1565C0);
  static const Color onPrimaryContainer = Colors.white;
  static const Color secondaryContainer = Color(0xFF004D40);
  static const Color onSecondaryContainer = Colors.white;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          error: AppColors.myRed,
          onError: AppColors.onError,
          primaryContainer: AppColors.primaryContainer,
          onPrimaryContainer: AppColors.onPrimaryContainer,
          secondaryContainer: AppColors.secondaryContainer,
          onSecondaryContainer: AppColors.onSecondaryContainer,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primary,
        ));
  }
}
