import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/product%20model/brand_model.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/utils/common/styles/shadow.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_verify.dart';
import 'package:martify/utils/common/widgets/heading/product_title_text.dart';
import 'package:martify/utils/common/widgets/products/Favourite%20Icon/fav_icon.dart';
import 'package:martify/utils/common/widgets/products/extra%20widgets/productpricetext.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/vetical_rounded_image.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/helpers/price_calculator.dart';
import 'package:martify/view/product_all/product_details/product_details.dart';

class MProductCardVertical extends StatelessWidget {
  const MProductCardVertical(
      {super.key, required this.product, required this.brand});
  final ProductModel product;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    final productsalePriceTag = MPriceCalculator.calculateSalePercentage(
        originalPrice: product.price, salePrice: product.salePrice);
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductDetails page with animation
        MHelperFunctions.simpleAnimationNavigation(
            context,
            ProductDetails(
              product: product,
              brand: brand,
            ));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [MShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MSizes.productImageRadius),
          color: dark ? MAppColors.scafoldDark : MAppColors.white,
        ),
        child: Column(
          children: [
            //---Thumbnail-- sale tag-- Favourite icon
            MRoundedContainer(
              height: 180,
              // padding: const EdgeInsets.all(MSizes.sm),
              backgroundColor: dark ? MAppColors.dark : MAppColors.light,
              child: Stack(
                children: [
                  //thumbnail
                  Center(
                    child: VerticalRoundedImage(
                      padding: const EdgeInsets.all(5),
                      isNetworkImage: product.images.isEmpty ? false : true,
                      height: 180,
                      width: 180,
                      imageurl: product.images.isEmpty
                          ? MImages.noProductImage
                          : product.images[0],
                      applyImageRadius: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                  //Sale Tag
                  if (product.salePrice != null)
                    Positioned(
                      top: 12,
                      left: 5,
                      child: MRoundedContainer(
                        radius: MSizes.sm,
                        backgroundColor: MAppColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: MSizes.sm, vertical: MSizes.xs),
                        child: Text("$productsalePriceTag%",
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
            const SizedBox(height: MSizes.spaceBtwItems / 2),
            //Details
            Padding(
              padding: const EdgeInsets.only(left: MSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems / 2),
                  MBrandTitleWithVerifiedIcon(
                    title: brand.name,
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              /// Price
              product.salePrice != null
                  ? Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sale price
                          Padding(
                            padding: const EdgeInsets.only(left: MSizes.sm),
                            child: Text(
                              "\$${product.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .apply(
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: dark
                                          ? MAppColors.white
                                          : MAppColors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: MSizes.sm),
                            child: MProductPriceText(
                              price: product.salePrice.toString(),
                              isLarge: false,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: MSizes.sm),
                      child: MProductPriceText(
                        price: product.price.toString(),
                        isLarge: false,
                      ),
                    ),
              BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) =>
                    previous.allCartItems != current.allCartItems ||
                    previous.cartItems != current.cartItems,
                builder: (context, state) {
                  int totalQuantity = state.allCartItems
                      .where((item) =>
                          item.productId == product.id) // Filter by product ID
                      .fold(
                          0,
                          (sum, item) =>
                              sum + item.quantity); // Sum the quantities
                  return GestureDetector(
                    onTap: () {
                      context.read<CartBloc>().add(AddOrUpdateCartItem(
                            context: context,
                            image: product.images[0],
                            brandName: brand.name,
                            productId: product.id,
                            title: product.title,
                            price: product.salePrice ?? product.price,
                            quantity: 1,
                            size: (product.sizes != null &&
                                    product.sizes!.isNotEmpty)
                                ? product.sizes![0]
                                : "",
                            color: (product.colors != null &&
                                    product.colors!.isNotEmpty)
                                ? product.colors![0]
                                : "",
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: totalQuantity == 0
                            ? MAppColors.dark
                            : MAppColors.primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(MSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(MSizes.productImageRadius),
                        ),
                      ),
                      child: SizedBox(
                        width: MSizes.iconLg * 1.2,
                        height: MSizes.iconLg * 1.2,
                        child: Center(
                            child: totalQuantity == 0
                                ? const Icon(Iconsax.add,
                                    color: MAppColors.white)
                                : Text(
                                    totalQuantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(color: MAppColors.white),
                                  )),
                      ),
                    ),
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
