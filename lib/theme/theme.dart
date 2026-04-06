import 'package:flutter/material.dart';
import 'package:mnb_mobile/models/theme/theme_data.dart';
import 'package:mnb_mobile/theme/colors.dart';

class CustomTheme {
  Color colorStatus1;
  Color colorStatus2;

  CustomTheme({required this.colorStatus1, required this.colorStatus2});

  factory CustomTheme.dark() {
    return CustomTheme(colorStatus1: Colors.red, colorStatus2: Colors.blue);
  }

  factory CustomTheme.light() {
    return CustomTheme(
      colorStatus1: AppColors.whiteColor,
      colorStatus2: Colors.green,
    );
  }

  static CustomTheme? getCusTheme(AppThemeMode themeMode) {
    switch (themeMode) {
      case AppThemeMode.dark:
        return CustomTheme.dark();
      case AppThemeMode.light:
        return CustomTheme.light();
      case AppThemeMode.system:
        return null;
    }
  }
}

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.pageBackgroundLight,
    colorScheme: const ColorScheme.light(
      surface: AppColors.whiteColor,
      secondary: Colors.redAccent,
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(color: AppColors.whiteColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.textColorPrimaryLight,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.textColorPrimaryLight),
    ),
    textTheme: textTheme(screenHeight: MediaQuery.of(context).size.height),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
    ),
  );
}

TextTheme textTheme({required double screenHeight}) {
  double displayLarge = 28;
  double displayMedium = 22;
  double displaySmall = 18;
  double headlineLarge = 18;
  double headlineMedium = 16;
  double headlineSmall = 14;
  double titleLarge = 14;
  double bodyLarge = 14;
  double bodyMedium = 12;
  double bodySmall = 10;

  if (screenHeight <= 732) {
    displayLarge = 26;
    displayMedium = 20;
    displaySmall = 16;
    headlineLarge = 16;
    headlineMedium = 14.0;
    headlineSmall = 12;
    titleLarge = 14;
    bodyLarge = 14;
    bodyMedium = 12;
    bodySmall = 10;
  }

  if (screenHeight <= 640) {
    displayLarge = 24;
    displayMedium = 18;
    displaySmall = 14;
    headlineLarge = 14;
    headlineMedium = 12.0;
    headlineSmall = 10;
    titleLarge = 14;
    bodyLarge = 14;
    bodyMedium = 12;
    bodySmall = 10;
  }

  return TextTheme(
    displayLarge: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: displayLarge,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: displayMedium,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: displaySmall,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: headlineLarge,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: headlineMedium,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: headlineSmall,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: titleLarge,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: bodyLarge,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: bodyMedium,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: AppColors.textColorPrimaryLight,
      fontSize: bodySmall,
      fontWeight: FontWeight.normal,
    ),
  );
}
