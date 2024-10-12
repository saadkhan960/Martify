import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/bloc/Cart/cart_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/widgets/icons/circularicon.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class ProductBottomCard extends StatelessWidget {
  const ProductBottomCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: MSizes.defaultSpace, vertical: MSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? MAppColors.dark : MAppColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(MSizes.cardRadiusLg),
            topRight: Radius.circular(MSizes.cardRadiusLg),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            buildWhen: (previous, current) =>
                previous.quantity != current.quantity,
            builder: (context, state) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (state.quantity > 1) {
                        context
                            .read<ProductBloc>()
                            .add(QuantityChanged(state.quantity - 1));
                      }
                    },
                    child: const MCircularIcon(
                      icon: Iconsax.minus,
                      backgroundColor: MAppColors.primary,
                      width: 40,
                      height: 40,
                      color: MAppColors.white,
                    ),
                  ),
                  const SizedBox(width: MSizes.spaceBtwItems),
                  Text(state.quantity.toString(),
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(width: MSizes.spaceBtwItems),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ProductBloc>()
                          .add(QuantityChanged(state.quantity + 1));
                    },
                    child: const MCircularIcon(
                      icon: Iconsax.add,
                      backgroundColor: MAppColors.primary,
                      width: 40,
                      height: 40,
                      color: MAppColors.white,
                    ),
                  ),
                ],
              );
            },
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddOrUpdateCartItem(
                      image: product.images[0],
                      brandName: state.featuredBrands
                          .firstWhere(
                              (brand) => brand.id == product.brand.toString())
                          .name,
                      context: context,
                      productId: product.id,
                      title: product.title,
                      price: product.salePrice == null
                          ? product.price
                          : product.salePrice!,
                      quantity: state.quantity,
                      size: state.selectedSize ?? "",
                      color: state.selectedColor ?? ""));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(MSizes.md),
                  backgroundColor: MAppColors.primary,
                ),
                child: const Text("Add To Cart"),
              );
            },
          )
        ],
      ),
    );
  }
}
// https://www.veed.io/view/955031b2-f751-4c77-a38c-181bf1bdcc60?panel=download
