import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/banner/banner_bloc.dart';
import 'package:martify/utils/common/styles/shimmer_loader.dart';
import 'package:martify/utils/common/widgets/bannerimages/rounded_image.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/image_strings.dart';
import 'package:martify/utils/constants/sizes.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BannerBloc>().add(Fetchbanners(context: context));
    return BlocBuilder<BannerBloc, BannerState>(
      buildWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const MShimmerLoader(width: double.infinity, height: 190);
        }
        if (state.allBanners.isEmpty) {
          return const Center(child: Text("No Banner Found"));
        } else {
          return Column(
            children: [
              CarouselSlider(
                  carouselController: state.carouselController,
                  items: state.allBanners
                      .map((banner) => MRoundedImage(
                            imageurl: banner.imageUrl.isEmpty
                                ? MImages.noProductImage
                                : banner.imageUrl,
                            height: 190,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            isNetworkImage:
                                banner.imageUrl.isEmpty ? false : true,
                            onPressed: () => banner.targetScreen.isNotEmpty
                                ? Navigator.pushNamed(
                                    context, banner.targetScreen)
                                : null,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      context
                          .read<BannerBloc>()
                          .add(ChangeBanner(index: index));
                    },
                  )),
              const SizedBox(height: MSizes.spaceBtwItems),
              DotsIndicator(
                onTap: (index) {
                  context.read<BannerBloc>().add(JumpToBanner(index: index));
                },
                decorator: DotsDecorator(
                  activeColor: MAppColors.primary,
                  color: MAppColors.grey,
                  size: const Size(14.0, 6.0),
                  activeSize: const Size(25.0, 6.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                dotsCount: state.allBanners.length,
                position: state.currentIndex,
              )
            ],
          );
        }
      },
    );
  }
}
