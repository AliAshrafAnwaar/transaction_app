import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color.fromARGB(255, 53, 104, 153);
  static const Color mainColor =
      Color.fromARGB(255, 53, 104, 153); // Main color
  static const Color primaryText = Color(0xFF0D0D26); // Primary text color
  static const Color secondaryText = Color.fromARGB(102, 13, 13,
      38); // text color looks like grey ex. let's log in. Apply to jobs ---> located in sign in screen
  static const Color subText = Color(0xFF95969D); // Subtitle text color
  static const Color hintColor = Color.fromARGB(255, 175, 176, 182);
  static const Color myWhite = Color.fromARGB(255, 250, 250, 253);
  static const Color myWhiteBackground =
      const Color.fromARGB(255, 250, 250, 253);
  static const Color myRed = Color.fromARGB(255, 227, 0, 0);
}

ThemeData appTheme = ThemeData(
  //button theme
  colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue, primary: AppColors.primaryBlue),

  //Scaffold Color
  scaffoldBackgroundColor: AppColors.myWhite,

  //appbar theme
  appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mainColor,
      foregroundColor: AppColors.myWhite,
      surfaceTintColor: Colors.transparent,
      centerTitle: true),

  //Text theme
  textTheme: const TextTheme(
    //hint style
    bodySmall: TextStyle(
      color: AppColors.hintColor,
      fontSize: 14,
      fontFamily: 'Poppins',
    ),

    //text for small quote
    bodyMedium: TextStyle(
      color: AppColors.secondaryText,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
    ),

    //error style
    bodyLarge: TextStyle(
        color: AppColors.myRed,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400),

    //normal black text
    headlineMedium: TextStyle(
        color: AppColors.primaryText,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400),

    // company name style
    titleMedium: TextStyle(
      color: AppColors.primaryBlue,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),

    // Title
    titleLarge: TextStyle(
      color: AppColors.primaryText,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),

    //info display
    displayMedium: TextStyle(
      color: AppColors.primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),

    //info titles
    displayLarge: TextStyle(
      color: AppColors.primaryText,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
  ),

  //font
  fontFamily: 'Poppins',

  //pointer theme
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.mainColor, // Change the cursor color to blue
    selectionColor: AppColors.mainColor
        .withOpacity(0.4), // Text selection color (highlight)
    selectionHandleColor: Colors.blue, // The tear drop color
  ),

  cardTheme: CardTheme(
      color: AppColors.mainColor.withOpacity(0.5),
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      margin: const EdgeInsets.only(bottom: 16),
      shadowColor: Colors.transparent),
);
