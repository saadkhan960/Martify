import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_verify.dart';
import 'package:martify/utils/common/widgets/heading/product_title_text.dart';
import 'package:martify/utils/common/widgets/products/Favourite%20Icon/fav_icon.dart';
import 'package:martify/utils/common/widgets/products/extra%20widgets/productpricetext.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal(
      {super.key,
      required this.imageUrl,
      required this.discountPercentage,
      this.whishlisticonbpress,
      required this.producttitle,
      required this.brandName,
      required this.price,
      this.incressitemButton,
      required this.product});
  final String imageUrl;
  final String discountPercentage;
  final VoidCallback? whishlisticonbpress;
  final String producttitle;
  final String brandName;
  final String price;
  final VoidCallback? incressitemButton;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Container(
        width: 310,
        decoration: BoxDecoration(
          // boxShadow: [MShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MSizes.productImageRadius),
          color: dark
              ? MAppColors.darkerGrey
              : const Color.fromARGB(255, 241, 241, 241),
        ),
        child: Row(
          children: [
            MRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(MSizes.sm),
              backgroundColor: dark ? MAppColors.dark : MAppColors.grey,
              child: Stack(
                children: [
                  //Thumbnail
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: MRoundedImage(
                      imageurl: imageUrl,
                      applyImageRadius: true,
                    ),
                  ),
                  //Sale Tag
                  Positioned(
                    top: 0,
                    left: 0,
                    child: MRoundedContainer(
                      radius: MSizes.sm,
                      backgroundColor: MAppColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: MSizes.sm, vertical: MSizes.xs),
                      child: Text("$discountPercentage%",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: MAppColors.black)),
                    ),
                  ),
                  //Favourite Icon button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavIcon(
                      productId: product.id,
                    ),
                  )
                ],
              ),
            ),
            //Details
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MSizes.sm, top: MSizes.sm, bottom: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MProductTitleText(
                          title: producttitle,
                          smallSize: true,
                        ),
                        const SizedBox(height: MSizes.spaceBtwItems / 2),
                        MBrandTitleWithVerifiedIcon(
                          title: brandName,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: MProductPriceText(price: price)),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                              color: MAppColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(MSizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(MSizes.productImageRadius),
                              ),
                            ),
                            child: const SizedBox(
                              width: MSizes.iconLg * 1.2,
                              height: MSizes.iconLg * 1.2,
                              child: Center(
                                  child: Icon(Iconsax.add,
                                      color: MAppColors.white)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
