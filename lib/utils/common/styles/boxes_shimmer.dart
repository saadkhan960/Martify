import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/sizes.dart';

class MBoxesShimmer extends StatelessWidget {
  const MBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: MShimmerLoader(width: 150, height: 110)),
            SizedBox(width: MSizes.spaceBtwItems),
            Expanded(child: MShimmerLoader(width: 150, height: 110)),
            SizedBox(width: MSizes.spaceBtwItems),
            Expanded(child: MShimmerLoader(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}
