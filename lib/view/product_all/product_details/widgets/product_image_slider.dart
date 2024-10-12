import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/Product%20Bloc/product_bloc.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/view/product_all/product_details/widgets/full_screen_image_viewer.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.images,
    this.isNetworkImage = false,
    required this.imageLength,
  });

  final List<String> images;
  final bool isNetworkImage;
  final int imageLength;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    final pageController = PageController();
    return GestureDetector(
      onTap: () {
        // Open full-screen image viewer
        MHelperFunctions.simpleNavigation(
            context,
            FullScreenImageViewer(
              images: images,
              initialIndex: context.read<ProductBloc>().state.imageCurrentIndex,
              isNetworkImage: isNetworkImage,
            ));
      },
      child: Container(
        color: dark ? MAppColors.scafoldDark : MAppColors.white,
        child: Stack(
          children: [
            // Product Images as a PageView
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    context.read<ProductBloc>().add(PageChanged(index));
                  },
                  itemBuilder: (context, index) {
                    return isNetworkImage
                        ? CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.contain,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    const MShimmerLoader(
                              width: double.infinity,
                              height: double.infinity,
                              radius: 0,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset(
                            images[index],
                            fit: BoxFit.contain,
                          );
                  },
                ),
              ),
            ),
            // AppBar Icons
            Positioned(
              top: 5,
              left: 10,
              child: Container(
                height: 35,
                width: 40,
                decoration: BoxDecoration(
                  color: MAppColors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero, // Removes default padding
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: dark ? MAppColors.white : MAppColors.black,
                  ),
                ),
              ),
            ),
            if (imageLength != 0)
              Positioned(
                bottom: 10,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                      color: MAppColors.black.withOpacity(0.8),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: DotsIndicator(
                    decorator: DotsDecorator(
                      activeColor: MAppColors.primary,
                      color: MAppColors.grey,
                      size: const Size(8.0, 8.0),
                      activeSize: const Size(10.0, 10.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    dotsCount: imageLength,
                    position:
                        context.watch<ProductBloc>().state.imageCurrentIndex,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
// class ProductImageSlider extends StatelessWidget {
//   const ProductImageSlider({
//     super.key,
//     required this.images,
//     this.isNetworkImage = false,
//     required this.imageLength,
//   });

//   final List<String> images;
//   final bool isNetworkImage;
//   final int imageLength;

//   @override
//   Widget build(BuildContext context) {
//     final dark = MHelperFunctions.isDarkMode(context);
//     final _pageController = PageController();
//     return Container(
//       color: dark ? MAppColors.scafoldDark : MAppColors.white,
//       child: Stack(
//         children: [
//           // Product Images as a PageView
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 0),
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: images.length,
//                 onPageChanged: (index) {
//                   context.read<ProductBloc>().add(PageChanged(index));
//                 },
//                 itemBuilder: (context, index) {
//                   return isNetworkImage
//                       ? CachedNetworkImage(
//                           imageUrl: images[index],
//                           fit: BoxFit.contain,
//                           progressIndicatorBuilder: (context, url, progress) =>
//                               const MShimmerLoader(
//                             width: double.infinity,
//                             height: double.infinity,
//                             radius: 0,
//                           ),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         )
//                       : Image.asset(
//                           images[index],
//                           fit: BoxFit.contain,
//                         );
//                 },
//               ),
//             ),
//           ),
//           // AppBar Icons
//           Positioned(
//             top: 5,
//             left: 10,
//             child: Container(
//               height: 35,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: MAppColors.black.withOpacity(0.5),
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//               ),
//               child: IconButton(
//                 padding: EdgeInsets.zero, // Removes default padding
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 icon: Icon(
//                   Iconsax.arrow_left,
//                   color: dark ? MAppColors.white : MAppColors.black,
//                 ),
//               ),
//             ),
//           ),
//           if (imageLength != 0)
//             Positioned(
//               bottom: 10,
//               right: 8,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: MAppColors.black.withOpacity(0.8),
//                     borderRadius: const BorderRadius.all(Radius.circular(15))),
//                 child: DotsIndicator(
//                   decorator: DotsDecorator(
//                     activeColor: MAppColors.primary,
//                     color: MAppColors.grey,
//                     size: const Size(8.0, 8.0),
//                     activeSize: const Size(10.0, 10.0),
//                     activeShape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   dotsCount: imageLength,
//                   position:
//                       context.watch<ProductBloc>().state.imageCurrentIndex,
//                 ),
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }