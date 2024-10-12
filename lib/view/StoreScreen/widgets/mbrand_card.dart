import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_verify.dart';
import 'package:martify/utils/common/widgets/images/circular_image.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';

import 'package:martify/utils/constants/enums.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MBrandCard extends StatelessWidget {
  final bool showBorder;
  final VoidCallback? onTap;
  final Color? borderColor;
  final String brandName;
  final String totalProducts;
  final String? image;

  const MBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    this.borderColor,
    this.brandName = 'Nike',
    this.totalProducts = '256 Products',
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: MRoundedContainer(
        padding: const EdgeInsets.all(MSizes.sm),
        showBorder: showBorder,
        borderColor: borderColor,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //icon
            Flexible(
              child: MCircularImages(
                height: 44,
                width: 44,
                image: (image == null || image!.isEmpty)
                    ? MImages.noProductImage
                    : image!,
                isNetworkImage: true,
                overlayColor:
                    dark ? MAppColors.darkModeWhite : MAppColors.black,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: MSizes.spaceBtwItems / 2),
            // Text
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MBrandTitleWithVerifiedIcon(
                    msainAxisSize: MainAxisSize.min,
                    title: brandName,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    totalProducts.isEmpty
                        ? "0 Products"
                        : "$totalProducts Products",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
