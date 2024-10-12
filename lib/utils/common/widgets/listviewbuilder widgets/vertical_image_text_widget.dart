import 'package:flutter/material.dart';
import 'package:martify/utils/common/widgets/images/circular_image.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class VerticalImageTextWidget extends StatelessWidget {
  const VerticalImageTextWidget({
    super.key,
    required this.image,
    required this.title,
    this.textColor,
    this.backgroundColor,
    required this.onTap,
    this.iconColor,
    this.isNetworkImage = true,
  });
  final String image, title;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: MSizes.spaceBtwItems),
        child: Column(children: [
          //Circular Icons
          Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: backgroundColor ??
                  (dark ? MAppColors.dark : MAppColors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: MCircularImages(
              overlayColor: dark ? MAppColors.white : MAppColors.black,
              imageBorderRadius: 0,
              image: image,
              backgroundColor: backgroundColor,
              padding: MSizes.sm * 1.4,
              // padding: 0,
              isNetworkImage: isNetworkImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          //Title
          const SizedBox(height: MSizes.spaceBtwItems / 2),
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                  color: textColor ??
                      (dark ? MAppColors.darkModeWhite : MAppColors.white)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
    );
  }
}
