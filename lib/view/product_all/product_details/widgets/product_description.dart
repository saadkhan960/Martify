import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/heading/section_heading.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.descriptonText,
    this.showHeading = true,
    this.heading,
    this.minustopSpacing = 0,
  });

  final String descriptonText;
  final String? heading;
  final bool? showHeading;
  final num minustopSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showHeading == true)
          MSectionHeading(
            title: heading!,
            showActionButton: false,
          ),
        SizedBox(height: MSizes.spaceBtwItems - minustopSpacing),
        ReadMoreText(
          descriptonText,
          trimLines: 7,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show more',
          trimExpandedText: 'Show Less',
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: MAppColors.primary,
          ),
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: MAppColors.primary,
          ),
        ),
      ],
    );
  }
}
