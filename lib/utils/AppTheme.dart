import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'AppDialogStyle.dart';
import 'AppTextStyle.dart';

final ThemeData lightTheme = ThemeData(
  listTileTheme: const ListTileThemeData(
    tileColor: white,
    textColor: black,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    dense: true,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: white,
    primary: black,
    secondary: greySecondary,
  ),
  appBarTheme: const AppBarTheme(
    color: white,
    iconTheme: IconThemeData(
      color: blue,
    ),
    titleTextStyle: black16BoldTextStyle,
  ),
  textTheme: const TextTheme(
    bodySmall: black12TextStyle,
    bodyMedium: black12TextStyle,
    bodyLarge: black16TextStyle,
    labelSmall: grey13TextStyle,
    labelMedium: black16TextStyle,
    labelLarge: black16TextStyle,
    titleSmall: black12BoldTextStyle,
    titleMedium: black12BoldTextStyle,
    titleLarge: black16TextStyle,
    displaySmall: grey13TextStyle,
    displayMedium: black16TextStyle,
    displayLarge: black16TextStyle,
    headlineSmall: black12BoldTextStyle,
    headlineMedium: black12BoldTextStyle,
    headlineLarge: black16TextStyle,
  ),
  extensions: const <ThemeExtension<dynamic>>{
    DialogStyle(),
  },
  dividerColor: greySecondary.withOpacity(0.1),
  scaffoldBackgroundColor: white,
);

final ThemeData darkTheme = ThemeData(
  listTileTheme: const ListTileThemeData(
    tileColor: black,
    textColor: white,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    dense: true,
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: white, primary: black, secondary: greySecondary),
  appBarTheme: const AppBarTheme(
    color: black,
    iconTheme: IconThemeData(
      color: blue,
    ),
    titleTextStyle: white16BoldTextStyle,
  ),
  textTheme: const TextTheme(
    bodySmall: white12TextStyle,
    bodyMedium: white12TextStyle,
    bodyLarge: white16TextStyle,
    labelSmall: grey13TextStyle,
    labelMedium: white16TextStyle,
    labelLarge: white16TextStyle,
    titleSmall: white12BoldTextStyle,
    titleMedium: white12BoldTextStyle,
    titleLarge: white16TextStyle,
    displaySmall: grey13TextStyle,
    displayMedium: white16TextStyle,
    displayLarge: white16TextStyle,
    headlineSmall: white12BoldTextStyle,
    headlineMedium: white12BoldTextStyle,
    headlineLarge: white16TextStyle,
  ),
  extensions: const <ThemeExtension<dynamic>>{
    DialogStyle(),
  },
  dividerColor: greySecondary.withOpacity(0.1),
  scaffoldBackgroundColor: black,
);
