import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/sizes.dart';

class MRoundedImage extends StatelessWidget {
  const MRoundedImage(
      {super.key,
      required this.imageurl,
      this.width = 55,
      this.height = 55,
      this.padding,
      this.imageColor,
      this.bgColor,
      this.applyImageRadius = true,
      this.borderRadius = MSizes.md,
      this.isNetworkImage = false,
      this.overlayColor,
      this.fit,
      this.shimmerLoaderRadius = 10,
      this.onPressed});
  final double width, height;
  final String imageurl;
  final bool applyImageRadius;
  final double borderRadius;
  final double shimmerLoaderRadius;
  // final BoxBorder? border;
  final Color? imageColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final bool isNetworkImage;
  final Color? overlayColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: padding,
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MSizes.md), color: bgColor),
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
                      width: width,
                      height: height,
                      radius: shimmerLoaderRadius,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(
                    image: !isNetworkImage
                        ? AssetImage(imageurl)
                        : NetworkImage(imageurl),
                    fit: BoxFit.contain,
                    color: imageColor,
                  ),
          )),
    );
  }
}
