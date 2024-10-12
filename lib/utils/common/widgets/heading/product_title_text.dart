import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MProductTitleText extends StatelessWidget {
  const MProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });
  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Text(
      title,
      style: smallSize
          ? Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: dark ? MAppColors.darkModeWhite : MAppColors.black)
          : Theme.of(context)
              .textTheme
              .titleSmall!
              .apply(color: dark ? MAppColors.darkModeWhite : MAppColors.black),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
