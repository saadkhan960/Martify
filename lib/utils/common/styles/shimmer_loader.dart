import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:shimmer/shimmer.dart';

class MShimmerLoader extends StatelessWidget {
  const MShimmerLoader(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color,
      this.baseColor,
      this.highlightColor});
  final double width, height, radius;

  final Color? color, baseColor, highlightColor;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: baseColor ?? (dark ? Colors.grey[850]! : Colors.grey[300]!),
      highlightColor:
          highlightColor ?? (dark ? Colors.grey[700]! : Colors.grey[100]!),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? MAppColors.darkerGrey : MAppColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
