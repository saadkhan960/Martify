import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/utils/common/widgets/appbar/appbar.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/constants/text_strings.dart';
import 'package:martify/view/product_all/product_reviews/widgets/progress_indicator_rating.dart';
import 'package:martify/view/product_all/product_reviews/widgets/rating_bar_indicator.dart';
import 'package:martify/view/product_all/product_reviews/widgets/user_review_card.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: CustomAppBar(
        title: Text(
          "Reviews",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //OverAll Rating
              const ProgressIndicatorAndRating(),
              //Star Rating
              const CustomRatingBarIndicator(
                rating: 4.7,
              ),
              const SizedBox(
                height: MSizes.spacerBtwSections,
              ),
              //Description
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  color: MAppColors.primary.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(MTexts.reviewPageDescription),
                    Icon(
                      Iconsax.verify5,
                      color: MAppColors.primary,
                      size: 16,
                    )
                  ],
                ),
              ),

              const SizedBox(height: MSizes.spaceBtwItems),
              //User Review List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard()
            ],
          ),
        ),
      ),
    );
  }
}
