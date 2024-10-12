import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';

class ImageWithText extends StatelessWidget {
  const ImageWithText(
      {super.key,
      required this.image,
      required this.title,
      this.color = MAppColors.primary,
      this.imageColor = true,
      this.secondTile});
  final String image;
  final String title;
  final String? secondTile;
  final Color color;
  final bool imageColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.asset(
            image,
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: imageColor ? color : null,
          ),
          Text(
            textAlign: TextAlign.center,
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: MSizes.spaceBtwItems),
          if (secondTile != null)
            Text(
              textAlign: TextAlign.center,
              secondTile!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
        ],
      ),
    );
  }
}
