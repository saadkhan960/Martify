import 'package:flutter/material.dart';
import 'package:martify/utils/constants/sizes.dart';

class MSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: MSizes.appBarHeight,
    left: MSizes.defaultSpace,
    right: MSizes.defaultSpace,
    bottom: MSizes.defaultSpace,
  );
}
