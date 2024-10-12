import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class CustomRatingBarIndicator extends StatelessWidget {
  const CustomRatingBarIndicator(
      {super.key, required this.rating, this.starColor = Colors.amber});
  final double rating;
  final Color starColor;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: dark ? MAppColors.dark : MAppColors.grey,
      itemBuilder: (_, __) => Icon(
        Iconsax.star1,
        color: starColor,
      ),
    );
  }
}
