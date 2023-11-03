import 'package:flutter/material.dart';
import 'package:vitkart/utils/theme/custom_theme/appbar_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/bottom_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/chip_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/outline_button_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/text_theme.dart';
import 'package:vitkart/utils/theme/custom_theme/textfield_theme.dart';

class AppTheme {
  AppTheme._();

  //Light Theme
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextThemes.lightTextTheme,
      elevatedButtonTheme: ElevButtonTheme.lightElevatedButtonTheme,
      appBarTheme: OAppBarTheme.lightAppBarTheme,
      bottomSheetTheme: OBottomTheme.lightBottomSheetTheme,
      checkboxTheme: OCheckboxTheme.lightCheckboxTheme,
      chipTheme: OChipTheme.lightChipTheme,
      outlinedButtonTheme: OOutlineButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: OTextFormFieldTheme.lightInputDecorationTheme);

  //Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextThemes.darkTextTheme,
    elevatedButtonTheme: ElevButtonTheme.darkElevatedButtonTheme,
    appBarTheme: OAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: OBottomTheme.darkBottomSheetTheme,
    checkboxTheme: OCheckboxTheme.darkCheckboxTheme,
    chipTheme: OChipTheme.darkChipTheme,
    outlinedButtonTheme: OOutlineButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: OTextFormFieldTheme.darkInputDecorationTheme,
  );
}
