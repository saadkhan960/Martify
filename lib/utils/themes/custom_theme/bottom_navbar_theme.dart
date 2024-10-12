import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';

class BottomNavbarTheme {
//light-----------
  static NavigationBarThemeData lightBottomSheetThemeData =
      NavigationBarThemeData(
    backgroundColor: MAppColors.white,
    indicatorColor: MAppColors.primary.withOpacity(0.1),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: MAppColors.primary, fontSize: 11.5);
        }
        return const TextStyle(color: MAppColors.scafoldDark, fontSize: 11.5);
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: MAppColors.primary);
        }
        return const IconThemeData(color: MAppColors.scafoldDark);
      },
    ),
  );
//dark------------
  static NavigationBarThemeData darkBottomSheetThemeData =
      NavigationBarThemeData(
    backgroundColor: MAppColors.scafoldDark,
    indicatorColor: MAppColors.primary.withOpacity(0.1),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: MAppColors.primary, fontSize: 11.5);
        }
        return const TextStyle(color: MAppColors.darkModeWhite, fontSize: 11.5);
      },
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: MAppColors.primary);
        }
        return const IconThemeData(color: MAppColors.darkModeWhite);
      },
    ),
  );
}
