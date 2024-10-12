import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';

class MChipTheme {
  MChipTheme._();
  static ChipThemeData lightChipTheme = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: MAppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      checkmarkColor: Colors.white,
      secondarySelectedColor: MAppColors.primary,
      backgroundColor: MAppColors.white,
      brightness: Brightness.light);
  static ChipThemeData darkChipTheme = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: Colors.white),
      selectedColor: MAppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      checkmarkColor: Colors.white,
      secondarySelectedColor: MAppColors.primary,
      backgroundColor: MAppColors.scafoldDark,
      brightness: Brightness.dark);
}
