import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/sizes.dart';

class MListTileShimmer extends StatelessWidget {
  const MListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            MShimmerLoader(width: 50, height: 50, radius: 50),
            SizedBox(width: MSizes.spaceBtwItems),
            Column(
              children: [
                MShimmerLoader(width: 100, height: 15),
                SizedBox(height: MSizes.spaceBtwItems / 2),
                MShimmerLoader(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
