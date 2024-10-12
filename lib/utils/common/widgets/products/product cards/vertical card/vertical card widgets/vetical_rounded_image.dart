import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';

class VerticalRoundedImage extends StatelessWidget {
  const VerticalRoundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = true,
    required this.imageurl,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.borderRadius = MSizes.md,
    this.overlayColor,
    this.shimmerLoaderRadius = 10,
  });

  final double? width, height;
  final String imageurl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? overlayColor;
  final double shimmerLoaderRadius;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor ?? (dark ? MAppColors.dark : MAppColors.light),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageurl,
                  color: overlayColor,
                  fit: fit,
                  progressIndicatorBuilder: (context, url, progress) =>
                      MShimmerLoader(
                    width: width ?? 55,
                    height: height ?? 55,
                    radius: shimmerLoaderRadius,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(imageurl) as ImageProvider,
                ),
        ),
      ),
    );
  }
}
