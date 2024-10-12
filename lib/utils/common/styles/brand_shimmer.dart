import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/Layouts/grid_products_layout.dart';

class MBrandShimmer extends StatelessWidget {
  const MBrandShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridProductsLayout(
      mainAxisExtent: 73,
      itemCount: itemCount,
      itemBuilder: (_, __) => const MShimmerLoader(width: 300, height: 80),
    );
  }
}
