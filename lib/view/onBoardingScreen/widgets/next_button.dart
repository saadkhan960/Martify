import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:martify/bloc/onBoardingPage/onboarding_page_bloc.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/utils/device/device_utility.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return BlocBuilder<OnboardingPageBloc, OnboardingPageState>(
      buildWhen: (previous, current) =>
          previous.currentPageIndex != current.currentPageIndex,
      builder: (context, state) {
        return Positioned(
          bottom: MDeviceUtility.getBottomNavigationBarHeight(),
          right: MSizes.defaultSpace,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                side: BorderSide(
                    color: dark ? MAppColors.primary : MAppColors.black),
                backgroundColor: dark ? MAppColors.primary : MAppColors.black),
            onPressed: () {
              context.read<OnboardingPageBloc>().add(NextPage(context));
            },
            child: state.currentPageIndex == 2
                ? const Icon(Icons.check_rounded)
                : const Icon(Icons.arrow_forward_ios_rounded),
          ),
        );
      },
    );
  }
}
