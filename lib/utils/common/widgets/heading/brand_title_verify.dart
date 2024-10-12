import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_text.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/enums.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MBrandTitleWithVerifiedIcon extends StatelessWidget {
  const MBrandTitleWithVerifiedIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = MAppColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
    this.msainAxisSize = MainAxisSize.max,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;
  final MainAxisSize msainAxisSize;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(mainAxisSize: msainAxisSize, children: [
      Flexible(
        child: MBrandTitleText(
          title: title,
          color: textColor ?? (dark ? MAppColors.white : MAppColors.black),
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        ),
      ),
      const SizedBox(width: MSizes.xs),
      Icon(Iconsax.verify5, color: iconColor, size: MSizes.iconXs),
    ]);
  }
}
