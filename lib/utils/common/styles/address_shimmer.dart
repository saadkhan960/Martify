import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/sizes.dart';

class AddressShimmer extends StatelessWidget {
  const AddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          MShimmerLoader(width: double.infinity, height: 180),
          SizedBox(height: MSizes.spaceBtwItems),
          MShimmerLoader(width: double.infinity, height: 180),
        ],
      ),
    );
  }
}
