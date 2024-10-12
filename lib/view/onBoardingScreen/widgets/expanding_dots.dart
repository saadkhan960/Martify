import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/onBoardingPage/onboarding_page_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/device/device_utility.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExpandingDots extends StatelessWidget {
  const ExpandingDots({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocBuilder<OnboardingPageBloc, OnboardingPageState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return Positioned(
            bottom: MDeviceUtility.getBottomNavigationBarHeight() + 25,
            left: MSizes.defaultSpace,
            child: SmoothPageIndicator(
              controller: state.pageController,
              onDotClicked: (index) {
                context
                    .read<OnboardingPageBloc>()
                    .add(DotNavigationClick(index: index));
              },
              count: 3,
              effect: ExpandingDotsEffect(
                  activeDotColor: dark ? MAppColors.white : MAppColors.dark),
            ));
      },
    );
  }
}
