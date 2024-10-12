import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';
import 'package:martify/utils/constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridProductsLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image
                  MShimmerLoader(width: 180, height: 180),
                  SizedBox(height: MSizes.spaceBtwItems),

                  //Text
                  MShimmerLoader(width: 160, height: 15),
                  SizedBox(height: MSizes.spaceBtwItems),
                  MShimmerLoader(width: 110, height: 15),
                ],
              ),
            ));
  }
}
