import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class MCircularImages extends StatelessWidget {
  const MCircularImages(
      {super.key,
      this.width = 56,
      this.height = 56,
      this.overlayColor,
      this.backgroundColor,
      required this.image,
      this.fit = BoxFit.cover,
      this.padding = MSizes.sm,
      this.isNetworkImage = false,
      this.borderRadius = 100,
      this.imageBorderRadius = 100});

  final BoxFit? fit;

  final String image;

  final bool isNetworkImage;

  final Color? overlayColor;

  final Color? backgroundColor;

  final double width, height, padding;
  final double borderRadius;
  final double imageBorderRadius;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color:
              backgroundColor ?? (dark ? MAppColors.black : MAppColors.white),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageBorderRadius),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  color: overlayColor,
                  fit: fit,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const MShimmerLoader(
                    width: 80,
                    height: 80,
                    radius: 80,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image:
                      isNetworkImage ? NetworkImage(image) : AssetImage(image),
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
