import 'package:flutter/material.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_verify.dart';
import 'package:martify/utils/common/widgets/heading/product_title_text.dart';
import 'package:martify/utils/common/widgets/products/extra%20widgets/productpricetext.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/enums.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/helpers/price_calculator.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData(
      {super.key, required this.product, required this.brand});
  final ProductModel product;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final productsalePriceTag = MPriceCalculator.calculateSalePercentage(
        originalPrice: product.price, salePrice: product.salePrice);
    final productStock = MPriceCalculator.getProductStock(stock: product.stock);
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        product.salePrice != null
            ? Row(
                children: [
                  MProductPriceText(
                    price: product.salePrice.toString(),
                    isLarge: true,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '\$${product.price}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: dark
                              ? MAppColors.darkModeWhite
                              : MAppColors.black,
                        ),
                  ),
                  const SizedBox(width: MSizes.spaceBtwItems),
                  MRoundedContainer(
                    radius: MSizes.sm,
                    backgroundColor: MAppColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: MSizes.sm, vertical: MSizes.xs),
                    child: Text(
                      "$productsalePriceTag%",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: MAppColors.white),
                    ),
                  ),
                ],
              )
            : MProductPriceText(
                price: product.price.toString(),
                isLarge: true,
              ),
        const SizedBox(height: MSizes.spaceBtwItems / 1.5),
        //Title
        MProductTitleText(title: product.title.toString()),
        const SizedBox(height: MSizes.spaceBtwItems / 1.5),

        // Brand
        Row(
          children: [
            Text(
              "Brand:",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                  ),
            ),
            const SizedBox(width: MSizes.spaceBtwItems),
            MBrandTitleWithVerifiedIcon(
              title: brand.name,
              brandTextSize: TextSizes.medium,
              msainAxisSize: MainAxisSize.min,
            )
            // Row(
            //   children: [
            //     MRoundedImage(
            //       imageColor:
            //           dark ? MAppColors.darkModeWhite : MAppColors.black,
            //       imageurl: MImages.nikeLogo,
            //       height: 20,
            //       width: 20,
            //       padding: const EdgeInsets.all(0),
            //     ),
            //     const SizedBox(width: MSizes.sm - 5),
            //     MBrandTitleWithVerifiedIcon(
            //       title: brand.name,
            //       brandTextSize: TextSizes.medium,
            //       msainAxisSize: MainAxisSize.min,
            //     ),
            //   ],
            // )
          ],
        ),
        //Stock Status
        Row(
          children: [
            Text(
              "Status:",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                  ),
            ),
            const SizedBox(width: MSizes.spaceBtwItems),
            Text(
              productStock.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
