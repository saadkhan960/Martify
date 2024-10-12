import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/heading/brand_title_verify.dart';
import 'package:martify/utils/common/widgets/products/product%20cards/vertical%20card/vertical%20card%20widgets/rounded_container_vertical.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/product_all/product_details/widgets/product_description.dart';
import 'package:martify/view/product_all/product_reviews/widgets/rating_bar_indicator.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(children: [
      //Customer Reply
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(MImages.userProfileImage1),
              ),
              const SizedBox(width: MSizes.spaceBtwItems),
              Text(
                "Jhon Doe",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: dark ? MAppColors.darkModeWhite : MAppColors.black,
              ))
        ],
      ),
      const SizedBox(height: MSizes.spaceBtwItems),
      Row(
        children: [
          const CustomRatingBarIndicator(
            rating: 4.1,
          ),
          const SizedBox(width: MSizes.spaceBtwItems),
          Text(
            "16 Aug, 2024",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      const ProductDescription(
        showHeading: false,
        descriptonText:
            "These shoes are quite comfortable and stylish, making them a great addition to my wardrobe. The cushioning is decent, providing good support for long walks, but they could use a bit more arch support. The design is sleek, and I've received a lot of compliments on them. The only downside is that the sizing runs a bit small, so I recommend ordering a half size up. Overall, they are a solid choice for everyday wear, but there's some room for improvement in the fit and comfort.",
      ),
      const SizedBox(height: MSizes.spaceBtwItems),
      //Brand Reply
      MRoundedContainer(
        backgroundColor: dark ? MAppColors.darkerGrey : MAppColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(MSizes.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MBrandTitleWithVerifiedIcon(
                    title: 'Martify',
                    msainAxisSize: MainAxisSize.min,
                  ),
                  Text("16 Aug, 2024",
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              const ProductDescription(
                descriptonText:
                    "Thanks for your feedback! We're glad you love the style and comfort of the shoes. We appreciate your input on the arch support and sizing—your comments help us improve. If you need any further assistance, we're here to help. Thanks for choosing Martify!",
                showHeading: false,
                minustopSpacing: 6,
              )
            ],
          ),
        ),
      ),
      const SizedBox(height: MSizes.spaceBtwItems),
    ]);
  }
}
