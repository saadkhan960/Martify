import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/sizes.dart';

class MategoryShimmerLoader extends StatelessWidget {
  const MategoryShimmerLoader({super.key, this.count = 6});
  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: count,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              MShimmerLoader(width: 55, height: 55, radius: 55),
              SizedBox(height: MSizes.spaceBtwItems / 2),
              //Text
              MShimmerLoader(width: 55, height: 8)
            ],
          );
        },
      ),
    );
  }
}
