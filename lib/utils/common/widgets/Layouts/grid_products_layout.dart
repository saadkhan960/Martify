import 'package:flutter/material.dart';
import 'package:martify/utils/constants/sizes.dart';

class GridProductsLayout extends StatelessWidget {
  const GridProductsLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 293,
  });
  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: MSizes.gridViewSpacing,
        crossAxisSpacing: MSizes.gridViewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
