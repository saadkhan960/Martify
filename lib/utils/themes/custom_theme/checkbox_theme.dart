import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';

class MCheckboxTheme {
  MCheckboxTheme._();

  static CheckboxThemeData lightCheckboxThemeData = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MAppColors.primary;
        } else {
          // return Colors.transparent;
          return Colors.grey[300];
        }
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(color: MAppColors.primary);
        } else {
          return BorderSide(
              color: Colors.grey[600]!); // Light gray for unselected state
        }
      }));

  static CheckboxThemeData darkCheckboxThemeData = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        } else {
          return Colors.black;
        }
      }),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MAppColors.primary;
        } else {
          // return Colors.transparent;
          return Colors.grey[800];
        }
      }),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const BorderSide(color: MAppColors.primary);
        } else {
          return BorderSide(color: Colors.grey[500]!);
        }
      }));
}
