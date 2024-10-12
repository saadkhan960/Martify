import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/themes/custom_theme/appbar_theme.dart';
import 'package:martify/utils/themes/custom_theme/bottom_navbar_theme.dart';
import 'package:martify/utils/themes/custom_theme/bottom_sheet_theme.dart';
import 'package:martify/utils/themes/custom_theme/checkbox_theme.dart';
import 'package:martify/utils/themes/custom_theme/chip_theme.dart';
import 'package:martify/utils/themes/custom_theme/elevated_button_theme.dart';
import 'package:martify/utils/themes/custom_theme/outline_button_theme.dart';
import 'package:martify/utils/themes/custom_theme/switch_theme.dart';
import 'package:martify/utils/themes/custom_theme/text_field_theme.dart';
import 'package:martify/utils/themes/custom_theme/text_theme.dart';

class MAppTheme {
  MAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: MAppColors.primary,
    primaryColorLight: MAppColors.primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        0xFF4b68ff, // This is the primary color value
        <int, Color>{
          50: Color.fromARGB(255, 103, 125, 255),
          100: Color.fromARGB(255, 77, 102, 255),
          200: Color.fromARGB(255, 51, 79, 255),
          300: Color.fromARGB(255, 25, 56, 255),
          400: Color.fromARGB(255, 0, 33, 255),
          500: Color.fromARGB(255, 0, 19, 255),
          600: Color.fromARGB(255, 0, 10, 255),
          700: Color.fromARGB(255, 0, 5, 255),
          800: Color.fromARGB(255, 0, 0, 255),
          900: Color.fromARGB(255, 0, 0, 255),
        },
      ),
    ).copyWith(brightness: Brightness.light),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.white,
    textTheme: MTextTheme.lightTextTheme,
    elevatedButtonTheme: MElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: MAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: MBottomSheetTheme.lightBottomSheetThemeData,
    checkboxTheme: MCheckboxTheme.lightCheckboxThemeData,
    chipTheme: MChipTheme.lightChipTheme,
    outlinedButtonTheme: MOutlineButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MTextFormFieldTheme.lightInputDecorationTheme,
    navigationBarTheme: BottomNavbarTheme.lightBottomSheetThemeData,
    switchTheme: CustomSwitchTheme.lightSwitchThemeData,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColorDark: MAppColors.primary,
    primaryColor: MAppColors.primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        0xFF4b68ff, // This is the primary color value
        <int, Color>{
          50: Color.fromARGB(255, 103, 125, 255),
          100: Color.fromARGB(255, 77, 102, 255),
          200: Color.fromARGB(255, 51, 79, 255),
          300: Color.fromARGB(255, 25, 56, 255),
          400: Color.fromARGB(255, 0, 33, 255),
          500: Color.fromARGB(255, 0, 19, 255),
          600: Color.fromARGB(255, 0, 10, 255),
          700: Color.fromARGB(255, 0, 5, 255),
          800: Color.fromARGB(255, 0, 0, 255),
          900: Color.fromARGB(255, 0, 0, 255),
        },
      ),
    ).copyWith(brightness: Brightness.dark),
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: MAppColors.scafoldDark,
    textTheme: MTextTheme.darkTextTheme,
    elevatedButtonTheme: MElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: MAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: MBottomSheetTheme.darkBottomSheetThemeData,
    checkboxTheme: MCheckboxTheme.darkCheckboxThemeData,
    chipTheme: MChipTheme.darkChipTheme,
    outlinedButtonTheme: MOutlineButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MTextFormFieldTheme.darkInputDecorationTheme,
    navigationBarTheme: BottomNavbarTheme.darkBottomSheetThemeData,
    switchTheme: CustomSwitchTheme.darkSwitchThemeData,
  );
}
