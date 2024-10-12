import 'package:flutter/material.dart';
import 'package:martify/Model/cart%20model/cart_item_model.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_verify.dart';
import 'package:martify/utils/common/widgets/heading/product_title_text.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MCartItem extends StatelessWidget {
  const MCartItem({
    super.key,
    required this.cartitem,
  });
  final CartItemModel cartitem;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Image
        MRoundedImage(
          imageurl: cartitem.image ?? MImages.noProductImage,
          isNetworkImage: cartitem.image == null ? false : true,
          width: 60,
          height: 60,
          fit: BoxFit.contain,
          padding: const EdgeInsets.all(0),
          bgColor: dark ? MAppColors.dark : MAppColors.light,
        ),
        const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        //Title, Price And Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MBrandTitleWithVerifiedIcon(
                title: cartitem.brandName ?? "",
                msainAxisSize: MainAxisSize.min,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: MProductTitleText(
                  title: cartitem.title,
                  maxLines: 1,
                ),
              ),
              //Attributes
              if (cartitem.color.isNotEmpty || cartitem.size.isNotEmpty)
                Text.rich(
                  TextSpan(
                    children: [
                      if (cartitem.color.isNotEmpty)
                        TextSpan(
                          text: "Color: ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (cartitem.color.isNotEmpty)
                        TextSpan(
                          text: cartitem.color,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      const TextSpan(text: "  "),
                      if (cartitem.size.isNotEmpty)
                        TextSpan(
                          text: "Size: ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (cartitem.size.isNotEmpty)
                        TextSpan(
                          text: cartitem.size,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
