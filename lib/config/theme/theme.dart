import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constrant/app_color.dart';

ThemeData theme() {
  return ThemeData.light().copyWith(
    primaryColor: AppColor.primaryColor,
    secondaryHeaderColor: AppColor.secondaryColor,
    // disabledColor: AppColor.disableColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
      elevation: 1.5,
      shadowColor: Colors.white30,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColor.textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColor.subTextColor,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColor.subTextColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColor.subTextColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.textColor,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color: Color(0xff000000),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColor.primaryColor,
      ),
    ),
    colorScheme: ColorScheme(
      primary: AppColor.primaryColor,
      onPrimary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,
      onSecondary: AppColor.secondaryColor,
      error: Colors.black,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
      brightness: Brightness.dark,
    ),
  );
}
