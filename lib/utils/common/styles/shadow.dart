import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';

class MShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: MAppColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7.0,
      offset: const Offset(0, 2));
  static final horizontalProductShadow = BoxShadow(
      color: MAppColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7.0,
      offset: const Offset(0, 2));
}
