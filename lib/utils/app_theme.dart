import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.mainLightColor,
      unselectedItemColor: AppColors.greyColor,
      selectedLabelStyle: AppStyles.regular12MainlLightColor,
      unselectedLabelStyle: AppStyles.regular12GreyColor,
    ),
    cardColor: AppColors.mainLightColor,
    dividerColor: AppColors.strokeWhiteColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20black,
      headlineMedium: AppStyles.medium18black,
      bodyLarge: AppStyles.regular16GreyColor,
      headlineSmall: AppStyles.semi24MainlLightColor,
      labelMedium: AppStyles.medium16MainlDarkColor,
      labelSmall: AppStyles.medium18MainlLightColor,
      labelLarge: AppStyles.semi14MainlLightColor,
      bodySmall: AppStyles.regular14GreyColor,
      titleLarge: AppStyles.semi20black,
      titleMedium: AppStyles.medium18black,
      titleSmall: AppStyles.medium16black,
      displayMedium: AppStyles.semi20MainlLightColor,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBgColor,
      selectedItemColor: AppColors.mainDarkColor,
      unselectedItemColor: AppColors.greyColor,
      selectedLabelStyle: AppStyles.regular12MainDarkColor,
      unselectedLabelStyle: AppStyles.regular12GreyColor,
    ),
    cardColor: AppColors.mainDarkColor,
    dividerColor: AppColors.mainLightColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20white,
      headlineMedium: AppStyles.medium18white,
      headlineSmall: AppStyles.semi24whiteColor,
      bodyLarge: AppStyles.regular16whiteDarkColor,
      labelMedium: AppStyles.medium16MainlLightColor,
      labelLarge: AppStyles.semi14MainlDarkColor,
      labelSmall: AppStyles.medium18MainlDarkColor,
      bodySmall: AppStyles.regular14whiteDarkColor,
      titleLarge: AppStyles.semi24whiteColor,
      titleMedium: AppStyles.medium18white,
      titleSmall: AppStyles.medium16white,
      displayMedium: AppStyles.semi20MainlDarkColor,
    ),
  );
}
