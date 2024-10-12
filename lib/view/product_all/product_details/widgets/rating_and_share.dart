import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/Model/product%20model/product_model.dart';
import 'package:martify/utils/common/widgets/products/Favourite%20Icon/fav_icon.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class RatingAndShare extends StatelessWidget {
  const RatingAndShare({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Rating
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(width: MSizes.spaceBtwItems / 4),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '4.7',
                  style: Theme.of(context).textTheme.bodyLarge!.apply(
                      color:
                          dark ? MAppColors.darkModeWhite : MAppColors.black)),
              TextSpan(
                  text: '(199)',
                  style: TextStyle(
                      color:
                          dark ? MAppColors.darkModeWhite : MAppColors.black))
            ]))
          ],
        ),
        Row(
          children: [
            //sahre
            IconButton(
                onPressed: () {},
                icon: Icon(
                  color: dark ? MAppColors.darkModeWhite : MAppColors.black,
                  Icons.share,
                  size: MSizes.iconMd,
                )),
            //add to Whishlist
            FavIcon(
              productId: product.id,
              backgroundColor: false,
            )
          ],
        )
      ],
    );
  }
}
