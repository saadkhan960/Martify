import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';

class HeaderCircularContainer extends StatelessWidget {
  final double height, width, radius, padding;
  final Color bgColor;
  final Widget? child;
  const HeaderCircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.radius = 400,
    this.padding = 0,
    this.bgColor = MAppColors.white,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: bgColor),
      child: child,
    );
  }
}
