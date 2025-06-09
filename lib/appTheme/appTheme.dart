// ignore_for_file: file_names, prefer_final_fields, prefer_const_constructors

import 'package:evolesoft_app/utils/appSizes.dart';
import 'package:flutter/material.dart';

class AppThemeClass {
  AppThemeClass._();

  // 🌱 Primary & Accent Colors
  static const Color primaryColor = Color(0xFF00EA71); // Bright green
  static const Color primaryBackground = Color(0xFF9CCEF0); // Soft blue
  static const Color accentColor = Color(0xFF5D2C72); // Purple
  static const Color accentBackground = Color(0xFFFAFAFA); // Light grey

  // 🎨 Background & Text
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFFA3A3A3);
  static const Color textMuted1 = Color(0xFFBDBDBD);
  static const Color textMuted2 = Color(0xFFE0E0E0);
  static const Color textMuted3 = Color(0xFFEBEBEB);

  // 🛑 Status
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;

  // 🌚 Dark Theme Colors
  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Color.fromARGB(255, 54, 45, 45);
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  // 🌞 Light Theme
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
        fontSize: 26,
      ),
      color: Colors.white,
      iconTheme: IconThemeData(color: textPrimary),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: accentBackground,
      onPrimary: primaryBackground,
      onPrimaryContainer: accentColor,
      outline: textPrimary,
      tertiaryContainer: Colors.white,
      onTertiaryContainer: textMuted2,
      background: Colors.white,
      onBackground: backgroundColor,
      error: errorColor,
    ),
    iconTheme: IconThemeData(color: primaryBackground),
    textTheme: _lightTextTheme,
    dividerTheme: DividerThemeData(color: Colors.black12),
  );

  // 🌚 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    appBarTheme: AppBarTheme(
      color: _darkPrimaryVariantColor,
      iconTheme: IconThemeData(color: _darkOnPrimaryColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkPrimaryColor,
      onPrimaryContainer: _darkSecondaryColor,
      background: Colors.white12,
      outline: _darkSecondaryColor,
      tertiaryContainer: Colors.black,
      onTertiaryContainer: _darkPrimaryColor,
      onBackground: Colors.black,
      error: errorColor,
    ),
    iconTheme: IconThemeData(color: primaryBackground),
    textTheme: _darkTextTheme,
    dividerTheme: DividerThemeData(color: Colors.black),
  );

  // 🖋️ Text Themes
  static final TextTheme _lightTextTheme = TextTheme(
    headlineLarge: _headlineLarge,
    headlineMedium: _headlineMedium,
    headlineSmall: _headlineSmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
    labelMedium: _labelMedium,
    labelSmall: _labelSmall,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: _headlineLarge.copyWith(color: _darkOnPrimaryColor),
    headlineMedium: _headlineMedium.copyWith(color: _darkOnPrimaryColor),
    headlineSmall: _headlineSmall.copyWith(
      color: _darkOnPrimaryColor.withOpacity(.8),
    ),
    bodyLarge: _bodyLarge.copyWith(color: _darkOnPrimaryColor),
    bodyMedium: _bodyMedium.copyWith(color: _darkOnPrimaryColor),
    bodySmall: _bodySmall.copyWith(color: _darkOnPrimaryColor),
    labelMedium: _labelMedium.copyWith(color: _darkOnPrimaryColor),
    labelSmall: _labelSmall.copyWith(color: _darkOnPrimaryColor),
  );

  // 🔠 Light Text Styles
  static final TextStyle _headlineLarge = TextStyle(
    fontSize: AppSizes.sizeTwentySix,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    fontFamily: "Roboto",
  );

  static final TextStyle _headlineMedium = TextStyle(
    fontSize: AppSizes.sizeTwenty,
    fontWeight: FontWeight.w500,
    color: textPrimary,
    fontFamily: "Roboto",
  );

  static final TextStyle _headlineSmall = TextStyle(
    fontSize: AppSizes.sizeSixteen,
    fontWeight: FontWeight.w400,
    color: textPrimary.withOpacity(.8),
    fontFamily: "Roboto",
  );

  static final TextStyle _bodyLarge = TextStyle(
    fontSize: AppSizes.sizeSixteen,
    fontWeight: FontWeight.w400,
    color: textPrimary.withOpacity(.6),
    fontFamily: "Roboto",
  );

  static final TextStyle _bodyMedium = TextStyle(
    fontSize: AppSizes.sizeFourteen,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    fontFamily: "Roboto",
  );

  static final TextStyle _bodySmall = TextStyle(
    fontSize: AppSizes.sizeFourteen,
    fontWeight: FontWeight.w400,
    color: textPrimary.withOpacity(.6),
    fontFamily: "Roboto",
  );

  static final TextStyle _labelMedium = TextStyle(
    fontSize: AppSizes.sizeSixteen,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    fontFamily: "Roboto",
  );

  static final TextStyle _labelSmall = TextStyle(
    fontSize: AppSizes.sizeTwelve,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    fontFamily: "Roboto",
  );
}
