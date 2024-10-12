import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MCircularIcon extends StatelessWidget {
  const MCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = MSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });
  final double? width, height, size;
  final IconData icon;

  final Color? color;

  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : dark
                ? MAppColors.black.withOpacity(0.9)
                : MAppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(109),
      ),
      child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}
